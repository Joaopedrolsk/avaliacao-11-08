import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'pages/product_page.dart';
import 'controllers/cart_controller.dart';

//
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const product = Product(
      name: 'Camiseta +DevsEcomm',
      price: 129.90,
      icon: 'checkroom',
      availableSizes: ['P', 'M', 'G'],
    );

    return MaterialApp(
      title: 'DevsEcomm',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ProductPage(product: product),
    );
  }
}
