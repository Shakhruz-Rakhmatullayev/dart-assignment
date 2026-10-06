// ---------------------------------------------------------------------------
// Model
// ---------------------------------------------------------------------------

class Product {
  final String sku;
  final String title;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double price;
  final double? oldPrice;
  final List<String> categories;
  final Map<String, String> specs;
  final String description;

  const Product({
    required this.sku,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.price,
    this.oldPrice,
    required this.categories,
    required this.specs,
    required this.description,
  });
}

const sampleProduct = Product(
  sku: 'NO. 0427',
  title: 'Workshop Stool, Solid Ash',
  imageUrl:
      'https://images.unsplash.com/photo-1503602642458-232111445657?w=1200',
  rating: 4.7,
  reviewCount: 214,
  price: 129.00,
  oldPrice: 160.00,
  categories: [
    'Furniture',
    'Seating',
    'Solid Wood',
    'Kitchen',
    'Studio',
    'Ships Flat',
  ],
  specs: {
    'Material': 'Whitewashed ash',
    'Height': '75 cm',
    'Seat': '34 × 28 cm',
    'Weight': '4.2 kg',
  },
  description:
      'A no-nonsense counter-height stool built from solid ash with a '
      'hand-cut grip slot and steel foot rails. Assembles in ten minutes '
      'with one Allen key.',
);
