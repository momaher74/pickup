import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pickup/bloc/app_cubit.dart';
import 'package:pickup/bloc/cachhelper.dart';
import 'package:pickup/screens/homescreen.dart';
import 'package:pickup/screens/loginscreen.dart';

import 'bloc/obs.dart';

String? uId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId') ;
  print(uId.toString() + '    *kkkkkkkkkkkkkkk5555555555555555555555555555555');
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit()..getImg(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home: uId==null?const LoginScreen(): const HomeScreen(),
          );
        },
      ),
    );
  }
}
