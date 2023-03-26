import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text('Рейтинг магазина'),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color(0xFF5EE334),
                borderRadius: BorderRadius.circular(8)),
            child: Text('85% товаров маркированы'),
          )
        ],
      ),
    );
  }
}
