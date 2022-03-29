import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtc_blog_frontend/auth/authservice.dart';
import 'package:wtc_blog_frontend/views/authentication/login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authUser = Provider.of<AuthService>(context);

    return authUser.user == null
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(actions: [
              TextButton(
                  onPressed: () async {
                    logout();
                  },
                  child: Text(
                    "Log out",
                    style: TextStyle(color: Colors.white),
                  ))
            ]),
            body: SafeArea(
              child: Column(
                children: [
                  Text(authUser.user.email ?? ""),
                ],
              ),
            ));
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", false);
    if (prefs.getBool("loggedIn") != null &&
        prefs.getBool("loggedIn") == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
