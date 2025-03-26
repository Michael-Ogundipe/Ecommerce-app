import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../products/presentation/product_list_screen.dart';
import 'login_screen.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          return ProductListScreen();
        }
        return LoginScreen();
      },
    );
  }
}