import 'package:dart_week_app/app/repositories/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CustomDio {
  var _dio;

  CustomDio() {
    print('entrou no dio');
    _dio = Dio(_options);
  }

  Dio get instance => _dio;

  // Constructor Nomeado com autenticação
  CustomDio.withAuthentication() {
    _dio = Dio(_options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: _onRequest,
      onResponse: _onResponse,
      onError: _onError
    ));
  }

  BaseOptions _options = BaseOptions(
    baseUrl: 'http://192.168.0.68:8888',
    connectTimeout: 30000,
    receiveTimeout: 30000
  );

  _onRequest(RequestOptions options) async{
    print(options.headers['baseUrl']);
    var token = await UsuarioRepository().getToken();
    options.headers['Authorization'] = token;

  }

  _onResponse(Response e) {
    print('######## Reponse Log');
    print(e.data);
    print('####### Response Log');
  }
  
  _onError(DioError e) {
    if (e.response?.statusCode == 403 || e.response?.statusCode == 401) {
      UsuarioRepository().logout();
      Get.offAllNamed('/');
    }

    return e;
  }


} 
