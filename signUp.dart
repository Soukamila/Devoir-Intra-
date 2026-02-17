import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'signupDesign.dart';



//ekran pou anrejistre (Sign up)
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signup() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      FakeDatabase.users[email] = password;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kont ou kreye")),
      );

      Navigator.pop(context);
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
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 1, 3, 107),
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 3, 107),
                  width: 2.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 22, 80, 240),
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Chan sa obligatwa";
              }
              return null;
            },
          ),

          const SizedBox(height: 40),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 1, 3, 107),
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 1, 3, 107),
                  width: 2.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 22, 80, 240),
                  width: 2,
                ),
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
              backgroundColor: const Color.fromARGB(255, 54, 190, 244),
              foregroundColor: const Color.fromARGB(255, 2, 9, 100),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: signup, // 👈 PA chanje fonksyon pa w
            child: const Text(
              "Anrejistre",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 15),

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Retounen Login",
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