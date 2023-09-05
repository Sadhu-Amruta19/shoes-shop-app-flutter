import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String,Object> product;  // statefull class can not access directly write widget.product...
  const ProductDetailsPage({
    super.key,
    required this.product,
    });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize!=0) {
      Provider.of<CartProvider>(context, listen: false)   // this context provide by State.
          .addProduct(
            {
              'id': widget.product['id'],
              'title':widget.product['title'],
              'price':widget.product['price'],
              'imageUrl':widget.product['imageUrl'],
              'company':widget.product['company'],
              'size':selectedSize,
            },
          ); // type of provider is cartProvider.  // add product in cart.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: 
              Text('Product added succesfully'),
            ),
          );
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a size!'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(widget.product['imageUrl'] as String),
              ),
            const Spacer(flex: 2),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(245,247,249,1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$${widget.product['price']}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,  // item counted from product sizes and  size in the form of list type of double.
                      itemBuilder: (context,index){
                        final size = (widget.product['sizes'] as List<int>)[index];  // get one by one sizes.
                  
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            child: Chip(
                              label: Text(size.toString()),
                              backgroundColor: selectedSize == size 
                              ? Theme.of(context).colorScheme.primary
                              :null,  // null mean default color that we given.
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        onTap();
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity,50),
                      ),
                      // child: ElevatedButton.icon(
                      //   onPressed: () {},
                      //   icon: Icons.shopping_cart,
                      //   label: label),
                      child: const Text('Add To Cart', style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),)
                    ),
                  ),
                ],
              ),
            )
            
        ],
      ),
    );
  }
}