import 'package:flutter/material.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import 'package:get/get.dart';


class AchievementsBody extends StatefulWidget implements NavItem {
  AchievementsBody({Key? key}) : super(key: key);

  @override
  AchievementsBodyState createState() => AchievementsBodyState();

  @override
  String title = ("Achievements".tr);
}

//just to store values for a while
class _Info {
  int level;
  int currentPoints;
  int maxPoints;
  int lessons;
  int dayStreak;
  int timeInMinutes;

  int pointsRank;
  int lessonsRank;
  int streakRank;
  int timeRank;

  _Info(
      this.level,
      this.currentPoints,
      this.maxPoints,
      this.lessons,
      this.dayStreak,
      this.timeInMinutes,
      this.pointsRank,
      this.lessonsRank,
      this.streakRank,
      this.timeRank);
}

class AchievementsBodyState extends State<AchievementsBody> {
  _Info _getInfo() {
    //here we can get the data from API
    return _Info(1, 300, 1000, 2, 1, 45, 10, -7, 45, 0);
  }

  Color _rankColor(int rank) {
    if (rank == 0) {
      return Colors.black;
    } else if (rank > 0) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Icon _rankIcon(int rank) {
    if (rank == 0) {
      return const Icon(
        Icons.arrow_drop_up,
        color: Colors.black,
      );
    } else if (rank > 0) {
      return const Icon(
        Icons.arrow_drop_up,
        color: Colors.green,
      );
    } else {
      return const Icon(
        Icons.arrow_drop_down,
        color: Colors.red,
      );
    }
  }

  late _Info information;

  @override
  void initState() {
    super.initState();
    information = _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: 700,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                Card(
                  child: SizedBox(
                    width: 400,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                          child: CircularPercentIndicator(
                            radius: 60.0,
                            animation: true,
                            animationDuration: 1200,
                            lineWidth: 7.0,
                            percent:
                                information.currentPoints / information.maxPoints,
                            center: Text(
                              "${(information.currentPoints / information.maxPoints * 100).round()} %",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: CustomColors.purple,
                          )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 40, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                "${'Level'.tr} ${information.level}",
                                style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Row(children: [
                                    Text("${information.currentPoints}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                    Text("/ ${information.maxPoints} ${'points'.tr}")
                                  ]
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  "${information.maxPoints - information.currentPoints} ${'to Level'.tr} ${information.level + 1}"
                                )
                              )
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: SizedBox(
                      width: 400,
                      height: 175,
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                child: Text("${information.currentPoints}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                                child: Text("points".tr)),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: _rankIcon(information.pointsRank)),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                                child: Text(
                                  "${information.pointsRank.abs()}",
                                  style: TextStyle(
                                      color: _rankColor(information.pointsRank)),
                                ))
                          ]),
                          const Divider(thickness: 2),
                          Row(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                child: Text("${information.lessons}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                child: Text("lessons".tr)),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: _rankIcon(information.lessonsRank)),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                                child: Text(
                                  "${information.lessonsRank.abs()}",
                                  style: TextStyle(
                                      color: _rankColor(information.lessonsRank)),
                                ))
                          ]),
                          const Divider(thickness: 2),
                          Row(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                child: Text("${information.dayStreak} ${'day'.tr}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                                child: Text("streak".tr)),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: _rankIcon(information.streakRank)),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                                child: Text(
                                  "${information.streakRank.abs()}",
                                  style: TextStyle(
                                      color: _rankColor(information.streakRank)),
                                ))
                          ]),
                          const Divider(thickness: 2),
                          Row(children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                child: Text("${information.timeInMinutes}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                                child: Text("min".tr)),
                            const Spacer(),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: _rankIcon(information.timeRank)),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 15, 0),
                                child: Text(
                                  "${information.timeRank.abs()}",
                                  style: TextStyle(
                                      color: _rankColor(information.timeRank)),
                                ))
                          ]),
                        ],
                      )),
                ),
              ],
            )),
      ),
    );
  }
}
