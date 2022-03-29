import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wtc_blog_frontend/auth/authservice.dart';
import 'package:wtc_blog_frontend/views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => AuthService())],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}
