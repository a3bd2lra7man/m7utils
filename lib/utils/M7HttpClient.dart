part of m7utils;

enum RequestType { GET, POST, PUT }
enum BodyType { form, json }

typedef HttpRequester = Future<HttpClientRequest> Function(Uri);
M7Client? _client;

class M7Client {
  String? localhost;
  String? _token;

  late HttpClient httpClient;

  factory M7Client({required String localhost}) {
    if (_client == null) {
      _client = M7Client._initial(localhost);
    }
    _client!.localhost ??= localhost;
    return _client!;
  }

  M7Client._initial(this.localhost) {
    this.httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true)
      ..connectionTimeout = Duration(seconds: 30);
  }

  List<int> _toRawShape(Map map) => utf8.encode(json.encode(map));

  List<int> _toFormShape(Map map) =>
      utf8.encode(Uri.encodeQueryComponent(json.encode(map))); // utf8 encode

  HttpRequester _checkRequestType(RequestType requestType) {
    HttpRequester request;
    switch (requestType) {
      case RequestType.GET:
        request = this.httpClient.getUrl;
        break;
      case RequestType.POST:
        request = this.httpClient.postUrl;
        break;
      case RequestType.PUT:
        request = this.httpClient.putUrl;
        break;
    }
    return request;
  }

  String _getContentType(BodyType bodyType) {
    switch (bodyType) {
      case BodyType.form:
        return 'application/x-www-form-urlencoded';
      case BodyType.json:
        return 'application/json';
    }
  }

  Future request({
    required RequestType requestType,
    required String url,
    Map? data,
    BodyType bodyType = BodyType.json,
    bool isSecure = false,
  }) async {
    try {
      HttpClientRequest request = await _checkRequestType(requestType)(
        Uri.parse("${this.localhost}/$url"),
      );
      request.headers
          .add(HttpHeaders.contentTypeHeader, _getContentType(bodyType));
      if (isSecure)
        request.headers.add(HttpHeaders.authorizationHeader, "Bearer $_token");
      if (data != null) request.add(_getDataShape(bodyType, data));
      return await _getResponse(request);
    } catch (e) {
      print(e);
      return this._errorMessage;
    }
  }

  List<int> _getDataShape(BodyType bodyType, Map data) {
    switch (bodyType) {
      case BodyType.form:
        return _toFormShape(data);
      case BodyType.json:
        return _toRawShape(data);
    }
  }

  Future<Map> _getResponse(HttpClientRequest request) async {
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    Map res = json.decode(reply);
    print(
        "response from server : -------------------------------------------------------- \n $res");
    return res;
  }

  Map _errorMessage = {
    "resultCode": 0,
    "errorEnMessage": "there is no internet",
    "errorArMessage": "لا يوجد اتصال بالانترنت"
  };

  void setToken(String token) {
    _token = token;
  }
}
