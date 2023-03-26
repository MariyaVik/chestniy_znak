import 'package:ch_z/models/entity.dart';
import 'package:ch_z/ui/qr_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data_products.dart';
import '../data/data_supplies.dart';
import '../models/product.dart';
import 'theme.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({super.key});

  @override
  State<AddProductWidget> createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categotyController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    categotyController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<DataProducts>().currentProduct != null) {
      nameController.text = context.read<DataProducts>().currentProduct!.name;
      categotyController.text =
          context.read<DataProducts>().currentProduct!.category;
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      content: Container(
        height: 300,
        width: 500,
        decoration: const BoxDecoration(),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            cursorColor: greyDark,
            controller: nameController,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(),
                hintText: 'Товар'),
          ),
          TextField(
            cursorColor: greyDark,
            controller: categotyController,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(),
                hintText: 'Категория'),
          ),
          TextField(
            cursorColor: greyDark,
            controller: priceController,
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(),
                hintText: 'Стоимость продажи'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: addThing, child: const Text('Добавить')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QrPage(
                              entity: Entity.product,
                            )));
                  },
                  child: const Text('Сканировать QR')),
            ],
          )
        ]),
      ),
    );
  }

  void addThing() {
    context.read<DataProducts>().add(Product(
          name: nameController.text,
          price: double.parse(priceController.text),
          isMark: true,
        ));
    context.read<DataSupplies>().currentSupply = null;
    Navigator.of(context).pop();
  }
}

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key}) : super(key: key);

  final List<String> titles = [
    'Товар',
    'Маркировка',
    'Остаток на складе',
    'Статус',
    'Стоимость продажи',
    'Планируемая выручка',
  ];

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataProducts>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 250,
                  child: TextField(
                    cursorColor: greyDark,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search)),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                    onPressed: () {
                      addProductDialog(context);
                    },
                    child: const Text('Добавить товар')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                ...titles.map(
                  (e) => Expanded(
                      // flex: CurrentScreen.isMobile(context) ? 2 : 1,
                      child: Text(
                    e,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black, height: 2),
          Expanded(
            child: Consumer<DataProducts>(builder: (context, data, _) {
              return ListView.separated(
                itemCount: data.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          dataProvider.products[index].name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                          child: Text(
                        getMark(dataProvider.products[index].isMark),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Expanded(
                          child: Text(
                        dataProvider.products[index].count.toString() + ' шт.',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      Expanded(
                          child: Text(
                              getStatus(dataProvider.products[index].status),
                              textAlign: TextAlign.center)),
                      Expanded(
                        child: Text(
                            dataProvider.products[index].price.toString() +
                                ' рублей',
                            textAlign: TextAlign.center),
                      ),
                      Expanded(
                        child: Text(
                            dataProvider.products[index].revenue.toString() +
                                ' рублей',
                            textAlign: TextAlign.center),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider();
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void addProductDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddProductWidget();
        });
  }

  String getMark(bool isMark) {
    switch (isMark) {
      case true:
        return 'Маркирован';
      case false:
        return 'Не маркирован';
      default:
        return 'Маркирован';
    }
  }

  String getStatus(Status status) {
    switch (status) {
      case Status.enough:
        return 'Достаточно';
      case Status.need:
        return 'Пора закупать';
      case Status.no:
        return 'Нет в наличии';
      default:
        return 'Нет в наличии';
    }
  }
}
