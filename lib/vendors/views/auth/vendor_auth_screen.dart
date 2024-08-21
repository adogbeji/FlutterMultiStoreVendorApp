import 'package:flutter/material.dart';

class VendorAuthScreen extends StatefulWidget {
  const VendorAuthScreen({super.key});

  @override
  State<VendorAuthScreen> createState() => _VendorAuthScreenState();
}

class _VendorAuthScreenState extends State<VendorAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Vendor Auth Screen'),
      ),
    );
  }
}