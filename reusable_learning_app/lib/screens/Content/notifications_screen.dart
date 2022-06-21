import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:reusable_app/models/notification.dart';

import '../../components/scaffold/bottom_menu.dart';
import '../../models/utilities/custom_colors.dart';

class NotificationsBody extends StatefulWidget {
  NotificationsBody({Key? key}) : super(key: key);

  @override
  NotificationsBodyState createState() => NotificationsBodyState();
}

class NotificationsBodyState extends State<NotificationsBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Notifications"),
          backgroundColor: CustomColors.purple,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white)),
        ),
        bottomNavigationBar: BottomMenu(onTap: (int value) {
          BottomMenu.navigateFromOtherPage(context, value);
        }),
        body: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(padding: const EdgeInsets.only(top: 3),child: FlipCard(
                fill: Fill.fillBack,
                direction: FlipDirection.VERTICAL,
                front: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(notifications[index].title),
                        subtitle: Text(notifications[index].subTitle),
                      ),
                      Row(children: [
                        const Spacer(),
                        Padding(padding: const EdgeInsets.only(right : 20), child:
                        IconButton(
                            onPressed: () {
                              setState(() {
                                notifications.removeAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete))
                        )]),
                    ])),
                back:
                    Card(child: Center(child: Text(notifications[index].body))),
              ));
              }));
  }
}
