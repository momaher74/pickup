import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:pickup/bloc/cachhelper.dart';
import 'package:pickup/main.dart';
import 'package:pickup/screens/uploadimg.dart';
import 'package:pickup/screens/viewimgs.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeNav(int index) {
    currentIndex = index;
    print('current index = $index');
    emit(ChangeNavSuccessState());
  }

  List<Widget> screens = const [
    UploadScreen(),
    ViewScreen(),
  ];
  List images = [];

  void getImg() {
    emit(GetImgLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('images')
        .get()
        .then((value) {
      print(value.docs);
      for (var element in value.docs) {
        images.add(element);
      }
      emit(GetImgSuccessState());
    }).catchError((error) {
      emit(GetImgErrorState());
    });
  }

  void uploadImg() {
    emit(UploadLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('images' + Uri.file(prodImage!.path).pathSegments.last)
        .putFile(prodImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .collection('images')
            .add({
          'link': value,
        }).then((value) {
          emit(UploadSuccessState());
        }).catchError((error) {
          print(error);
          emit(UploadErrorState());
        });
      });
    }).catchError((error) {
      print(error);
      emit(UploadErrorState());
    });
  }

  void register({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: 'uId', value: value.user?.uid);
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CacheHelper.saveData(key: 'uId', value: value.user?.uid);
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

  ImagePicker picker = ImagePicker();
  File? prodImage;

  Future<void> pickProductImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      prodImage = File(pickedFile.path);
      print(prodImage);
      emit(PickProdImgSuccessState());
    } else {
      print('No  Profile image selected.');
      emit(PickProdImgErrorState());
    }
  }

  void cancelImage() {
    prodImage = null;
    emit(CancelImageSuccessState());
  }
}
