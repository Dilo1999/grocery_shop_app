import 'package:flutter/material.dart';
import 'cartScreen.dart';

class ProductScreen extends StatefulWidget {
  final String username;

  ProductScreen({required this.username});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Map<String, dynamic>> cartItems = [];
  String? selectedCategory;
  String? selectedProduct;

  void addToCart(String name, double price, String image) {
    setState(() {
      int index = cartItems.indexWhere((item) => item['name'] == name);
      if (index != -1) {
        cartItems[index]['quantity']++;
      } else {
        cartItems.add({'name': name, 'price': price, 'image': image, 'quantity': 1});
      }

      // Show "Added to cart" message for 2 seconds
      selectedProduct = name;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        selectedProduct = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Hello',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 1),
                Text(
                  widget.username,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Category',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 0),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3,
                  children: [
                    _buildCategoryButton('Vegetables'),
                    _buildCategoryButton('Meats'),
                    _buildCategoryButton('Beverages'),
                    _buildCategoryButton('Fruits'),
                    _buildCategoryButton('Snacks'),
                    _buildCategoryButton('Breads'),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Promos ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        _buildPromoItem('Potato Chips', 4.5, 'assets/images/Product1.png'),
                        SizedBox(height: 0),
                        _buildPromoItem('Orange Juice', 1.5, 'assets/images/Product2.png'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 35,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.shopping_cart, color: Colors.white),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text) {
    bool isSelected = selectedCategory == text;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedCategory = isSelected ? null : text;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }




  Widget _buildPromoItem(String name, double price, String imagePath) {
    return Stack(
      children: [
        Image.asset(imagePath, height: 150),
        Positioned(
          bottom: 10,
          top: 80,
          right: 10,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => addToCart(name, price, imagePath),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 15,
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
              if (selectedProduct == name)
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Added to cart',
                    style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  
}
