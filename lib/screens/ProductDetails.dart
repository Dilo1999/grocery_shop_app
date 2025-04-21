import 'package:flutter/material.dart';
import 'cart.dart';
import 'cart_screen.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 1;
  int? selectedAddOnIndex;

  final List<Map<String, dynamic>> addOns = [
    
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product['image'],
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: BackButton(color: Colors.black),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.favorite_border, color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                product['title'],
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  SizedBox(width: 5),
                  Text("4.5 (30+)", style: TextStyle(fontSize: 14)),
                  SizedBox(width: 10),
                  Text("See Review", style: TextStyle(color: Colors.orange)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product['price']}",
                    style: const TextStyle(fontSize: 24, color: Color(0xFFFF4F40), fontWeight: FontWeight.bold),
                  ),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () => setState(() => quantity = (quantity > 1) ? quantity - 1 : 1),
                        icon: const Icon(Icons.remove_circle_outline),
                        color: Color(0xFFFF4F40),
                      ),
                      Text(quantity.toString().padLeft(2, '0'),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add_circle_outline),
                        color: Color(0xFFFF4F40),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 32),
              Text(
                product['description'],
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 10),

             
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  final updatedProduct = {
                    ...product,
                    'quantity': quantity,
                    'selected': true,
                    'addOn': selectedAddOnIndex != null ? addOns[selectedAddOnIndex!] : null,
                  };

                  addToCart(updatedProduct);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF4F40),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                icon: const Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                label: const Text("ADD TO CART",
                style: TextStyle(fontSize: 16, color: Colors.white), // Set color to white
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
