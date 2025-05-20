import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/app_state.dart';
import 'package:travel_app/generated/l10n.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void _editCartItem(BuildContext context, CartItem item) {
    final s = S.of(context);
    final titleController = TextEditingController(text: item.title);
    final subtitleController = TextEditingController(text: item.subtitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(s.editTrip),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: s.tripTitle),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subtitleController,
                decoration: InputDecoration(labelText: s.tripDetails),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(s.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedItem = CartItem(
                  title: titleController.text.trim(),
                  subtitle: subtitleController.text.trim(),
                );
                Provider.of<AppState>(context, listen: false)
                    .updateCartItem(item, updatedItem);
                Navigator.of(context).pop();
              },
              child: Text(s.save),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<AppState>(context).cart;
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.cart),
      ),
      body: cart.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              s.emptyCart,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          return Dismissible(
            key: Key(item.title),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              Provider.of<AppState>(context, listen: false).removeFromCart(item);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.title} ${s.removed}')),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: ListTile(
                title: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.subtitle),
                onTap: () => _editCartItem(context, item), // 👈 Тап по элементу
              ),
            ),
          );
        },
      ),
    );
  }
}
