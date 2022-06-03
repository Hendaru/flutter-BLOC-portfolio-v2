import 'package:dio/dio.dart';
import 'package:lime_commerce/utils/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dioInstance = Dio();
createInstance() async {
  var option = BaseOptions(
      baseUrl: Api.BASE_URL, connectTimeout: 10000, receiveTimeout: 10000);

  dioInstance = Dio(option);
  // dioInstance.interceptors.add(PrettyDioLogger(
  //     requestHeader: true,
  //     requestBody: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true,
  //     compact: true,
  //     maxWidth: 90));
}

Future<Dio> dio() async {
  await createInstance();
  // dioInstance.options.baseUrl = Api.BASE_URL;
  return dioInstance;
}
