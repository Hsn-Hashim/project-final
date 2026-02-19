import 'package:project_final/models/coffee.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Database {
  final supabase = Supabase.instance.client;

  // ==================== Auth  ====================

  signUp({required String email, required String password}) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  // ==================== CRUD operation ====================



  addCoffee({
    required String name,
    required double price,
    required String image,
  }) async {
    await supabase.from("coffee").insert({
      "name": name,
      "price": price,
      "image": image,
    });
  }
  Future<List<Coffee>> getCoffee() async {
    final data = await supabase.from("coffee").select();

    List<Coffee> coffeeList = [];
    for (var element in data) {
      Coffee c1 = Coffee.fromJson(element);
      coffeeList.add(c1);
    }
    return coffeeList;
  }
  Future<void> createOrder(List<Coffee> cart) async {
    try {
      final List<Map<String, dynamic>> itemsJson = 
          cart.map((coffee) => coffee.toJson()).toList();

      await supabase.from('orders').insert({
        'items': itemsJson,
      });
      
    } catch (e) {
    }
  }
}
