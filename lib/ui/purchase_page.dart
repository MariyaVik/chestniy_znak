import 'package:ch_z/data/data_orders.dart';
import 'package:ch_z/models/entity.dart';
import 'package:ch_z/ui/qr_page.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController agentController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController pricePurchaseController = TextEditingController();
  final TextEditingController priceDeliveryController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    agentController.dispose();
    countController.dispose();
    pricePurchaseController.dispose();
    priceDeliveryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<DataSupplies>().currentSupply != null) {
      nameController.text = context.read<DataSupplies>().currentSupply!.name;
      agentController.text = context.read<DataSupplies>().currentSupply!.agent;
      countController.text =
          context.read<DataSupplies>().currentSupply!.count.toString();
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      content: Container(
        height: 400,
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
    );
  }

  void addThing() {
    context.read<DataSupplies>().add(Supply(
          name: nameController.text,
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

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75)),
            ],
            // border: Border(bottom: BorderSide()),
            // gradient: LinearGradient(
            //   colors: <Color>[Colors.blue, Colors.pink],
            // ),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
                color: Colors.yellow, borderRadius: BorderRadius.circular(16)),
            labelColor: Colors.black,
            // unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: 'Список заказов'),
              Tab(text: 'Правила'),
            ],
          ),
        ),
        preferredSize: const Size.fromHeight(80.0),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PurchaseListPage(),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PurchaseRulePage extends StatelessWidget {
  PurchaseRulePage({Key? key}) : super(key: key);

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
                      addSupplyDialog(context);
                    },
                    child: Text('Добавить поставку')),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                          dataProvider.supplies[index].date.day.toString() +
                              '.' +
                              dataProvider.supplies[index].date.month
                                  .toString() +
                              '.' +
                              dataProvider.supplies[index].date.year.toString(),
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
                              dataProvider.supplies[index].count.toString() +
                                  ' шт.',
                              textAlign: TextAlign.center)),
                      Expanded(
                        flex: 2,
                        child: Text(
                            (dataProvider.supplies[index].purchasePrice +
                                        dataProvider
                                            .supplies[index].deliveryPrice)
                                    .toString() +
                                ' р.',
                            textAlign: TextAlign.center),
                      ),
                      CurrentScreen(
                          mobile: Expanded(
                              flex: 1,
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit))),
                          desktop: Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Редактировать'))))
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

  void addSupplyDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AddSupplyWidget();
        });
  }
}

class PurchaseListPage extends StatelessWidget {
  PurchaseListPage({Key? key}) : super(key: key);

  final List<String> titles = [
    'Дата',
    'Поставщик',
    'Стоимость',
    'Документ',
  ];

  @override
  Widget build(BuildContext context) {
    final dataProvider = context.read<DataOrders>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                ...titles.map(
                  (e) => Expanded(
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
            child: Consumer<DataOrders>(builder: (context, data, _) {
              return ListView.separated(
                itemCount: data.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          dataProvider.orders[index].date.day.toString() +
                              '.' +
                              dataProvider.orders[index].date.month.toString() +
                              '.' +
                              dataProvider.orders[index].date.year.toString(),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            dataProvider.orders[index].agent,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Expanded(
                        flex: 2,
                        child: Text(
                            dataProvider.orders[index].price.toString() +
                                ' рублей',
                            textAlign: TextAlign.center),
                      ),
                      CurrentScreen(
                          desktop: Expanded(
                              flex: 2,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Скачать заказ'))),
                          mobile: Expanded(
                            flex: 2,
                            child: ElevatedButton(
                                onPressed: () {}, child: Icon(Icons.download)),
                          ))
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
}
