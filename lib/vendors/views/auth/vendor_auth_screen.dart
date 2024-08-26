import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'package:multi_store_vendor/vendors/views/auth/vendor_register_screen.dart';

class VendorAuthScreen extends StatefulWidget {
  const VendorAuthScreen({super.key});

  @override
  State<VendorAuthScreen> createState() => _VendorAuthScreenState();
}

class _VendorAuthScreenState extends State<VendorAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), initialData: FirebaseAuth.instance.currentUser, builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return SignInScreen(
          providers: [
            EmailAuthProvider(),
          ],
        );
      }

      return const VendorRegisterScreen();
    },);
  }
}