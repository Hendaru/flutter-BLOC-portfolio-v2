import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lime_commerce/bloc/homeCubit/homeCubit.dart';
import 'package:lime_commerce/model/DataProductModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Products?> mainDataProduct;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigator.of(context).pushNamed(
      //     //   RouteName.createEmployee,
      //     // );
      //     BlocProvider.of<HomeCubit>(context).getDataProducts();
      //   },
      //   backgroundColor: Colors.blue,
      //   child: const Icon(Icons.add),
      // ),
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Home",
          style: TextStyle(fontSize: 20),
        ),
        leading: null,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFF01AEA7), Color(0xFF2B6080)])),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingPageState || state is HomeErrorState) {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              ),
            );
          } else if (state is HomeLoadedState ||
              state is HomeLoadingMoreState) {
            if (state is HomeLoadedState) {
              mainDataProduct = state.dataProducts;
            }
            // print((state is HomeLoadingMoreState) ? true : false);
            return LazyLoadScrollView(
              isLoading: (state is HomeLoadingMoreState) ? true : false,
              onEndOfPage: () {
                context.read<HomeCubit>().loadMoreData();
              },
              child: ListView(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (_, index) =>
                        Text("${mainDataProduct[index]?.id!}"),
                    itemCount: mainDataProduct.length,
                  ),
                  (state is HomeLoadingMoreState)
                      ? Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                            height: 20.0,
                            width: 20.0,
                          ),
                        )
                      : SizedBox()
                ],
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 50.0,
                width: 50.0,
              ),
            );
          }
        },
      ),
    );
  }
}
