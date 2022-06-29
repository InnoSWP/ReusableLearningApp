import 'package:flutter/material.dart';
import 'package:reusable_app/locale_string.dart';
import 'package:reusable_app/models/token_secure_storage.dart';
import 'package:reusable_app/models/utilities/notification_service.dart';
import 'package:reusable_app/providers/theme_provider.dart';
import 'package:reusable_app/screens/drawer/fav_courses.dart';
import 'package:reusable_app/screens/home.dart';
import 'package:reusable_app/screens/lessons/course_screen.dart';
import 'package:reusable_app/screens/lessons/lesson_screen.dart';
import 'authorization/authorization_manager.dart';
import 'models/utilities/themes.dart';
import 'screens/authorization/authorization_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

late SharedPreferences prefs;
Future<void> setDefault() async{
  if(prefs.getString('dropdownValue') == null){
    prefs.setBool('nightMode', false);
    prefs.setBool('audioOn', false);
    String? deviceLanguage = await Devicelocale.currentLocale;
    String language = '';
    if(localeToString.containsKey(Locale(deviceLanguage!))){
      language = (localeToString[Locale(deviceLanguage)])!;
    }
    else{
      language = 'English';
    }

    prefs.setString('dropdownValue', language);
  }
}

// main method
Future<void> main() async {
  AwesomeNotifications().initialize(null,
    [
      NotificationChannel(
        channelKey: "basic_channel",
        channelName: "Basic Notifications",
        channelDescription: "Basic Notifications Description",
        importance: NotificationImportance.High,
        channelShowBadge: true
      ),
      NotificationChannel(
        channelKey: "scheduled_channel",
        channelName: "Scheduled Notifications",
        channelDescription: "Scheduled Notifications Description",
        importance: NotificationImportance.High,
        locked: true,
        channelShowBadge: true
      ),
    ]
  );
  NotificationService.init();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  setDefault().then((value) => runApp(const LearningApp()));
}

class LearningApp extends StatefulWidget {
  const LearningApp({Key? key}) : super(key: key);

  @override
  State createState() => _LearningAppState();
}

class _LearningAppState extends State {

  var manager = AuthorizationManager(storage: TokenSecureStorage());
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        var provider = Provider.of<ThemeProvider>(context);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: LocalString(),
          locale: stringToLocale[prefs.getString('dropdownValue')],
          themeMode: provider.themeMode(),
          darkTheme: AppThemes.darkTheme,
          theme: AppThemes.lightTheme,
          routes: {
            "/home": (context) => Home(),
            "/authorize": (context) => const AuthorizationScreen(),
            "/create": (context) => const AuthorizationScreen(),
            "/course": (context) => const CourseScreen(),
            "/lesson": (context) => const LessonScreen(),
            "/favCourses": (context) => const FavCourses(),
            // TODO new routes: /favCourses, /favLessons, /devChat, /edit
          },
          home: FutureBuilder<bool>(
            future: manager.isAuthorized(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return Home();
                } else {
                  return const AuthorizationScreen();
                }
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }
}

