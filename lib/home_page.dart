import 'package:flutter/material.dart';
import 'package:shop_app/cart_page.dart';

import 'package:shop_app/product_list.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  int currentPage = 0;

  List<Widget> pages = const [ProductList(), CartPage()]; 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      // body: currentPage == 0 ? ProductList() : CartPage(),  // simple when cart clicked then goes to cart page else 
      // body: currentPage == 0 ? ProductList() : CartPage(),
      body: IndexedStack(  // give index to screen whatever screen we stoped again get that.
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,  // give icon size.
        selectedFontSize: 0,  // navigation size make small.
        unselectedFontSize: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',  // when you use BottomNavigationBarItem it is necessary to give label it's ok is empty but need to declare atleast. 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
        ],
      ),
    );
  } 
}