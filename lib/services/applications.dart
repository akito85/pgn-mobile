import 'dart:ui';

typedef void LocaleChangeCallback(Locale locale);

class APPLIC {
  final List<String> supportedLanguages = ['Indonesia', 'English'];
  final List<String> supportedLanguagesCodes = [
    "id",
    "en",
  ];

  Iterable<Locale> supportedLocales() => supportedLanguagesCodes
      .map<Locale>((language) => new Locale(language, ""));

  LocaleChangeCallback onLocaleChanged;

  static final APPLIC _applic = new APPLIC._internal();

  factory APPLIC() {
    return _applic;
  }
  APPLIC._internal();
}

APPLIC applic = APPLIC();
