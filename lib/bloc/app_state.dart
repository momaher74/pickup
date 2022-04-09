part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ChangeNavSuccessState extends AppState {}
class CancelImageSuccessState extends AppState {}

class PickProdImgSuccessState extends AppState {}

class PickProdImgErrorState extends AppState {}

class LoginLoadingState extends AppState {}

class LoginSuccessState extends AppState {}

class LoginErrorState extends AppState {}

class RegisterLoadingState extends AppState {}

class RegisterSuccessState extends AppState {}

class RegisterErrorState extends AppState {}

class UploadLoadingState extends AppState {}

class UploadSuccessState extends AppState {}

class UploadErrorState extends AppState {}

class GetImgLoadingState extends AppState {}

class GetImgSuccessState extends AppState {}

class GetImgErrorState extends AppState {}
