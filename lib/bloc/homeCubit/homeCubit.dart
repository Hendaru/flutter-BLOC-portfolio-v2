import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:lime_commerce/model/DataProductModel.dart';
import 'package:lime_commerce/services/apiService.dart';

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
      Response? response = await apiServices.loadProduct("10", "0");

      if (response?.statusCode == 200) {
        var res = DataProductsModel.fromJson(response?.data);
        skip = res.limit!;
        res.products?.forEach((v) => temporaryDataProducts.add(v));
        emit(HomeLoadedState(dataProducts: temporaryDataProducts));
      } else {
        emit(HomeErrorState());
      }
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  Future loadMoreData() async {
    try {
      emit(HomeLoadingMoreState());
      await Future.delayed(const Duration(milliseconds: 500));
      skip = skip += 1;
      ApiService apiServices = ApiService();
      Response? response =
          await apiServices.loadProduct(limit.toString(), skip.toString());
      if (response?.statusCode == 200) {
        var res = DataProductsModel.fromJson(response?.data);
        skip = int.parse(res.skip!);
        res.products?.forEach((v) => temporaryDataProducts.add(v));
        emit(HomeLoadedState(dataProducts: temporaryDataProducts));
      } else {
        emit(HomeErrorState());
      }
    } catch (e) {
      print(e);
      emit(HomeErrorState());
    }
  }
}
