import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Img_page extends StatelessWidget {
  const Img_page({super.key});

  @override
  Widget build(BuildContext context) {
    bool _newkork = false;
    List<dynamic> img_url = [];
    img_url = Get.arguments;

    if(img_url.isEmpty)
      {
        _newkork = true;
      }
    else if(img_url[0].toString().contains("http"))
      {
        _newkork = true;
      }
    else
      {
        _newkork = false;
      }


    return Scaffold(
      appBar: AppBar(
        title: Text("이미지"),
      ),
      body: _newkork ? network_img(img_url) : File_img(img_url)
    );
  }

  Widget File_img(List<dynamic> img_url)
  {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for(int i = 0 ; i< img_url.length;i++)
              Image.asset(img_url[i]),
          ],
        ),
      ),
    );
  }

  Widget network_img(List<dynamic> img_url)
  {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for(int i = 0 ;i< img_url.length;i++)
              Image.network(img_url[i]),
          ],
        ),
      ),
    );
  }
}
