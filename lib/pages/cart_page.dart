import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context
        .watch<CartProvider>()
        .cart; // optimize using watch to below line.   this line means that continuously watch what changes occured.
    // final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      // scaffold inside scaffold because in home page already scaffold exist and in this we written this scaffold.
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            // used when you want title,subTitle,Icon,
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              radius: 30,
            ),
            trailing: IconButton(
              // delete icon.
              // it is icon widget
              onPressed: () {
                showDialog(
                  //barrierDismissible: false,   if you want user can not touch outside of dialoge.
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Delete Product',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      content: const Text(
                          'Are You Sure You Want to delete the product from cart?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<
                                    CartProvider>() //  only view from this line that's why use read.
                                .removeProduct(cartItem);
                            // Provider.of<CartProvider>(context,
                            //         listen:
                            //             false) // fetch that data ane remove it.
                            //     .removeProduct(cartItem);
                            Navigator.of(context)
                                .pop(); // do nothing just pop dialog box.
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('size: ${cartItem['size']}'),
          );
        },
      ),
    );
  }
}
