import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/section_title.dart';
import '../widgets/size_selector.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/price_summary.dart';
import '../widgets/add_to_bag_button.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductController(product: product),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F1F6),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9F1F6),
          title: Text(
            product.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Consumer<ProductController>(
                  builder: (context, controller, _) {
                    return ProductCard(
                      productName: product.name,
                      price: product.price,
                      icon: product.icon,
                      isFavorite: controller.isFavorite,
                      onFavoriteToggle: () => controller.toggleFavorite(),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const SectionTitle(title: 'Tamanho'),
                const SizedBox(height: 12),
                Consumer<ProductController>(
                  builder: (context, controller, _) {
                    return SizeSelector(
                      sizes: product.availableSizes,
                      selectedSize: controller.selectedSize,
                      onSizeSelected: (size) => controller.selectSize(size),
                    );
                  },
                ),
                const SizedBox(height: 28),
                const SectionTitle(title: 'Quantidade'),
                const SizedBox(height: 12),
                Consumer<ProductController>(
                  builder: (context, controller, _) {
                    return QuantitySelector(
                      quantity: controller.quantity,
                      onIncrement: () => controller.incrementQuantity(),
                      onDecrement: () => controller.decrementQuantity(),
                    );
                  },
                ),
                const SizedBox(height: 28),
                Consumer<ProductController>(
                  builder: (context, controller, _) {
                    return PriceSummary(subtotal: controller.getSubtotal());
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Consumer<ProductController>(
              builder: (context, controller, _) {
                return AddToBagButton(
                  isEnabled: controller.quantity > 0,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Adicionado ${controller.quantity} ${product.name} (tamanho ${controller.selectedSize}) à sacola!',
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
