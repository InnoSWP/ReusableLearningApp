import 'package:flutter/material.dart';
import 'package:reusable_app/models/utilities/custom_colors.dart';
import '/authorization/authorization_manager.dart';
import 'package:get/get.dart';


class PasswordFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Please entry password".tr : null;
  }
}

class UsernameFieldValidator {
  static String? validate(String value) {
    return value.isEmpty ? "Please entry username".tr : null;
  }
}

class AuthForm extends StatelessWidget {
  final manager = AuthorizationManager();
  final _formKey = GlobalKey<FormState>();
  AuthForm({Key? key}) : super(key: key);

  String _username = '';
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
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Username".tr,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6)),
                fillColor: Colors.white,
                filled: true,
                errorStyle:
                    const TextStyle(fontSize: 15, color: Color(0xFFFF5F5F)),
              ),
              validator: (value) => UsernameFieldValidator.validate(value!),
              onSaved: (value) {
                _username = value!;
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password".tr,
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6)),
                fillColor: Colors.white,
                filled: true,
                errorStyle:
                  const TextStyle(fontSize: 15, color: Color(0xFFFF5F5F)),
              ),
              validator: (value) => PasswordFieldValidator.validate(value!),
              onSaved: (value) {
                _password = value!;
              },
            )
          ),
          ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(

                  fontSize: 15,
                  letterSpacing: 1
                )
              )
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                var result = await AuthorizationManager()
                  .authorize(_username, _password);
                if (result.isAuthorized) {
                  Navigator.pushNamed(context, "/home");
                }
                else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text("Error".tr),
                      content: Text(result.errorMessage!),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, "OK"),
                          child: const Text("OK"),

                        )
                      ],
                    )
                  );
                }
              }
            },
            child: Text(
              "Sign In".tr,
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(Colors.grey[300])),
            onPressed: () {
              Navigator.pushNamed(context, "/create");
            },
            child: Text("Create Account".tr,
              style: const TextStyle(
                color: Colors.purple, fontSize: 15, letterSpacing: 1
              )
            ),
          )
        ],
      ),
    );
  }
}
