import 'package:flutter_test/flutter_test.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/authorization/server_api.dart';
import 'package:reusable_app/models/boost.dart';
import 'package:reusable_app/models/course.dart';
import 'package:reusable_app/models/user.dart';

import 'mocks/mock_storage.dart';

void main() {
  var server = ServerApi(storage: MockStorage());
  var manager = AuthorizationManager(storage: MockStorage());
  var result = manager.authorize("superuser", "123456");

  test('getting self information works successfully', () async {
    Future<User> selfInfoResult = server.getSelfInfo();
    var selfInfoRes = await selfInfoResult;
    expect(selfInfoRes.username, "superuser");
    expect(selfInfoRes.email, "admin@mail.shit"); // Getting self info
  });

  test('getting courses list works successfully', () async {
    Future<List<Course>> courseListResult = server.getCoursesList();
    var courseListRes = await courseListResult;
    expect(courseListRes[2].name, "Theoretical computer science");
    expect(courseListRes[1].name, "AGLA Course");
    expect(courseListRes[0].name,
        "Mathematical Analysis I"); // Getting list of courses
  });

  test('getting user points works successfully', () async {
    Future<int> userPointsResult = server.getUserPoints();
    var userPointsRes = await userPointsResult;
    expect(userPointsRes, 555);
  });

  test('getting boosts list works successfully', () async {
    Future<List<Boost>> boostsListResult = server.getBoostsList();
    var boostsListRes = await boostsListResult;
    expect(boostsListRes[0].name, "Unique icon!");
    expect(boostsListRes[0].price, 30);
    expect(boostsListRes[1].name, "Double bonuses!");
    expect(boostsListRes[1].price, 20);
  });
}
