import 'package:ch_z/ui/home.dart';
import 'package:flutter/material.dart';

import 'theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    cursorColor: greyDark,
                    controller: TextEditingController()..text = 'ivanov',
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Логин'),
                  ),
                  TextField(
                    cursorColor: greyDark,
                    controller: TextEditingController()..text = '123123',
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Пароль'),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: mainColor,
                            foregroundColor: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Home()));
                        },
                        child: const Text(
                          'Войти',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                  ),
                  SizedBox(
                      width: 200,
                      child: OutlinedButton(
                          onPressed: () {}, child: const Text('Регистрация')))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
