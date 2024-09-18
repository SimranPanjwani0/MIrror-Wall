import 'package:flutter/material.dart';

class noInternet extends StatelessWidget {
  const noInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 450,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/image/google_1.jpg'),
        ),
      ),
    );
  }
}
