import 'package:dio/dio.dart';
import 'package:lime_commerce/services/dioConfigService.dart' as dioConfig;
import 'package:lime_commerce/utils/constant.dart';

class ApiService {
  Future<Response?> loadProduct(String limit, String skip) async {
    final dio = await dioConfig.dio();
    final response = await dio.get(Api.BASE_URL + "limit=$limit&skip=$skip");
    return response;
  }
}
