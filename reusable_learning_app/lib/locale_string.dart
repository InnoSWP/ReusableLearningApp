import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalString extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US':{
      'Home' : 'Home',
      'Shop' : 'Shop',
      'Achievements' : 'Achievements',
      'Settings' : 'Settings',

      'LEARN' : 'LEARN',
      'No name' : 'No name',
      "Student" : "Student",
      "Favorite courses" : "Favorite courses",
      "Favorite lessons" : "Favorite lessons",
      "Chat with developers" : "Chat with developers",
      "Edit courses/lessons" : "Edit courses/lessons",

      "Connection to server lost." : "Connection to server lost.",
      "No active account found with the given credentials" : "No active account found with the given credentials",
      "A user with that username already exists." : "A user with that username already exists.",
      "Some error happened" : "Some error happened",

      'Lesson' : 'Lesson',
      "Complete lesson" : "Complete lesson",
      "No lessons attached" : "No lessons attached",
      "Please entry password" : "Please entry password",
      "Please entry username" : "Please entry username",
      "Username" : "Username",
      "Password" : "Password",
      "Error" : "Error",
      "Sign In" : "Sign In",
      "Create Account" : "Create Account",
      "Please entry email" : "Please entry email",
      "Email" : "Email",
      "Shop page" : "Shop page",
      "Night mode" : "Night mode",
      "General" : "General",
      "Language" : "Language",
      "Audio" : "Audio",
      "Notifications" : "Notifications",
      "Get Support" : "Get Support",
      'Level' : 'Level',
      'points' : 'points',
      'to Level' : 'to Level',
      'lessons' : 'lessons',
      'day' : 'day',
      "streak" : "streak",
      'min' : 'min',

      'No notifications yet' : "No notifications yet",
      "Notification" : "Notification",
      "Hey! It is time to learn!" : "Hey! It is time to learn!",
      "New Notification!" : "New Notification!",
      'Notification has been created!' : 'Notification has been created!',
      "Enable daily reminder" : "Enable daily reminder",
      "Select Time" : "Select Time",
      "Submit" : "Submit",
      "Input message:" : "Input message:",

      "Cancel" : "Cancel",
      "Select time" : "Select time",
      "Hour" : "Hour",
      "Minute" : "Minute",


    },
    'ru_RU':{
      'Home' : 'Главная',
      'Shop' : 'Магазин',
      'Achievements' : 'Достижения',
      'Settings' : 'Настройки',

      'LEARN' : 'УЧИТЬ',
      'No name' : 'Без имени',
      "Student" : "Ученик",
      "Favorite courses" : "Избранные курсы",
      "Favorite lessons" : "Избранные уроки",
      "Chat with developers" : "Чат с разработчиками",
      "Edit courses/lessons" : "Редактировать курсы/уроки",

      "Connection to server lost." : "Соединение с сервером потеряно.",
      "No active account found with the given credentials" : "Не найдено пользователя с такими данными.",
      "A user with that username already exists." : "Пользователь с такими данными уже существует.",
      "Some error happened" : "Произошла ошибка.",

      'Lesson' : 'Урок',
      "Complete lesson" : "Выполнить урок",
      "No lessons attached" : "Нет прикрепленных уроков",
      "Please entry password" : "Пожалуйста, введите пароль",
      "Please entry username" : "Пожалуйста, введите имя пользователя",
      "Username" : "Имя пользователя",
      "Password" : "Пароль",
      "Error" : "Ошибка",
      "Sign In" : "Войти",
      "Create Account" : "Создать аккаунт",
      "Please entry email" : "Пожалуйста, введите электронную почту",
      "Email" : "Электронная почта",
      "Shop page" : "Магазин",
      "Night mode" : "Темная тема",
      "General" : "Основное",
      "Language" : "Язык",
      "Audio" : "Аудио",
      "Notifications" : "Уведомления",
      "Get Support" : "Помощь",
      'Level' : 'Уровень',
      'points' : 'Очки',
      'to Level' : 'до Уровня',
      'lessons' : 'уроки',
      'day' : 'дни',
      "streak" : "подряд",
      'min' : 'мин',

      'No notifications yet' : "Нет новых уведомлений",
      "Notification" : "Уведомление",
      "Hey! It is time to learn!" : "Хей! Самое время для учебы!",
      "New Notification!" : "Новое уведомление!",
      'Notification has been created!' : 'Уведомление создано!',
      "Enable daily reminder" : "Включить ежедневное уведомление",
      "Select Time" : "Выбрать время",
      "Submit" : "Отправить",
      "Input message:" : "Текст уведомления:",

      "Cancel" : "Назад",
      "Select time" : "Выберите время",
      "Hour" : "Часы",
      "Minute" : "Минуты",
    }
  };
}

var stringToLocale = {
  'Русский' : Locale('ru', 'Ru'),
  'English' : Locale('en', 'US')
};
var localeToString = {
  Locale('ru-RU') : 'Русский',
  Locale('en-US') : 'English'
};