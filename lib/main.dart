import 'package:flutter/material.dart';
import 'package:project_final/screens/home_screen.dart';
import 'package:project_final/screens/list_screen.dart';
import 'package:project_final/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://aubtgkfhlznomhavncxp.supabase.co", // change to your own url
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF1YnRna2ZobHpub21oYXZuY3hwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA5NzM4MTIsImV4cCI6MjA4NjU0OTgxMn0.sNVI6Ixo_gKdAhyusSrsftzQr8j1BFQvm6_azsbng7E", // change to your own key
  );


  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen()
    );
  }
}