import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'productDetails.dart';




class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}





class _SearchScreenState extends State<SearchScreen> {

  //State Variables
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool _isLoading = false;


  //Product Fetching Logic
  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'https://fakestoreapi.com/products';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _products = json.decode(response.body);
          _filteredProducts = _products;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching products')),
      );
    }
  }




  //Search Filtering Logic
  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products.where((product) {
          final title = product['title'].toLowerCase();
          final category = product['category'].toLowerCase();
          return title.contains(query.toLowerCase()) ||
              category.contains(query.toLowerCase());
        }).toList();
      }
    });
  }




  //initState
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }



  //UI Part
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Find Products'),
        elevation: 0,
        backgroundColor: Colors.deepOrange,
      ),



      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [


            //Search Input Field
            TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(

                hintText: 'Search products by title or category...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),



            const SizedBox(height: 16),
            _isLoading
                ? const Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: _filteredProducts.isEmpty

                        ? const Center(child: Text("No products found."))
                        : RefreshIndicator(
                            onRefresh: _fetchProducts,
                            child: ListView.separated(
                              itemCount: _filteredProducts.length,
                              separatorBuilder: (context, _) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final product = _filteredProducts[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetails(product: product),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),




                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                              product['image'],
                                              width: 60,
                                              height: 60,
                                              fit: BoxFit.cover,
                                            ),
                                          ),




                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  product['title'],
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),




                                                const SizedBox(height: 4),
                                                Text(
                                                  "\$${product['price']}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepOrange,
                                                  ),
                                                ),




                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),




          ],

        ),
      ),
    );
  }
}
