import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mirror_wall_app/utils/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.instance.homePage,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJSov8olLLUqWsNqPCJjJEGglye7lIwVadm02y49AQdp_oRG0eyc9OWGD-Fw3awrsFQrY&usqp=CAU",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                "Search Area",
                style: GoogleFonts.aclonica(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
