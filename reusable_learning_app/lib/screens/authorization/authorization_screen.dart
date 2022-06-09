import 'package:flutter/material.dart';
import 'package:reusable_app/screens/Forms/auth_form.dart';
import '../../models/utilities/custom_colors.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State createState() => _AuthorizationScreenState();
}
class _AuthorizationScreenState extends State {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        color: CustomColors.purple,
        child: Center(
          child: SizedBox(
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:  [
                const Expanded(
                  child: Text(
                    "ReusApp",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Expanded(
                  flex: 4,
                  child: AuthForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}