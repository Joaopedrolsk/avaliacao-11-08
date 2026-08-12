import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';

class Carrinho extends StatelessWidget {
  const Carrinho({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cart, _) {
        final quantidade = cart.items.length;

        return IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart, size: 28),

              if (quantidade > 0)
                Positioned(
                  right: -8,
                  top: -8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$quantidade',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          onPressed: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return Consumer<CartController>(
                  builder: (context, cart, _) {
                    return AlertDialog(
                      title: const Row(
                        children: [
                          Icon(Icons.shopping_cart),
                          SizedBox(width: 8),
                          Text('Minha sacola'),
                        ],
                      ),

                      content: cart.items.isEmpty
                          ? const SizedBox(
                              width: double.maxFinite,
                              child: Text('Sua sacola está vazia.'),
                            )
                          : SizedBox(
                              width: double.maxFinite,
                              height: 320,
                              child: ListView.builder(
                                itemCount: cart.items.length,
                                itemBuilder: (context, index) {
                                  final item = cart.items[index];

                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.checkroom, size: 40),

                                          const SizedBox(width: 10),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.product.name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                const SizedBox(height: 4),

                                                Text('Tamanho: ${item.size}'),

                                                Text(
                                                  'Quantidade: ${item.quantity}',
                                                ),

                                                Text(
                                                  'R\$ ${item.product.price.toStringAsFixed(2)}',
                                                ),
                                              ],
                                            ),
                                          ),

                                          IconButton(
                                            onPressed: () {
                                              cart.removeItem(item);
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: const Text('Fechar'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
