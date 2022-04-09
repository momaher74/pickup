import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/app_cubit.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is UploadSuccessState){
          Get.defaultDialog(title: 'Done' ,content: const Text('your photo is uploaded' ,style: TextStyle(color: Colors.white), ), backgroundColor: Colors.deepPurple ,);
          cubit.cancelImage();
        }
      },
      builder: (context, state) => Center(
        child: Column(
          children: [
            const SizedBox(height: 30,) ,
            if(state is UploadLoadingState)
            const LinearProgressIndicator(color: Colors.deepPurple,),
            const SizedBox(
              height: 200,
            ),
            if (cubit.prodImage == null)
              const Text(
                'upload your photo ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            if (cubit.prodImage == null)
              const SizedBox(
                height: 30,
              ),
            if (cubit.prodImage == null)
              GestureDetector(
                onTap: () {
                  cubit.pickProductImage();
                },
                child: Container(
                    width: 100,
                    height: 120,
                    decoration: const BoxDecoration(
                        color: Colors.deepPurple, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.upload_rounded,
                      size: 60,
                      color: Colors.white,
                    )),
              ),
            if (cubit.prodImage != null)
              Column(
              children: [
                 Image(
                  width: 300,
                  height: 230,
                  image:  FileImage(cubit.prodImage!),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple),
                      ),
                      onPressed: () {
                        cubit.uploadImg();

                      },
                      child: const Text('upload'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
