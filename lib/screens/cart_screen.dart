// cart_screen.dart
import 'package:flutter/material.dart';
import 'cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void changeQuantity(int index, int delta) {
    setState(() {
      int currentQty = cartItems[index]['quantity'] ?? 1;
      int newQty = currentQty + delta;
      cartItems[index]['quantity'] = newQty < 1 ? 1 : newQty;
    });
  }

  //function of remove Items
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  //Price Calculation
  double get subtotal {
    double total = 0.0;

    for (var item in cartItems) {
      //total += (item['price'] ?? 0) * (item['quantity'] ?? 1);

      for (int i = 1; i <= (item['quantity'] ?? 1); i++) {
        
        
        if(i==3){
          total = total + (item['price'] ?? 0)/2;
        }
        else{
          total = total + (item['price'] ?? 0);
        }
      }
    }
    return total;
  }

  double get taxAndFees => subtotal * 0.1945; //19.45% tax on subtotal
  double get delivery => 1.00;
  double get total => subtotal + taxAndFees + delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4E9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text("Cart",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(item['image'],
                              width: 70, height: 70, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(item['title'] ?? '',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        Text(item['description'] ?? '',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close, color: Colors.red),
                                    onPressed: () => removeItem(index),
                                  )
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Text("\$${item['price']}",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red)),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () => changeQuantity(index, -1),
                                      child: Icon(Icons.remove,
                                          size: 20, color: Colors.red),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text('${item['quantity'] ?? 1}',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () => changeQuantity(index, 1),
                                      child: Icon(Icons.add,
                                          size: 20, color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Promo Code",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFF7750),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("Apply",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  buildPriceRow("Subtotal", subtotal),
                  buildPriceRow("Tax and Fees", taxAndFees),
                  buildPriceRow("Delivery", delivery),
                  Divider(),
                  buildPriceRow("Total (${cartItems.length} items)", total,
                      isTotal: true),
                  SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF7750),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Checkout pressed!")),
                      );
                    },
                    child: Text(
                      "CHECKOUT",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPriceRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text("\$${value.toStringAsFixed(2)} USD",
              style: TextStyle(
                  fontSize: isTotal ? 16 : 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
