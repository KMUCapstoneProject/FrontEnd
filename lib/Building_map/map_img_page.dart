import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class Map_img_page extends StatelessWidget {
  const Map_img_page({super.key});

  @override
  Widget build(BuildContext context) {
    String img_url = Get.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("이미지"),
        ),
        body: File_img(img_url));
  }

  Widget File_img(String img_url) {
    return PhotoView(imageProvider: AssetImage(img_url));
  }
}
