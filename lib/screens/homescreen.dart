import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pickup/bloc/app_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context) ;
    return BlocConsumer<AppCubit,AppState>(
      listener: (context , state){},
      builder: (context , state)=> Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Pick up '),
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: CurvedNavigationBar(

          index: cubit.currentIndex,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.upload_rounded, size: 30, color: Colors.deepPurple,),
            Icon(Icons.image, size: 30 , color: Colors.deepPurple,),

          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 350),
          onTap: (int index) {
            print(index) ;
            cubit.changeNav(index) ;
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
