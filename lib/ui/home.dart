import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lime_commerce/bloc/homeCubit/homeCubit.dart';
import 'package:lime_commerce/model/DataProductModel.dart';
import 'package:lime_commerce/utils/typography.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../common/widget/helperWidget.dart';

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
            return lazyLoadData(state, context);
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

  LazyLoadScrollView lazyLoadData(HomeState state, BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      locale: "en_US",
      symbol: "USD ",
      decimalDigits: 0,
    );

    return LazyLoadScrollView(
      isLoading: (state is HomeLoadingMoreState) ? true : false,
      onEndOfPage: () {
        context.read<HomeCubit>().loadMoreData();
      },
      child: ListView(
        children: [
          MasonryGridView.count(
            padding: EdgeInsetsDirectional.all(10),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (_, index) {
              Products? dataProduct = mainDataProduct[index];
              var priceDiscount = dataProduct!.price! -
                  ((dataProduct.price! / 100) *
                      dataProduct.discountPercentage!);
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 0.5, color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: kElevationToShadow[1],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      image("${dataProduct.thumbnail}"),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${dataProduct.title}",
                              style: titleProductTextStyle,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              formatCurrency.format(priceDiscount),
                              style: priceProductTextStyle,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            dataProduct.discountPercentage != 0
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.redAccent.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                        child: Text(
                                          "${dataProduct.discountPercentage.toString()}%",
                                          style: discountProductTextStyle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1.h,
                                      ),
                                      Text(
                                        "${formatCurrency.format(dataProduct.price)}",
                                        style: priceLineThroughProductTextStyle,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                  size: 5.w,
                                ),
                                SizedBox(
                                  width: 1.h,
                                ),
                                Text(
                                  "${dataProduct.rating.toString()}",
                                  style: subTitleProductTextStyle,
                                ),
                                dividerVertical(3.w),
                                Text(
                                  "Stock",
                                  style: subTitleProductTextStyle,
                                ),
                                SizedBox(
                                  width: 1.h,
                                ),
                                Text(
                                  "${dataProduct.stock.toString()}",
                                  style: subTitleProductTextStyle,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ));
            },
            itemCount: mainDataProduct.length,
          ),
          (state is HomeLoadingMoreState)
              ? Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    height: 5.w,
                    width: 5.w,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
