import 'package:flutter/material.dart';

import 'android_home/android_home.dart';

class AndroidMain extends StatelessWidget {
  const AndroidMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const AndroidHome(),
    );
  }
}
