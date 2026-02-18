import 'package:flutter/material.dart';
import 'package:project_final/models/coffee.dart';
import 'package:project_final/service/cart.dart';

class DetailsScreen extends StatelessWidget {
  final Coffee model;
  const DetailsScreen({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(model.name ?? "No name"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            ClipRRect(child: Image.network(model.image!)),
            Text("${model.price}"),
            ElevatedButton(
              onPressed: () {
                myCart.add(model);
                print(myCart.length);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("تمت إضافة ${model.name} للسلة 🛒"),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
