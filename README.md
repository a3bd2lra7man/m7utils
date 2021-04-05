# m7db

A Simple Dart Package that helps to fast development 

    1- gives screen width by using extension
    
    2- gives screen height by using extension
    
    3- gives app theme by using extension
    
    4- gives app text theme by using extension

    5- helps with translation

    6- gives default AppLocalization class

## Whats will you get in the end 

```dart
import 'package:m7utils/m7utils.dart';


main(){
    // the width
    context.width;

    // the height
    context.height;

    // the app them
    context.theme;

    // the app text them 
    context.textTheme;

    // to return to the prevouis page in the stack
    context.pop();

    context.popWithResult("dynamic");

    // if you are using assets/lang/localeCode.json
    context.translate('key');
}  
``` 

