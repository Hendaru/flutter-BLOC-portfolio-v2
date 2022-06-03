import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'router/appRoute.dart';
import 'bloc/homeCubit/homeCubit.dart';
import 'router/routeName.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        title: 'Lime Commerce',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RouteName.home,
        onGenerateRoute: AppRouter().onGenerateRoute,
      ),
    );
  }
}
