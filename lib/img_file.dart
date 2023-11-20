
class img_file{
  Map<String,List<String>> _data = {};

  //공대 1호관
  List<String> img_engineering_1  = [
    "images/kmu/공대/공대1호관/공학1호관 지하.png",
    "images/kmu/공대/공대1호관/공학1호관 1층.png",
    "images/kmu/공대/공대1호관/공학1호관 2층.png",
    "images/kmu/공대/공대1호관/공학1호관 3층.png",
    "images/kmu/공대/공대1호관/공학1호관 4층.png",
  ];
  //공대 2호관
  List<String> img_engineering_2  = [
    "images/kmu/공대/공대2호관/공학2호관 지하.png",
    "images/kmu/공대/공대2호관/공학2호관 1층.png",
    "images/kmu/공대/공대2호관/공학2호관 2층.png",
    "images/kmu/공대/공대2호관/공학2호관 3층.png",
    "images/kmu/공대/공대2호관/공학2호관 4층.png",
    "images/kmu/공대/공대2호관/공학2호관 5층.png",
  ];
  //공대 3호관
  List<String> img_engineering_3  = [
    "images/kmu/공대/공대3호관/공학3호관 지하.png",
    "images/kmu/공대/공대3호관/공학3호관 1층.png",
    "images/kmu/공대/공대3호관/공학3호관 2층.png",
    "images/kmu/공대/공대3호관/공학3호관 3층.png",
    "images/kmu/공대/공대3호관/공학3호관 4층.png",
    "images/kmu/공대/공대3호관/공학3호관 5층.png",
  ];
  //공대 4호관
  List<String> img_engineering_4  = [
    "images/kmu/공대/공대4호관/공학4호관 지하.png",
    "images/kmu/공대/공대4호관/공학4호관 1층.png",
    "images/kmu/공대/공대4호관/공학4호관 2층.png",
    "images/kmu/공대/공대4호관/공학4호관 3층.png",
    "images/kmu/공대/공대4호관/공학4호관 4층.png",
    "images/kmu/공대/공대4호관/공학4호관 5층.png",
  ];

  img_file()
  {
    _data.addAll({"공대1호관":img_engineering_1});
    _data.addAll({"공대2호관":img_engineering_2});
    _data.addAll({"공대3호관":img_engineering_3});
    _data.addAll({"공대4호관":img_engineering_4});
  }

  //사진 이미지 다들고오기
  Map<String,List<String>> get_img_building()=> _data;
}