import 'package:flutter/material.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/components/card_template.dart';
import 'package:reusable_app/models/interfaces/nav_item.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:reusable_app/models/token_secure_storage.dart';
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

class AchievementsBodyState extends State<AchievementsBody> {

  Color _rankColor(int rank, BuildContext context) {
    if (rank == 0) {
      return Theme.of(context).textTheme.titleMedium!.color!;
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

  ServerApi api = ServerApi(storage: TokenSecureStorage());

  @override
  void initState() {
    super.initState();
  }

  final lessonMultiplier = 150;
  final pointsForEachLesson = 1000;
  late int lessonsCompleted;


  int _totalPoints() => lessonsCompleted * lessonMultiplier;

  int _level() =>
      _totalPoints() ~/ pointsForEachLesson;

  int _currentPoints() =>
      _totalPoints() % pointsForEachLesson;

  int _remainingPoints() =>
      pointsForEachLesson - _currentPoints();

  @override
  Widget build(BuildContext context) {
    Future<int> completedLessons = api.getCompletedLessons();

    return FutureBuilder(
      future: completedLessons,
      builder: (context, AsyncSnapshot<int> snapshot) {
        lessonsCompleted = snapshot.data ?? 0;
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: 700,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Column(
                    children: [
                      CardTemplate(
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
                                    percent: _currentPoints() / pointsForEachLesson,
                                    center: Text(
                                      "${(_currentPoints() / pointsForEachLesson * 100).round()} %",
                                      style: const TextStyle(
                                          fontSize: 24, fontWeight: FontWeight.w600),
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: CustomColors.purple,
                                  )),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 40, 0, 0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${'Level'.tr} ${_level()}",
                                      style: const TextStyle(
                                          fontSize: 25, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${_currentPoints()}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              "/ $pointsForEachLesson ${'points'.tr}")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                          "${_remainingPoints()} ${'to Level'.tr} ${_level() + 1}"),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      CardTemplate(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 400,
                          height: 140,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                    child: Text(
                                      "${_totalPoints()}",
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                                    child: Text("points".tr),
                                  ),
                                ],
                              ),
                              const Divider(thickness: 2),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                    child: Text(
                                      "$lessonsCompleted",
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text("lessons".tr)),
                                  const Spacer(),
                                ],
                              ),
                              const Divider(thickness: 2),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                    child: Text(
                                      "${1} ${'day'.tr}",
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(6, 5, 0, 0),
                                      child: Text("streak".tr)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
      }
    );
  }
}
