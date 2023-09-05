import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(  // scaffold inside scaffold because in home page already scaffold exist and in this we written this scaffold.
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context,index){
          final cartItem = cart[index];

          return ListTile(   // used when you want title,subTitle,Icon,
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem['imageUrl'] as String),
              radius: 30,
            ),
            trailing: IconButton(  // it is icon widget
              onPressed: () {}, 
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