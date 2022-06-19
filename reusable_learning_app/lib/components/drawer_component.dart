import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';

import '../models/user.dart';
import 'drawer_item_component.dart';

class DrawerComponent extends StatefulWidget {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DrawerComponentState();

}

class DrawerComponentState extends State {
  final ServerApi _api = ServerApi();
  late Future<User> selfInfo;
  @override
  void initState() {
    super.initState();
    selfInfo = _api.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: selfInfo,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Drawer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Expanded(flex: 2, child:
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: ExactAssetImage('assets/avatar.png'),
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                            )
                        )
                        ),
                        Expanded(child:
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: FutureBuilder<User>(
                                      future: selfInfo,
                                      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                                        if(snapshot.hasData) {
                                          return Text(
                                            snapshot.data!.username,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500
                                            ),
                                          );
                                        }
                                        else {
                                          return const Text(
                                            "No Name",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500
                                            ),
                                          );
                                        }

                                      }
                                  )

                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Student",
                                  style: TextStyle(
                                      color: Colors.grey[600]
                                  ),
                                )
                            )
                          ],
                        )
                        )
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 1, height: 1),
                Column(
                  children: [
                    DrawerItemComponent(
                      Icons.favorite,
                      "Favorite courses",
                      route: "/favCourses",
                    ),
                    DrawerItemComponent(
                      Icons.play_lesson,
                      "Favorite lessons",
                      route: "/favLessons",
                    ),
                    DrawerItemComponent(
                      Icons.chat,
                      "Chat with developers",
                      route: "/devChat",
                    ),
                    DrawerItemComponent(
                      Icons.create,
                      "Edit courses/lessons",
                      route: "/edit",
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );




  }
}