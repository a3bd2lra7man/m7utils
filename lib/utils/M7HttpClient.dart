part of m7utils;

enum RequestType{
  getT,post,put
}

typedef HttpRequester = Future<HttpClientRequest> Function(Uri);
M7Client _client;

class M7Client{

  String localhost ;
  String _token;


  HttpClient httpClient;

  factory M7Client({String localhost}){
    if(_client == null){
      _client = M7Client._initial(localhost);
    }
    _client.localhost ??= localhost ;
    return _client;
  }


  M7Client._initial(this.localhost){
    this.httpClient = HttpClient()
      ..badCertificateCallback = ((X509Certificate cert ,String host,int port)=>true);
  }


  dynamic _toJson(Map map) =>  utf8.encode(json.encode(map));


  HttpRequester _checkRequestType(RequestType requestType){

    HttpRequester request;
    switch(requestType){
      case RequestType.getT:
        request =  this.httpClient.getUrl;
        break;
      case RequestType.post:
        request = this.httpClient.postUrl;
        break;
      case RequestType.put:
        request = this.httpClient.putUrl;
        break;
    }
    return request;

  }
  Future request({RequestType requestType,String url,Map data,bool isSecure = false})async{

    try {

      HttpClientRequest request = await _checkRequestType(requestType)(Uri.parse("${this.localhost}/$url"),);
      request.headers.add(HttpHeaders.contentTypeHeader, 'application/json');
      if(isSecure) request.headers.add(HttpHeaders.authorizationHeader, "Bearer $_token");
      if(data != null)  request.add(this._toJson(data));
      return await _getResponse(request);

    }catch(e){
      print(e);
      return this._errorMessage;

    }
  }


  Future<Map> _getResponse(HttpClientRequest request )async{

    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    Map res = json.decode(reply);
    print("response from server : -------------------------------------------------------- \n $res");
    return res;

  }

  Map _errorMessage = {
    "resultCode" : 0,
    "errorEnMessage" : "there is no internet",
    "errorArMessage" : "لا يوجد اتصال بالانترنت"
  };

  void setToken(String token){
    _token = token;
  }
}