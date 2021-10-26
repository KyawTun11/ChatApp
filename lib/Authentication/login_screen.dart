import 'package:chat_app/Authentication/create_account.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/Authentication/methods.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Center(
                    child: SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Email", Icons.email_outlined, _email),
                  ),
                  SizedBox(height: 20),
                  passwordField(size),
                  SizedBox(height: 40),
                  customButton(size),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont't have an account ? Please   ",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateAccount()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      child: Container(
        height: size.height / 14,
        width: size.width / 1.1,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Sucessfull");
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
        }
      },
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  Widget passwordField(Size size) {
    return Container(
        height: size.height / 14,
        width: size.width / 1.1,
        child: TextFormField(
          autofocus: false,
          obscureText: true,
          controller: _password,
          validator: (value) {
            RegExp regex = RegExp(r'^.{6,}$');
            if (value!.isEmpty) {
              return ("Password is required for login");
            }
            if (!regex.hasMatch(value)) {
              return ("Enter Valid Password (Min. 6 Character)");
            }
          },
          onSaved: (value) {
            _password.text = value!;
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ));
  }
}
