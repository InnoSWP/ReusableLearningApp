import 'package:flutter/material.dart';
import '/authorization/authorization_manager.dart';

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
                    color: Colors.black
                ),
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: const TextStyle(
                      color: Colors.black
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  errorStyle: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFFFF5F5F)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },

                onSaved: (value) {
                  _username = value!;
                },
              )
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.black
              ),
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: const TextStyle(
                  color: Colors.black
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6)
                ),
                fillColor: Colors.white,
                filled: true,
                errorStyle: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFFFF5F5F)
                ),

              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            )
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              style: const TextStyle(
                color: Colors.black
              ),
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: const TextStyle(
                  color: Colors.black
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6)
                ),
                fillColor: Colors.white,
                filled: true,
                errorStyle: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFFFF5F5F)
                ),


              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            )
          ),
          ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  color: Colors.purple,
                  fontSize: 15,
                  letterSpacing: 1
                )
              )
            ),
            onPressed: () async {
              if(_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                var result = await AuthorizationManager()
                  .registerAccount(_email, _username, _password);
                if (result.isCreated) {
                  Navigator.pushNamed(context, "/");
                }
                else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text(result.errorMessage!),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK")
                          )
                        ],
                      );
                    }
                  );
                }
              }
            },
            child: const Text("Create Account")
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              overlayColor: MaterialStateProperty.all(Colors.grey[300])
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text(
              "Sign In",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 15,
                letterSpacing: 1
              )
            ),
          ),

        ],
      ),
    );
  }

}