import 'package:dart_week_app/app/core/custom_dio.dart';
import 'package:dart_week_app/app/models/categoria_model.dart';

class CategoriaRepository {
  Future<List<CategoriaModel>> getCategorias(String tipo) {
    final dio = CustomDio.withAuthentication().instance;

    return dio.get('/categorias/$tipo')
    .then((response) => 
      response
      .data
      .map<CategoriaModel>((c) => CategoriaModel.fromMap(c)).toList()
    );
  }
}