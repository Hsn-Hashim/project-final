import 'package:flutter/material.dart';
import 'package:project_final/service/cart.dart'; 

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double sum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("السلة"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: myCart.isEmpty
          ? const Center(
              child: Text(
                "السلة فاضية",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: myCart.length,
              itemBuilder: (context, index) {
                final coffee = myCart[index];
                sum += myCart[index].price!;
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.network(
                      coffee.image ?? "",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => const Icon(Icons.coffee),
                    ),
                    title: Text(coffee.name ?? "بدون اسم"),
                    subtitle: Text("${coffee.price ?? 0} ريال"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          myCart.removeAt(index); 
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}