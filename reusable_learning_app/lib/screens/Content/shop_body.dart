import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

String amountOfBonuses = "500";
List<Boost> boosts = [
  Boost(
      "https://st4.depositphotos.com/10839834/29105/v/600/depositphotos_291050438-stock-illustration-2x-sign-icon.jpg",
      "Double bonuses!",
      "Increase the amount of obtained bonuses for each completed lesson twice!",
      "1000"),
  Boost(
      "https://cover.mnogo-futbolochek.ru/images/0/1/1211/1211608/previews/people_2_sign_front_white_500.jpg",
      "Unique icon!",
      "Change general icon with the brightest and unique one!",
      "3000"),
];

class ShopBodyState extends State<ShopBody> {
  @override
  void initState() {
    super.initState();
  }

  void _buyItem(int index) {}

  @override
  Widget build(BuildContext context) {
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
                              amountOfBonuses,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            const Icon(
                              Icons.attach_money_rounded,
                              color: Colors.yellow,
                            )
                          ],
                        )))),
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: boosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardTemplate(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 15, bottom: 15, right: 15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(right: 15),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                  boosts[index].imageUrl),
                                            )),
                                        SizedBox(
                                          width: 170,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 7),
                                                  child: Text(
                                                      boosts[index].name,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  boosts[index].description,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
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
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .backgroundColor)),
                                      onPressed: () {
                                        _buyItem(index);
                                      },
                                      child: Text(boosts[index].price,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ),
                                  ])
                          )
                      );
                    }
                    )
            )
          ],
        )
    );
  }
}
