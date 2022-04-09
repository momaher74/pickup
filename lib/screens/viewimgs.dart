import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_cubit.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) => Builder(builder: (context) {
        // cubit.getImg();
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (state is GetImgLoadingState)
                const LinearProgressIndicator(
                  color: Colors.deepPurple,
                  minHeight: 3,
                ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      onLongPress: () {
                        // Get.defaultDialog(
                        //     title: 'Download the photo ?',
                        //     content: SizedBox(
                        //       width: 200,
                        //       height: 50,
                        //       child: ElevatedButton(
                        //         style: ButtonStyle(
                        //           backgroundColor:
                        //               MaterialStateProperty.all(Colors.white),
                        //         ),
                        //         onPressed: () async {
                        //           var imageId =
                        //               await ImageDownloader.downloadImage(
                        //                   cubit.images[index]['link']);
                        //           if (imageId == null) {
                        //             return;
                        //           }
                        //           // Below is a method of obtaining saved image information.
                        //           var fileName =
                        //               await ImageDownloader.findName(imageId);
                        //           var path =
                        //               await ImageDownloader.findPath(imageId);
                        //           var size =
                        //               await ImageDownloader.findByteSize(
                        //                   imageId);
                        //           var mimeType =
                        //               await ImageDownloader.findMimeType(
                        //                   imageId);
                        //           Get.snackbar(
                        //               'done', 'the photo has downloaded');
                        //           Navigator.pop(context);
                        //         },
                        //         child: const Icon(
                        //           Icons.download,
                        //           color: Colors.deepPurple,
                        //         ),
                        //       ),
                        //     ),
                        //     backgroundColor: Colors.deepPurple);
                      },
                      child: Image(
                        image: NetworkImage(
                          cubit.images[index]['link'].toString(),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 5,
                    color: Colors.deepPurple,
                  );
                },
                itemCount: cubit.images.length,
              ),
            ],
          ),
        );
      }),
    );
  }
}
