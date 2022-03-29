import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtc_blog_frontend/views/authentication/login.dart';
import 'package:wtc_blog_frontend/views/dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loginCheck = true;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return loginCheck
        ? const CircularProgressIndicator()
        : const Scaffold(
            body: SafeArea(child: Login()),
          );
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool("loggedIn");
    if (val != null && val) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      setState(() {
        loginCheck = false;
      });
    }
  }
}
