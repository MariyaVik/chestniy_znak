import 'package:flutter/material.dart';

import '../data/data_pie.dart';
import 'line.dart';
import 'pie.dart';
import 'theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: mainColorLight,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer)
                ]),
            height: 300,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Наименование компании'),
                    Text(
                      'ИП Белозеров А.В.',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black, fontSize: 28),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      const Text('ИНН Компании'),
                      Text(
                        '1123216675',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black),
                      )
                    ]),
                    Column(children: [
                      const Text('Юридическая информация'),
                      Text(
                        'г. Москва, ул. Павлова, 17',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black),
                      )
                    ]),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Рейтинг магазина',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFF5EE334),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('85% товаров маркированы'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Аналитика',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                PieChartSample1(data: data, categories: categories),
                const SizedBox(height: 16),
                const LineChartSample1(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
