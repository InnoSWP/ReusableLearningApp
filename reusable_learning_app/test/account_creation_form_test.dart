import 'package:flutter_test/flutter_test.dart';
import 'package:reusable_app/screens/forms/account_creation_form.dart';

void main() {
  // testing CI
  test('empty username returns error string', () async {
    var result = CreateUsernameFieldValidator.validate('');
    expect(result, 'Please entry username');
  });

  test('non-empty username returns null', () async {
    var result = CreateUsernameFieldValidator.validate('username');
    expect(result, null);
  });

  test('empty email returns error string', () async {
    var result = CreateEmailFieldValidator.validate('');
    expect(result, 'Please entry email');
  });

  test('non-empty email returns null', () async {
    var result = CreateEmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () async {
    var result = CreatePasswordFieldValidator.validate('');
    expect(result, 'Please entry password');
  });

  test('non-empty password returns null', () async {
    var result = CreatePasswordFieldValidator.validate('password');
    expect(result, null);
  });
}
