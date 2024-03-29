part of m7utils;

class M7Preferences {
  Future<SharedPreferences> getSharedPreference() async =>
      await SharedPreferences.getInstance();

  Future<String?> getStringFromSharedPreferences(String key) async =>
      (await getSharedPreference()).getString(key);

  Future<bool> setStringInSharedPreference(String key, String value) async =>
      (await getSharedPreference()).setString(key, value);
}
