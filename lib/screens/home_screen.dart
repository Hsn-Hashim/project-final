import 'package:flutter/material.dart';
import 'package:project_final/service/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var titleController = TextEditingController();
  var priceController = TextEditingController(); // جديد للسعر
  var imageController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    imageController.dispose();
    priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Database().getCoffee(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final course = snapshot.data![index];
                return Card(
                  child: Column(
                    children: [
                      Image.network(course.image ?? ""),
                      Text(course.name!),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown, 
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      Text(
                        "قهوة جديدة ☕",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),

                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "name",
                          prefixIcon: Icon(Icons.coffee),
                        ),
                      ),
                      SizedBox(height: 15),

                      TextField(
                        controller: priceController,
                        keyboardType:
                            TextInputType.number, 
                        decoration: InputDecoration(
                          hintText: "price",
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                      ),
                      SizedBox(height: 15),

                      TextField(
                        controller: imageController,
                        decoration: InputDecoration(
                          hintText: "image url",
                          prefixIcon: Icon(Icons.image),
                        ),
                      ),
                      SizedBox(height: 25),

                      // زر الحفظ
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                          ),
                          onPressed: () async {
                            double price =
                                double.tryParse(priceController.text) ?? 0.0;

                            String image = imageController.text.isEmpty
                                ? "https://placehold.co/400x300/3e2723/ffffff?text=Coffee"
                                : imageController.text;

                            await Database().addCoffee(
                              name: titleController.text,
                              price: price,
                              image: image,
                            );

                            titleController.clear();
                            priceController.clear();
                            imageController.clear();
                            Navigator.pop(context);
                            setState(
                              () {},
                            );
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
