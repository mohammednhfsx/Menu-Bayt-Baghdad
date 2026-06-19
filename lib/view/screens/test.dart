import 'package:flutter/material.dart';
import 'package:menubaghdad/view/widgets/custom_bottom_nav_bar.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromARGB(255, 182, 191, 236),
      body: Stack(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CustomBottomNavBar()),
          ),
        ],
      ),
     
    );
  }
}