import 'package:ch_z/data/data_products.dart';
import 'package:ch_z/models/entity.dart';
import 'package:ch_z/ui/qr_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../check_width.dart';
import '../data/data_supplies.dart';
import '../models/supply.dart';
import 'theme.dart';

class AddSupplyWidget extends StatefulWidget {
  const AddSupplyWidget({super.key});

  @override
  State<AddSupplyWidget> createState() => _AddSupplyWidgetState();
}

class _AddSupplyWidgetState extends State<AddSupplyWidget> {
  final TextEditingController agentController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController pricePurchaseController = TextEditingController();
  final TextEditingController priceDeliveryController = TextEditingController();

  String? selectedProduct;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    agentController.dispose();
    countController.dispose();
    pricePurchaseController.dispose();
    priceDeliveryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<DataSupplies>().currentSupply != null) {
      selectedProduct = context.read<DataSupplies>().currentSupply!.name;
      agentController.text = context.read<DataSupplies>().currentSupply!.agent;
      countController.text =
          context.read<DataSupplies>().currentSupply!.count.toString();
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      scrollable: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      content: Container(
        height: 400,
        width: 500,
        decoration: const BoxDecoration(),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButtonFormField2(
                  value: selectedProduct,
                  onChanged: (String? value) => setState(() {
                    selectedProduct = value ?? "";
                  }),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Выберите товар',
                  ),
                  items: context
                      .read<DataProducts>()
                      .products
                      .map((item) => DropdownMenuItem<String>(
                            value: item.name,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Заполните поле';
                    }
                    return null;
                  },
                ),
                TextField(
                  cursorColor: greyDark,
                  controller: agentController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                      hintText: 'Контраген'),
                ),
                TextField(
                  cursorColor: greyDark,
                  controller: countController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                      hintText: 'Количество'),
                ),
                TextField(
                  cursorColor: greyDark,
                  controller: pricePurchaseController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                      hintText: 'Стоимость закупки'),
                ),
                TextField(
                  cursorColor: greyDark,
                  controller: priceDeliveryController,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                      hintText: 'Стоимость доставки'),
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
                                    entity: Entity.supply,
                                  )));
                        },
                        child: const Text('Сканировать QR')),
                  ],
                )
              ]),
        ),
      ),
    );
  }

  void addThing() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      context.read<DataSupplies>().add(Supply(
            name: selectedProduct!,
            date: DateTime.now(),
            agent: agentController.text,
            count: int.parse(countController.text),
            deliveryPrice: double.parse(priceDeliveryController.text),
            purchasePrice: double.parse(pricePurchaseController.text),
          ));
      context.read<DataSupplies>().currentSupply = null;
      Navigator.of(context).pop();
    }
  }
}

class WareHousePage extends StatelessWidget {
  WareHousePage({Key? key}) : super(key: key);

  final List<String> titles = [
    'Дата поставки',
    'Товар',
    'Контрагент',
    'Количество',
    'Стоимость',
  ];

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataSupplies>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
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
                      addSupplyDialog(context);
                    },
                    child: const Text('Добавить поставку')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                ...titles.map(
                  (e) => Expanded(
                      flex: CurrentScreen.isMobile(context) ? 2 : 1,
                      child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                const Spacer()
              ],
            ),
          ),
          const Divider(color: Colors.black, height: 2),
          Expanded(
            child: Consumer<DataSupplies>(builder: (context, data, _) {
              return ListView.separated(
                itemCount: data.supplies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${dataProvider.supplies[index].date.day}.${dataProvider.supplies[index].date.month}.${dataProvider.supplies[index].date.year}',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            dataProvider.supplies[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Expanded(
                          flex: 2,
                          child: Text(
                            dataProvider.supplies[index].agent,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Expanded(
                          flex: 2,
                          child: Text(
                              '${dataProvider.supplies[index].count} шт.',
                              textAlign: TextAlign.center)),
                      Expanded(
                        flex: 2,
                        child: Text(
                            '${dataProvider.supplies[index].purchasePrice + dataProvider.supplies[index].deliveryPrice} р.',
                            textAlign: TextAlign.center),
                      ),
                      CurrentScreen(
                          mobile: Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit))),
                          desktop: Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Редактировать'))))
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void addSupplyDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return const AddSupplyWidget();
        });
  }
}
