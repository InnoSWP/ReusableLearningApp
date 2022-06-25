import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/token_secure_storage.dart';
import 'package:reusable_app/screens/forms/auth_form.dart';

void main() {
  var manager = AuthorizationManager(storage: TokenSecureStorage());

  group('Manager works fully', () {
    //check whole group, not individual test
    test('Registration of new account works successfully', () async {
      Future<AccountCreateResult> result = manager
          .registerAccount("test1@mail.ru", "test1", "test1");
      var res = await result;
      expect(res.errorMessage, null);
    });
    test('Authorization of registered account works successfully', () async {
      Future<AuthResult> result = manager
          .authorize("test1", "test1");
      var res = await result;
      expect(res.isAuthorized, true);
    });
    test('Checking if user is authorized works successfully', () async {
      Future<bool> result = manager.isAuthorized();
      expect(await result, true);
    });
    manager.logout();
  });
  test('registration works successfully', () async {
    Future<AccountCreateResult> result =
        manager.registerAccount("test2", "test2", "test2");
    var res = await result;
    expect(res.errorMessage, null);
  });
  test('user cannot authorize if its name not in database', () async {
    Future<AuthResult> result =
        manager.authorize("test3", "test3");
    var res = await result;
    expect(res.isAuthorized, false);
    expect(
        res.errorMessage, "No active account found with the given credentials");
  });
  test(
      'If user authorizes with null entries, it is probably loss of server connection',
      () async {
    Future<AuthResult> result = manager.authorize("", "");
    var res = await result;
    expect(res.isAuthorized, false);
    expect(res.errorMessage, "Connection to server lost.");
  });
  group('In case of impossibility to authorize', () async {
    //check whole group, not individual test
    if (await manager.isAuthorized()) {
      manager.logout();
    }
    test('Authorization of unknown account fails', () async {
      Future<AuthResult> result =
          manager.authorize("test5", "test5");
      var res = await result;
      expect(res.isAuthorized, false);
      expect(res.errorMessage,
          "No active account found with the given credentials");
    });
    test(
        'Checking if user is authorized works successfully (fails if account is not authorized',
        () async {
      Future<bool> result = manager.isAuthorized();
      expect(await result, false);
    });
  });
}
