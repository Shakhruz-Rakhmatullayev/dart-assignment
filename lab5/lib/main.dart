import 'package:flutter/material.dart';
import 'package:lab5/product.dart';
import 'package:lab5/product_screen.dart';
import 'package:lab5/theme.dart';

void main() => runApp(const ProductApp());

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Preview',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.black,
          primary: AppColors.black,
          surface: AppColors.paper,
        ),
        splashFactory: NoSplash.splashFactory,
      ),
      home: const ProductPreviewScreen(product: sampleProduct),
    );
  }
}
