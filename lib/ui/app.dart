import 'package:ch_z/data/data_orders.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data_products.dart';
import '../data/data_supplies.dart';
import 'login_screen.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataSupplies>(
            create: (context) => DataSupplies()),
        ChangeNotifierProvider<DataProducts>(
            create: (context) => DataProducts()),
        ChangeNotifierProvider<DataOrders>(create: (context) => DataOrders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: themeLight,
        home: const LoginScreen(),
      ),
    );
  }
}
