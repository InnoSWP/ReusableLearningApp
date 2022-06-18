import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/utilities/token_api.dart';
import 'package:reusable_app/screens/forms/auth_form.dart';

void main() {
  group('Manager works fully', () {
    //check whole group, not individual test
    test('Registration of new account works successfully', () async {
      Future<AccountCreateResult> result = AuthorizationManager()
          .registerAccount("test1@mail.ru", "test1", "test1");
      var res = await result;
      expect(res.errorMessage, null);
    });
    test('Authorization of registered account works successfully', () async {
      Future<AuthResult> result =
          AuthorizationManager().authorize("test1", "test1");
      var res = await result;
      expect(res.isAuthorized, true);
    });
    test('Checking if user is authorized works successfully', () async {
      Future<bool> result = AuthorizationManager().isAuthorized();
      expect(await result, true);
    });
    AuthorizationManager().logout();
  });
  test('registration works successfully', () async {
    Future<AccountCreateResult> result =
        AuthorizationManager().registerAccount("test2", "test2", "test2");
    var res = await result;
    expect(res.errorMessage, null);
  });
  test('user cannot authorize if its name not in database', () async {
    Future<AuthResult> result =
        AuthorizationManager().authorize("test3", "test3");
    var res = await result;
    expect(res.isAuthorized, false);
    expect(
        res.errorMessage, "No active account found with the given credentials");
  });
  test(
      'If user authorizes with null entries, it is probably loss of server connection',
      () async {
    Future<AuthResult> result = AuthorizationManager().authorize("", "");
    var res = await result;
    expect(res.isAuthorized, false);
    expect(res.errorMessage, "Connection to server lost.");
  });
  group('In case of impossibility to authorize', () {
    //check whole group, not individual test
    if (AuthorizationManager().isAuthorized() == true) {
      AuthorizationManager().logout();
    }
    test('Authorization of unknown account fails', () async {
      Future<AuthResult> result =
          AuthorizationManager().authorize("test5", "test5");
      var res = await result;
      expect(res.isAuthorized, false);
      expect(res.errorMessage,
          "No active account found with the given credentials");
    });
    test(
        'Checking if user is authorized works successfully (fails if account is not authorized',
        () async {
      Future<bool> result = AuthorizationManager().isAuthorized();
      expect(await result, false);
    });
  });
}
