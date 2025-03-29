import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartScreen({required this.cartItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedPaymentMethod = ''; // To track the selected payment method

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Order',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),

              // Delivery Address
              Text(
                'Delivery to :',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Street no 90, north city',
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Cart Section
              Text(
                'Cart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.cartItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              padding: EdgeInsets.all(10),
                              child: Image.asset(item['image'], height: 80, width: 120),
                            ),
                            SizedBox(width: 10),

                            // Product Details (Name, Price, Pack Size)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis, // Prevent overflow
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '\$${item['price']}/${item['quantity'] > 1 ? 'Bottle' : 'Pack'}',
                                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                  ),
                                  SizedBox(height: 10),

                                  Align(
                                    alignment: Alignment.centerLeft, // Moves it more to the left
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min, // Ensures it doesn't take full width
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove, color: Colors.red),
                                          onPressed: () {
                                            setState(() {
                                              if (item['quantity'] > 1) {
                                                item['quantity']--;
                                              } else {
                                                widget.cartItems.removeAt(index);
                                              }
                                            });
                                          },
                                        ),
                                        Text(item['quantity'].toString(), style: TextStyle(fontSize: 18)),
                                        IconButton(
                                          icon: Icon(Icons.add, color: Colors.green),
                                          onPressed: () {
                                            setState(() {
                                              item['quantity']++;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),

              // Payment Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 15),

              // Payment Method Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedPaymentMethod = 'Credit Card';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedPaymentMethod == 'Credit Card' 
                            ? Colors.grey[300] 
                            : Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(
                          color: selectedPaymentMethod == 'Credit Card' 
                              ? Colors.transparent 
                              : Colors.grey,
                        ),
                      ),
                      child: Text(
                        'Credit Card',
                        style: TextStyle(fontSize: 16, color: selectedPaymentMethod == 'Credit Card' ? Colors.black : Colors.grey, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedPaymentMethod = 'Grocery Point';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedPaymentMethod == 'Grocery Point' 
                            ? Colors.grey[300] 
                            : Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(
                          color: selectedPaymentMethod == 'Grocery Point' 
                              ? Colors.transparent 
                              : Colors.grey,
                        ),
                      ),
                      child: Text(
                        'Grocery Point',
                        style: TextStyle(fontSize: 16, color: selectedPaymentMethod == 'Grocery Point' ? Colors.black : Colors.grey, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Order Now Button
              Center(
                child: ElevatedButton(
                  onPressed: () {


                    // Show confirmation popup
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Order'),
                          content: Text('Are you sure you want to place the order?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle the order confirmation here
                                Navigator.of(context).pop(); // Close the dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Order placed successfully!')),
                                );
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ),
                          ],
                        );
                      },
                    );





                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Order Now',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
