import 'package:flutter/material.dart';
import 'package:shop_app/global_variable.dart';
import 'package:shop_app/product_card.dart';
import 'package:shop_app/product_detail_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike','Bata'];

  late String selectedFilter;

   @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }
  @override
  Widget build(BuildContext context) {
     const border = OutlineInputBorder(  // searchbar border.
                        borderSide: BorderSide(  // one side border.
                          color: Color.fromRGBO(225, 225, 225, 1),
                        ),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                        ),
                      );
    return SafeArea(

        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: border,
                      enabledBorder: border,
                      //focusedBorder: border,
                    ),
                  ) 
                ),
              ],
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                    itemCount: filters.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      final filter = filters[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal:8.0
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            }
                          );
                            
                          },
                          child: Chip(   // provide designed label in list view.
                            backgroundColor: selectedFilter == filter 
                            ? Theme.of(context).colorScheme.primary      // use of inherited widget.  // fetch data from theme  directly.(matireal App-> Theme).
                            :const Color.fromRGBO(245, 247, 249, 1),
                            side: const BorderSide(
                              color: Color.fromRGBO(238, 240, 245, 1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            label: Text(
                              filter, 
                              // style: TextStyle(
                              // color: Colors.white,
                              // ),
                            ),
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                      );
            
                    },
                  ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push (  // used to go from home page to product detail page.
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsPage(product: product);
                          },
                        ),
                      );                      
                    },
                    child: ProductCard(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,
                      backgroundColor: index.isOdd ? const Color.fromRGBO(216,240,253,1)
                      :const Color.fromRGBO(245,247,249,1),
                      ),
                  );
                },
              ),
            ),
              
          ],
        ),
      );
  }
}