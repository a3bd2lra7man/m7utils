part of m7utils;

extension M7Extensions on BuildContext {
  // return the screen width
  double get width => MediaQuery.of(this).size.width;
  // return the screen height
  double get height => MediaQuery.of(this).size.height;
  // return the textTheme passed as ThemeData() in Material App
  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);
  // navigation helper to navigate to new screen
  Future navigateTo(Widget widget, {bool clearStack = false}) {
    return clearStack
        ? Navigator.pushAndRemoveUntil(this,
            MaterialPageRoute(builder: (context) => widget), (route) => false)
        : Navigator.push(this, MaterialPageRoute(builder: (context) => widget));
  }

  // navigation helper to navigate to new screen by tag 'tag === route identifier in route fields in [MaterialApp]'
  Future navigateToByTag(String route, {bool clearStack = false}) {
    return clearStack
        ? Navigator.pushNamedAndRemoveUntil(this, route, (route) => false)
        : Navigator.pushNamed(this, route);
  }

  // navigate back to previous one in the stack
  void pop() => Navigator.pop(this);

  // navigate back to previous one in the stack by tag
  void popWithResult(result) => Navigator.pop(this, result);

  // for translating
  String translate(String key) => AppLocalizations.of(this)!.translate(key);

  T provider<T extends ChangeNotifier>() => this.read<T>();

  T listen<T extends ChangeNotifier>() => this.watch<T>();
  void showNotImplemented() {
    showDialog(
        context: this,
        builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              children: <Widget>[
                SizedBox(
                  height: context.height * .05,
                ),
                Center(
                  child: Text("NOT IMPLEMENTED YET"),
                ),
                SizedBox(
                  height: context.height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.of(this).pop(),
                        child: Text("OK")),
                  ],
                )
              ],
            ));
  }
}
