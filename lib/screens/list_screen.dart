import 'package:flutter/material.dart';
import 'package:project_final/extension/nav.dart';
import 'package:project_final/screens/cart_screen.dart';
import 'package:project_final/screens/details_screen.dart';
import 'package:project_final/service/database.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int myIndex = 0;
  List<Widget> widgetList = const [ListScreen(), CartScreen()];
  var titleController = TextEditingController();
  var priceController = TextEditingController();
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
      backgroundColor: const Color.fromARGB(255, 236, 180, 123),
      
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
                final coffee = snapshot.data![index];
                return InkWell(
                  onTap: () {
                    context.push(DetailsScreen(model: snapshot.data![index]));
                  },
                  child: Card(
  elevation: 4, 
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15), 
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch, 
    children: [
      
      Expanded( 
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), 
          child: Image.network(
            coffee.image ?? "",
            fit: BoxFit.cover, 
            height: 120, 
            width: double.infinity, 
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.broken_image, color: Colors.grey));
            },
          ),
        ),
      ),
      
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              coffee.name ?? "قهوة",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1, 
              overflow: TextOverflow.ellipsis, 
            ),
            const SizedBox(height: 5),
            Text(
              "${coffee.price ?? 0} SR",
              style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
            ),
          ],
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
                        keyboardType: TextInputType.number,
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
                            setState(() {});
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
