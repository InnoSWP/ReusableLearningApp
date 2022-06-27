import 'package:flutter/material.dart' hide Notification;
import 'package:flutter/widgets.dart' hide Notification;
import 'package:flip_card/flip_card.dart';
import 'package:reusable_app/models/notification.dart';
import 'package:get/get.dart' ;
import 'package:reusable_app/models/utilities/notification_service.dart';
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
    return FutureBuilder(
      future: NotificationService.getAllNotifications(),
      builder: (context, AsyncSnapshot<List<Notification>> snapshot) {
        if(snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Notifications".tr),
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white)
              ),
            ),
            bottomNavigationBar: BottomMenu(onTap: (int value) {
              BottomMenu.navigateFromOtherPage(context, value);
            }),
            body: Builder(
              builder: (context) {
                if(snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No notifications yet",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 25
                          ),

                        ),
                        SizedBox(height: 10),
                        Icon(
                          Icons.notifications_off_outlined,
                          size: 50,
                          color: Colors.grey.shade600,
                        )
                      ],
                    )
                  );
                }
                else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: FlipCard(
                          fill: Fill.fillBack,
                          direction: FlipDirection.VERTICAL,
                          front: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.notifications),
                                  title: Text(snapshot.data![index].title!),
                                  subtitle: Text(snapshot.data![index].subTitle!),
                                  trailing: Text(
                                    snapshot.data![index].time
                                  ),
                                ),
                                Row(children: [
                                  const Spacer(),
                                  Padding(padding: const EdgeInsets.only(right : 20),
                                      child: IconButton(
                                        onPressed: () async {
                                          await NotificationService.deleteNotification(snapshot.data![index].id);
                                          setState(() {});
                                        },
                                        icon: const Icon(Icons.delete)
                                    )
                                  )
                                ]),
                              ]
                            )
                          ),
                          back: Card(
                              child: Center(
                                  child: Text(snapshot.data![index].body!)
                              )
                          ),
                        )
                      );
                    }
                  );
                }
              },
            )
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
