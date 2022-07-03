import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/models/token_secure_storage.dart';

import '../../components/card_template.dart';
import '../../models/boost.dart';
import '../../models/interfaces/nav_item.dart';

class ShopBody extends StatefulWidget implements NavItem {
  ShopBody({Key? key}) : super(key: key);

  @override
  ShopBodyState createState() => ShopBodyState();

  @override
  String title = ("Shop".tr);
}

class ShopBodyState extends State<ShopBody> {

  ServerApi serverApi = ServerApi(storage: TokenSecureStorage());
  late Future<List<Boost>> bonusesList;
  late Future<List<Boost>> inventoryList;
  late Future<int> userPoints;

  @override
  void initState() {
    bonusesList = serverApi.getBoostsList();
    inventoryList = serverApi.getInventory();
    userPoints = serverApi.getUserPoints();
    super.initState();
  }

  void _buyItem(int index) async {
    await serverApi.buyBoost(index);
    setState(() {
      inventoryList = serverApi.getInventory();
      userPoints = serverApi.getUserPoints();
    }
    );
  }

  void _snackNotEnoughMoney(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You do not have enough money!'.tr,
          ),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Future.wait([bonusesList, userPoints, inventoryList]),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: CardTemplate(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11, bottom: 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data[1].toString(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const Icon(
                            Icons.attach_money_rounded,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: (snapshot.data[0] as List<Boost>).length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardTemplate(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, bottom: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                      NetworkImage((snapshot.data[0] as List<Boost>)[index].imageUrl!),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 7),
                                          child: Text(
                                            (snapshot.data[0] as List<Boost>)[index].name!,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            (snapshot.data[0] as List<Boost>)[index].description!,
                                            style: const TextStyle(
                                                color: Colors.grey, fontSize: 13),
                                            textAlign: TextAlign.justify,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .backgroundColor
                                  ),
                                ),
                                onPressed: () {
                                  (snapshot.data[2] as List<Boost>).contains((snapshot.data[0] as List<Boost>)[index]) ?
                                  (){} : ((snapshot.data[0] as List<Boost>)[index].price! <= snapshot.data[1] ? _buyItem((snapshot.data[0] as List<Boost>)[index].id!) :
                                  _snackNotEnoughMoney(context));
                                },
                                child:
                                !(snapshot.data[2] as List<Boost>).contains((snapshot.data[0] as List<Boost>)[index]) ?
                                  Text(
                                  (snapshot.data[0] as List<Boost>)[index].price!.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white)
                                ) : const Icon(Icons.check, color : Colors.white)
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );


  }
}
