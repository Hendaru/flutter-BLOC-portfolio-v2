part of 'homeCubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingPageState extends HomeState {}

class HomeLoadingMoreState extends HomeState {}

class HomeLoadedState extends HomeState {
  late List<Products> dataProducts;
  HomeLoadedState({required this.dataProducts});
  List<Object> get props => [dataProducts];
}

class HomeErrorState extends HomeState {}
