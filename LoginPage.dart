import 'package:flutter/material.dart';
import 'signUp.dart';
import 'pageAccueil.dart';
import 'signupDesign.dart';

/// loginEkran
class LoginEkran extends StatefulWidget {
  const LoginEkran({super.key});

  @override
  State<LoginEkran> createState() => _LoginEkranState();
}

// Fake Database
class FakeDatabase {
  static Map<String, String> users = {
    "bervelie@gmail.com": "12345678"
  };
}

class _LoginEkranState extends State<LoginEkran> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailField = TextEditingController();
  final TextEditingController passField = TextEditingController();

  void login() {
    if (_formKey.currentState!.validate()) {
      String email = emailField.text.trim();
      String password = passField.text.trim();
// kondisyon pou verifye si se login itilizate a chwazi si mail ak pass li okay si yo nn lis nou an
      if (FakeDatabase.users.containsKey(email) &&
          FakeDatabase.users[email] == password) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyHomePage(title: 'MovieFinder App')),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email oubyn password ou rantre a pa bon")),
        );
      }
    }
  }


@override
Widget build(BuildContext context) {
  return SignupDesign(
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(height: 90),

          TextFormField(
            controller: emailField,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: const TextStyle(color: Color.fromARGB(255, 1, 3, 107), fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Color.fromARGB(255, 1, 3, 107), width: 2.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                
                borderSide: const BorderSide(color: Color.fromARGB(255, 22, 80, 240), width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Chan sa obligatwa";
              }
              if (!RegExp(r'^[a-zA-Z0-9._%-]+@gmail\.com$').hasMatch(value)) {
                return "Email ou pa bon retape l";
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          TextFormField(
            controller: passField,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Password",
              
              labelStyle: const TextStyle(color: Color.fromARGB(255, 1, 3, 107), fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Color.fromARGB(255, 1, 3, 107), width: 2.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Color.fromARGB(255, 22, 80, 240), width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Chan sa obligatwa";
              }
              return null;
            },
          ),

          const SizedBox(height: 50),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 54, 190, 244),
              foregroundColor: Color.fromARGB(255, 2, 9, 100),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: login,
            child: const Text(
              "Konekte",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
            const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignupPage()),
              );
            },
            child: const Text(
              "Anrejistre",
              style: TextStyle(
                color: Color.fromARGB(255, 2, 9, 100),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}