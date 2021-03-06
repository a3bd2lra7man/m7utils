part of m7utils;


enum LoadingStatus {
  isLoading,isError,isData
}

mixin Loading on ChangeNotifier{

  LoadingStatus _status = LoadingStatus.isData;
  String errorMessage = "هناك خطأ ما يرجى المحاولة مرة أخرى" ;
  Widget get loadingWidget => Center(child: CircularProgressIndicator(),);

  bool get isLoading => _status == LoadingStatus.isLoading;
  bool get isError => _status == LoadingStatus.isError;
  bool get isData => _status == LoadingStatus.isData;

  Widget errorWidget(Function onClick,{String text,TextStyle textStyle,TextStyle buttonTextStyle})
  => Center(child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(errorMessage,style: textStyle,),
      ButtonTheme(
        buttonColor: Colors.grey[200],
        child: RaisedButton(
            onPressed: onClick, child: Text(text ??"حاول مجددا",style: buttonTextStyle,),
        ),
      )
    ],
  ),);

  void dataComes(){
    _status = LoadingStatus.isData;
    notifyListeners();
  }

  void errorCome(String error){
    _status = LoadingStatus.isError;
    errorMessage = error;
    notifyListeners();
  }
  void loading(){
    _status = LoadingStatus.isLoading;
    notifyListeners();
  }
}

class LoadingWidget extends StatelessWidget {
  final Loading loading;
  final Widget child;
  final Function onClick;
  const LoadingWidget({this.loading,this.child,this.onClick});

  @override
  Widget build(BuildContext context) {
    switch(loading._status){
      case LoadingStatus.isLoading:
        return loading.loadingWidget;
        break;
      case LoadingStatus.isError:
        return loading.errorWidget(onClick) ?? Center(child: Text(loading.errorMessage),);
        break;
      case LoadingStatus.isData:
        return child;
        break;
      default:
        return child;
        break;
    }
  }
}

