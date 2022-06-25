import 'package:flutter_test/flutter_test.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';

import 'mocks/mock_storage.dart';

void main() {
  var manager = AuthorizationManager(storage: MockStorage());

  group('Manager works fully', () {
    //check whole group, not individual test
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
    expect(res.errorMessage, "Bad Request");
  });
  group('In case of impossibility to authorize', () {
    //check whole group, not individual test
    test('Authorization of unknown account fails', () async {
      if (await manager.isAuthorized()) {
        manager.logout();
      }
      Future<AuthResult> result =
          manager.authorize("test5", "test5");
      var res = await result;
      expect(res.isAuthorized, false);
      expect(res.errorMessage,
          "No active account found with the given credentials");
    });
    test('Checking if user is authorized works successfully (fails if account is not authorized', () async {
      Future<bool> result = manager.isAuthorized();
      expect(await result, false);
    });
  });
}
