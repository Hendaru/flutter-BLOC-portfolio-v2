part of 'homeCubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoadingPageState extends HomeState {}

class HomeLoadingMoreState extends HomeState {}

class HomeLoadedState extends HomeState {
  late List<Products> dataProducts;
  HomeLoadedState({
    required this.dataProducts,
  });
  @override
  List<Object> get props => [dataProducts];
}

class HomeErrorState extends HomeState {}
