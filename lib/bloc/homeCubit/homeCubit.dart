import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lime_commerce/model/DataProductModel.dart';
import 'package:lime_commerce/services/apiService.dart';
import 'package:meta/meta.dart';

part 'homeState.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<Products> temporaryDataProducts = [];
  int limit = 2;
  int skip = 0;
  Future getDataProducts() async {
    try {
      emit(HomeLoadingPageState());
      temporaryDataProducts = [];
      ApiService apiServices = ApiService();
      Response? response = await apiServices.loadProduct("10", "1");
      if (response?.statusCode == 200) {
        var res = DataProductsModel.fromJson(response?.data);
        skip = int.parse(res.skip!);
        res.products?.forEach((v) => temporaryDataProducts.add(v));
        emit(HomeLoadedState(dataProducts: temporaryDataProducts));
      } else {
        emit(HomeErrorState());
      }
    } catch (e) {
      emit(HomeErrorState());
    }
  }
}
