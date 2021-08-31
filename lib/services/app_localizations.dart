import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Translations {
  Translations(Locale locale) {
    print('ini local Msuk: $locale');

    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  String text(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<Translations> load(Locale locale) async {
    Translations translations = new Translations(locale);
    String jsonContent = await rootBundle
        .loadString("assets/localization_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', locale.toString());
    return translations;
  }

  get currentLanguage => locale.languageCode;
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) =>
      Translations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  final Locale newLocale;
  const TranslationsDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return ["id", "en"].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) {
    return Translations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) {
    return true;
  }
}
