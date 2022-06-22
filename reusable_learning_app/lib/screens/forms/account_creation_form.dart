import 'package:flutter/material.dart';
import '/authorization/authorization_manager.dart';
import 'package:get/get.dart';


class CreatePasswordFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Please entry password".tr : null;
  }
}

class CreateUsernameFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Please entry username".tr : null;
  }
}

class CreateEmailFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Please entry email".tr : null;
  }
}

class AccountCreationForm extends StatelessWidget {
  final manager = AuthorizationManager();
  final _formKey = GlobalKey<FormState>();
  AccountCreationForm({Key? key}) : super(key: key);

  String _username = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: "Username".tr,
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  fillColor: Colors.white,
                  filled: true,
                  errorStyle:
                      const TextStyle(fontSize: 15, color: Color(0xFFFF5F5F)),
                ),
                validator: (value) =>
                    CreateUsernameFieldValidator.validate(value!),
                onSaved: (value) {
                  _username = value!;
                },
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
                decoration: InputDecoration(
                  hintText: "Email".tr,
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  fillColor: Colors.white,
                  filled: true,
                  errorStyle:
                      const TextStyle(fontSize: 15, color: Color(0xFFFF5F5F)),
                ),
                validator: (value) =>
                    CreateEmailFieldValidator.validate(value!),
                onSaved: (value) {
                  _email = value!;
                },
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18
              ),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password".tr,
                hintStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)),
                fillColor: Colors.white,
                filled: true,
                errorStyle:
                    const TextStyle(fontSize: 15, color: Color(0xFFFF5F5F)),
              ),
              validator: (value) =>
                  CreatePasswordFieldValidator.validate(value!),
              onSaved: (value) {
                _password = value!;
              },
            )
          ),
          ElevatedButton(
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(const TextStyle(
                    color: Colors.white, fontSize: 15, letterSpacing: 1))),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                var result = await manager.registerAccount(
                    _email, _username, _password);
                if (result.isCreated) {
                  Navigator.pushNamed(context, "/home");
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error".tr),
                        content: Text(result.errorMessage!),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"))
                        ],
                      );
                    }
                  );
                }
              }
            },
            child: Text("Create Account".tr,
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(Colors.grey[300])),
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text("Sign In".tr,
                style: const TextStyle(
                    color: Colors.purple, fontSize: 15, letterSpacing: 1)),
          ),
        ],
      ),
    );
  }
}
