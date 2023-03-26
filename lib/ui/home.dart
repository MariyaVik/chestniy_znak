import 'package:ch_z/ui/login_screen.dart';
import 'package:ch_z/ui/theme.dart';
import 'package:flutter/material.dart';

import '../models/bottom_item.dart';
import 'product_page.dart';
import 'profile_page.dart';
import 'purchase_page.dart';
import 'warehouse_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  final bottomItems = [
    BottomItem(icon: Icon(Icons.radar), label: 'Товары'),
    BottomItem(icon: Icon(Icons.warehouse_sharp), label: 'Склад'),
    BottomItem(icon: Icon(Icons.shopping_cart), label: 'Закупки'),
    BottomItem(icon: Icon(Icons.person), label: 'Профиль'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: bottomItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          if (_tabController.index == 3)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(Icons.exit_to_app))
        ],
        elevation: _tabController.index == 2
            ? 0
            : Theme.of(context).appBarTheme.elevation,
        title: Text(
          bottomItems[_tabController.index].label,
        ),
        centerTitle: true,
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ProductsPage(),
          WareHousePage(),
          PurchasePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        currentIndex: _tabController.index,
        items: List.generate(
          bottomItems.length,
          (index) => BottomNavigationBarItem(
              icon: bottomItems[index].icon,
              label: '',
              activeIcon: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: mainColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bottomItems[index].icon,
                    const SizedBox(width: 8),
                    Text(bottomItems[index].label)
                  ],
                ),
              )),
        ),
        onTap: (value) {
          _tabController.index = value;
          setState(() {});
        },
      ),
    ));
  }
}
