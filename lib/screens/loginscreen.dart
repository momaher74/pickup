import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pickup/screens/homescreen.dart';
import 'package:pickup/screens/regesterscreen.dart';

import '../bloc/app_cubit.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
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

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Get.off(const HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Login',
              style: TextStyle(fontSize: 24),
            ),
            backgroundColor: Colors.deepPurple,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      'sign in to store your images here ',
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      controller: emailCont,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.alternate_email,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid data';
                        } else {
                          return null;
                        }
                      },
                      controller: passCont,
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
                    if (state is! LoginLoadingState)
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
                              AppCubit.get(context).login(
                                email: emailCont.text,
                                password: passCont.text,
                              );
                            }
                          },
                          child: const Icon(Icons.login),
                        ),
                      ),
                    if (state is LoginLoadingState)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.deepPurple,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Don\'t have account ? ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
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