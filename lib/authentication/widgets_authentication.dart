import 'package:flutter/material.dart';

class AuthenticationHeader extends StatelessWidget {
  const AuthenticationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quicknote",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            "Lorem ipsum\ndolor sit amet",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}