import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtc_blog_frontend/auth/authservice.dart';
import 'package:wtc_blog_frontend/modal/user.dart';
import 'package:wtc_blog_frontend/views/dashboard.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  User user = User.withEmail("", "");
  String loginUrl = "http://10.0.2.2:8080/login";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const CircularProgressIndicator()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'WeThinkBlog',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      onChanged: (value) {
                        user.email = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      onChanged: (value) {
                        user.password = value;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          _onloading();
                        },
                      )),
                ],
              ),
            ),
          );
  }

  void doLogin() async {
    var res = await http.post(Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user));

    if (res.statusCode == 200) {
      User currentUser = User.fromJson(jsonDecode(res.body));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await setPrefs(prefs, currentUser);
      AuthService authUser = Provider.of<AuthService>(context, listen: false);
      await authUser.updateUser(currentUser);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Dashboard()));
    }
  }

  setPrefs(SharedPreferences prefs, User currentUser) {
    prefs.setBool("loggedIn", true);
    prefs.setString("user", jsonEncode(currentUser.toJson()));
    prefs.setString("username", currentUser.username);
    prefs.setString("name", currentUser.name);
    prefs.setString("surname", currentUser.surname);
    prefs.setString("email", currentUser.email);
  }

  void _onloading() async {
    setState(() {
      loading = true;
    });
    await doLogin();
    setState(() {
      loading = false;
    });
  }
}
