import 'package:chat_app/screens/home_screen.dart';
import 'package:chat_app/Authentication/login_screen.dart';
import 'package:chat_app/Authentication/methods.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
                "Register",
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
              child: field(size, "Name", Icons.person, _name),
            ),
            SizedBox(height: 20),
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
                  "Aulady have an account ?  ",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    "LogIn",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
          "SignUp",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        if (_name.text.isNotEmpty &&
            _email.text.isNotEmpty &&
            _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          createAccount(_name.text, _email.text, _password.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              print("Account Created Sucessfull");
            } else {
              print("Login Failed");
            }
          });
        } else {
          print("Please enter Fields");
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
