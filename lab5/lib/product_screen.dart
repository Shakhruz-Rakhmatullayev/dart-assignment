import 'package:flutter/material.dart';
import 'package:lab5/product.dart';
import 'package:lab5/theme.dart';

// ---------------------------------------------------------------------------
// Screen
// ---------------------------------------------------------------------------

class ProductPreviewScreen extends StatefulWidget {
  final Product product;
  const ProductPreviewScreen({super.key, required this.product});

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen> {
  bool _bookmarked = false;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      // Sticky action bar: stays pinned while the content scrolls.
      bottomNavigationBar: BottomActionBar(
        price: p.price,
        quantity: _quantity,
        onAdd: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: AppColors.black,
                shape: const RoundedRectangleBorder(),
                content: Text(
                  '+$_quantity  ${p.title.toUpperCase()}  → CART',
                  style: mono(12, color: AppColors.paper),
                ),
              ),
            );
        },
        onQuantityChanged: (q) => setState(() => _quantity = q),
      ),
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Adaptive: on wide screens show image and details side by side.
            final isWide = constraints.maxWidth >= 720;

            final cover = CoverImage(
              imageUrl: p.imageUrl,
              bookmarked: _bookmarked,
              discountPercent: p.oldPrice == null
                  ? null
                  : ((1 - p.price / p.oldPrice!) * 100).round(),
              onBookmark: () => setState(() => _bookmarked = !_bookmarked),
            );
            final details = ProductDetails(product: p);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopBar(sku: p.sku),
                Expanded(
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: cover,
                              ),
                            ),
                            const VerticalDivider(
                              width: 2,
                              thickness: 2,
                              color: AppColors.black,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(20),
                                child: details,
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              cover,
                              const SizedBox(height: 20),
                              details,
                            ],
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final String sku;
  const TopBar({super.key, required this.sku});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(border: Border(bottom: rule)),
      child: Row(
        children: [
          TextButton(
            onPressed: () => Navigator.maybePop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.black,
              shape: const RoundedRectangleBorder(),
            ),
            child: Text('← BACK', style: mono(13, weight: FontWeight.w700)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                'CATALOGUE / $sku',
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: mono(12, color: AppColors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Cover image with Stack + bookmark badge
// ---------------------------------------------------------------------------

class CoverImage extends StatelessWidget {
  final String imageUrl;
  final bool bookmarked;
  final int? discountPercent;
  final VoidCallback onBookmark;

  const CoverImage({
    super.key,
    required this.imageUrl,
    required this.bookmarked,
    required this.discountPercent,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(border: Border.fromBorderSide(rule)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              alignment: const Alignment(0, -0.2),
              loadingBuilder: (context, child, progress) => progress == null
                  ? child
                  : Center(child: Text('LOADING…', style: mono(12))),
              errorBuilder: (context, error, stack) => Center(
                child: Text(
                  '[ NO IMAGE ]',
                  style: mono(12, color: AppColors.grey),
                ),
              ),
            ),

            // Figure label
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                color: AppColors.paper,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Text('FIG. 01', style: mono(11)),
              ),
            ),

            // Bookmark badge — square tile flush with the corner
            Positioned(
              top: 0,
              right: 0,
              child: Tooltip(
                message: bookmarked ? 'Remove bookmark' : 'Bookmark',
                child: InkWell(
                  onTap: onBookmark,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: bookmarked ? AppColors.signal : AppColors.black,
                      border: const Border(left: rule, bottom: rule),
                    ),
                    child: Icon(
                      bookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: bookmarked ? AppColors.black : AppColors.paper,
                    ),
                  ),
                ),
              ),
            ),

            // Discount stamp
            if (discountPercent != null)
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.signal,
                    border: Border(top: rule, right: rule),
                  ),
                  child: Text(
                    '−$discountPercent%',
                    style: const TextStyle(
                      fontFamily: displayFont,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppColors.black,
                      height: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Title, rating, price (Row) and category badges (Wrap)
// ---------------------------------------------------------------------------

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title — wraps to max 3 lines, never overflows horizontally.
        Text(
          product.title.toUpperCase(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: displayFont,
            fontSize: 34,
            height: 0.95,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 16),

        // Rating + price row. Rating side is Flexible so the price never
        // gets pushed off-screen on narrow devices.
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            border: Border(top: rule, bottom: rule),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: StarRating(
                  rating: product.rating,
                  reviewCount: product.reviewCount,
                ),
              ),
              const SizedBox(width: 12),
              PriceTag(price: product.price, oldPrice: product.oldPrice),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Category badges — Wrap flows onto new lines instead of overflowing.
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (var i = 0; i < product.categories.length; i++)
              CategoryBadge(label: product.categories[i], filled: i == 0),
          ],
        ),
        const SizedBox(height: 24),

        // Spec table
        Text('SPECIFICATIONS', style: mono(11, color: AppColors.grey)),
        const SizedBox(height: 6),
        for (final e in product.specs.entries)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(border: Border(top: hairline)),
            child: Row(
              children: [
                Expanded(child: Text(e.key.toUpperCase(), style: mono(12))),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    e.value,
                    textAlign: TextAlign.right,
                    style: mono(12, weight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        Container(
          padding: const EdgeInsets.only(top: 14),
          decoration: const BoxDecoration(border: Border(top: hairline)),
          child: Text(
            product.description,
            style: const TextStyle(
              fontFamily: displayFont,
              fontSize: 15,
              height: 1.45,
              color: AppColors.black,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class CategoryBadge extends StatelessWidget {
  final String label;
  final bool filled;
  const CategoryBadge({super.key, required this.label, this.filled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: filled ? AppColors.black : Colors.transparent,
        border: Border.all(color: AppColors.black, width: 1.5),
      ),
      child: Text(
        label.toUpperCase(),
        style: mono(11, color: filled ? AppColors.paper : AppColors.black),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final int reviewCount;
  const StarRating({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    final stars = <Widget>[];
    for (var i = 1; i <= 5; i++) {
      final IconData icon;
      if (rating >= i) {
        icon = Icons.star_sharp;
      } else if (rating >= i - 0.5) {
        icon = Icons.star_half_sharp;
      } else {
        icon = Icons.star_border_sharp;
      }
      stars.add(Icon(icon, color: AppColors.black, size: 18));
    }

    // Wrap (not Row) so that the review count drops below the stars
    // on very narrow screens instead of overflowing.
    return Wrap(
      direction: Axis.vertical,
      spacing: 4,
      children: [
        // FittedBox shrinks the stars if even they don't fit the width.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(mainAxisSize: MainAxisSize.min, children: stars),
        ),
        Text(
          '${rating.toStringAsFixed(1)}/5 — $reviewCount REVIEWS',
          style: mono(11, color: AppColors.grey),
        ),
      ],
    );
  }
}

class PriceTag extends StatelessWidget {
  final double price;
  final double? oldPrice;
  const PriceTag({super.key, required this.price, this.oldPrice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (oldPrice != null)
          Text(
            'WAS \$${oldPrice!.toStringAsFixed(0)}',
            style: mono(
              11,
              color: AppColors.grey,
            ).copyWith(decoration: TextDecoration.lineThrough),
          ),
        Text(
          '\$${price.toStringAsFixed(0)}',
          style: const TextStyle(
            fontFamily: displayFont,
            fontSize: 40,
            height: 1,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.5,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Sticky bottom action bar — "Add to Cart" fills remaining width via Expanded
// ---------------------------------------------------------------------------

class BottomActionBar extends StatelessWidget {
  final double price;
  final int quantity;
  final VoidCallback onAdd;
  final ValueChanged<int> onQuantityChanged;

  const BottomActionBar({
    super.key,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.paper,
        border: Border(top: rule),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 56,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Quantity stepper — three bordered cells
                _StepCell(
                  label: '−',
                  onTap: quantity > 1
                      ? () => onQuantityChanged(quantity - 1)
                      : null,
                ),
                Container(
                  width: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(top: rule, bottom: rule),
                  ),
                  child: Text(
                    '$quantity',
                    style: mono(16, weight: FontWeight.w700),
                  ),
                ),
                _StepCell(
                  label: '+',
                  onTap: () => onQuantityChanged(quantity + 1),
                ),
                const SizedBox(width: 10),

                // Add to Cart takes ALL remaining width.
                Expanded(
                  child: Material(
                    color: AppColors.black,
                    child: InkWell(
                      onTap: onAdd,
                      highlightColor: AppColors.signal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            // FittedBox scales the label down instead of
                            // overflowing on very small screens.
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Add to Cart'.toUpperCase(),
                                  semanticsLabel: 'Add to Cart',
                                  style: mono(
                                    15,
                                    color: AppColors.paper,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '\$${(price * quantity).toStringAsFixed(0)} →',
                                  style: mono(
                                    15,
                                    color: AppColors.signal,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepCell extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _StepCell({required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: Border.fromBorderSide(rule)),
        child: Text(
          label,
          style: mono(
            18,
            weight: FontWeight.w700,
            color: onTap == null ? AppColors.grey : AppColors.black,
          ),
        ),
      ),
    );
  }
}
