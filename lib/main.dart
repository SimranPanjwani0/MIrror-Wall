import 'package:flutter/material.dart';
import 'package:mirror_wall_app/controller/app_controller.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}
