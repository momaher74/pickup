import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


import '../bloc/app_cubit.dart';
import 'homescreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

bool isTrue = true;
IconData passIcon = Icons.visibility;

icon() {
  if (isTrue == true) {
    passIcon = Icons.visibility;
  } else {
    passIcon = Icons.visibility_off;
  }
}

var formKey = GlobalKey<FormState>();
TextEditingController emailCont = TextEditingController();
TextEditingController passCont = TextEditingController();
TextEditingController nameCont = TextEditingController();
TextEditingController phoneCont = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          Get.off(const HomeScreen()) ;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Register',
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      'Register to store your images here  ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: nameCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.alternate_email,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'enter your name ',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'enter your number ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.email,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        labelText: 'enter your email ',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passCont,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isTrue = !isTrue;
                              icon();
                            });
                          },
                          child: Icon(
                            passIcon,
                            color: Colors.deepPurple,
                          ),
                        ),
                        icon: const Icon(
                          Icons.lock,
                          color: Colors.deepPurple,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: 'enter your password ',
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isTrue,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is! RegisterLoadingState)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 800,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.register(
                                email: emailCont.text,
                                password: passCont.text,
                                phone: phoneCont.text,
                                name: nameCont.text,
                              );
                            }
                          },
                          child: const Icon(Icons.login),
                        ),
                      ),
                    if (state is RegisterLoadingState)
                      const Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple,
                          )),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}