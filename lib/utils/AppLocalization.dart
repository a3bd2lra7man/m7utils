part of m7utils;


mixin AppLocale on ChangeNotifier {

  String _localeName = "en";
  String get localeName => _localeName;

  void changeLocale() async {
    _localeName = _localeName == 'en' ? 'ar' : 'en';
    (await SharedPreferences.getInstance()).setString('locale', _localeName);
    notifyListeners();
  }

  bool get isEnglish => _localeName == 'en' ? true : false;
}

class AppLocalizations{


  AppLocalizations();


  static Locale getDeviceLocale(BuildContext context){
    return Localizations.localeOf(context);
  }

  static AppLocalizations of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String ,String> _localizedString;

  Future load (Locale locale) async{

    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String,dynamic> jsonMap = json.decode(jsonString);
    _localizedString = jsonMap.map((k,v){
      return MapEntry(k, v.toString());
    });


  }

  String translate(String key){
    return _localizedString[key];
  }
  static const LocalizationsDelegate delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations>{

  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale)async {
    AppLocalizations appLocalizations = AppLocalizations();
    await appLocalizations.load(locale);
    return appLocalizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old)=>false;

}


