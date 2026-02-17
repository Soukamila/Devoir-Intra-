import 'package:flutter/material.dart';

class SignupDesign extends StatelessWidget {
  final Widget child;

  const SignupDesign({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Background pou image la
          SizedBox.expand(
            child: Image.network(
              "https://tse1.mm.bing.net/th/id/OIP.nex0vo2ba6dTZX7MEAoIyQHaEK?cb=defcachec2&rs=1&pid=ImgDetMain&o=7&rm=3",
              fit: BoxFit.cover,
            ),
          ),

          // Overlay nwa
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // Kontni ki soti nan lòt page
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}