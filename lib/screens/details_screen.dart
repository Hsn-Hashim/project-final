import 'package:flutter/material.dart';
import 'package:project_final/models/coffee.dart';
import 'package:project_final/service/cart.dart'; 

class DetailsScreen extends StatelessWidget {
  final Coffee model;
  const DetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, shadows: [
          Shadow(color: Colors.black, blurRadius: 20) 
        ]),
      ),
      body: Column(
        children: [
          
          Expanded(
            flex: 4, 
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                model.image ?? "",
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  color: Colors.brown[100],
                  child: const Icon(Icons.coffee, size: 100, color: Colors.brown),
                ),
              ),
            ),
          ),

          
          Expanded(
            flex: 5, 
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)), 
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 25),

                  Text(
                    model.name ?? "بدون اسم",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "${model.price} ريال",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                 
                  const Text(
                    "استمتع بالمذاق  الأصلي المحضر من أجود المكونات. طعم يعدل مزاجك ويبدأ يومك صح! ✨",
                    style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),

                  const Spacer(), 

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown, 
                        foregroundColor: Colors.white, 
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                      ),
                      onPressed: () {
                        
                        myCart.add(model); 
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating, 
                            content: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.white),
                                const SizedBox(width: 10),
                                Expanded(child: Text("تمت إضافة ${model.name} للسلة بنجاح")),
                              ],
                            ),
                            duration: const Duration(milliseconds: 800),
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text(
                        "إضافة للسلة",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}