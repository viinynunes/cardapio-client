import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenInitial extends StatefulWidget {
  const SplashScreenInitial({Key? key}) : super(key: key);

  @override
  State<SplashScreenInitial> createState() => _SplashScreenInitialState();
}

class _SplashScreenInitialState extends State<SplashScreenInitial> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2))
        .then((_) => _routesByLoggedUser());
  }

  Future<void> _routesByLoggedUser() async {
    final userPref = await SharedPreferences.getInstance();

    final recUser = userPref.get('client');

    if (recUser == null) {
      Modular.to.navigate('/login/');
    } else {
      Modular.to.navigate('/login/navigation/home/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Carregando cardápio',
                style: TextStyle(
                  fontSize: 30,
                )),
            SizedBox(
              height: 15,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
