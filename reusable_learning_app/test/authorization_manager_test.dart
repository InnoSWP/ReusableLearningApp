import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:reusable_app/authorization/authorization_manager.dart';
import 'package:reusable_app/models/utilities/server_settings.dart';
import 'package:reusable_app/models/utilities/token_api.dart';
import 'package:reusable_app/screens/forms/auth_form.dart';

void main() {
  test('yes', () async {
    Future<AccountCreateResult> result = AuthorizationManager()
        .registerAccount("zufar@mail.ru", "user1234", "helloworld");
    var res = await result;
    expect(res.errorMessage, null);
  });
}
// class MockDio extends Mock implements Dio {}
//
// void main() {
//   group('fetchAlbum', () {
//     TokenApi tokenApi;
//
//     test('returns an Album if the http call completes successfully', () async {
//       final _dio = MockDio();
//       var data = {"username": "use", "password": "1234"};
//       // Use Mockito to return a successful response when it calls the
//       // provided http.Client.
//       when(_dio.post("${ServerSettings.baseUrl}/users/login/",
//               data: data,
//               queryParameters: {"Content-Type": "application/json"}))
//           .thenAnswer((_) async {
//         Response? response;
//         response?.statusCode = 401;
//         return response!;
//       });
//
//       expect(await AuthorizationManager().authorize("use", "1234"),
//           AuthResult().isAuthorized);
//     });
//
//     test('throws an exception if the http call completes with an error', () {
//       final client = MockClient();
//
//       // Use Mockito to return an unsuccessful response when it calls the
//       // provided http.Client.
//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));
//
//       expect(fetchAlbum(client), throwsException);
//     });
//
//     test('', () {
//
//     })
//   });
// }
