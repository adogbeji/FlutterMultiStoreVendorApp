import 'package:flutter/material.dart';

class VendorRegisterScreen extends StatelessWidget {
  const VendorRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pink,
            toolbarHeight: 200,
          ),
        ],
      ),
    );
  }
}