import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Item> items = [
    Item(name: 'Pullover', color: 'Black', size: 'L', price: 51, quantity: 0, imageUrl: 'assets/t-shirt1.jpg'),
    Item(name: 'T-Shirt', color: 'Gray', size: 'L', price: 30, quantity: 0, imageUrl: 'assets/t-shirt2.jpg'),
    Item(name: 'Sport Dress', color: 'Black', size: 'M', price: 43, quantity: 0, imageUrl: 'assets/t-shirt3.jpg'),
  ];

  double get totalAmount {
    return items.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          child: Image.asset(item.imageUrl),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text('Color: ${item.color}, Size: ${item.size}', style: TextStyle(color: Colors.grey)),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _buildQuantityButton(
                                      icon: Icons.remove,
                                      onPressed: () {
                                        setState(() {
                                          if (item.quantity > 0) item.quantity--;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 16),
                                    Text('${item.quantity}', style: TextStyle(fontSize: 16)),
                                    SizedBox(width: 16),
                                    _buildQuantityButton(
                                      icon: Icons.add,
                                      onPressed: () {
                                        setState(() {
                                          item.quantity++;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () {},
                              ),
                              SizedBox(height: 8),
                              Text('${item.price}\$', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total amount: ${totalAmount.toStringAsFixed(2)}\$',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Congratulations! Your purchase is successful!'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDB3022),
                    foregroundColor: Colors.white,
                  ),
                  child: Text('CHECK OUT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Color(0xFFF6821F),
        onPressed: onPressed,
      ),
    );
  }
}

class Item {
  final String name;
  final String color;
  final String size;
  final double price;
  int quantity;
  final String imageUrl;

  Item({
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    this.quantity = 0,
    required this.imageUrl,
  });
}
