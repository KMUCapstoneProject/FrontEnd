import 'package:google_maps_flutter/google_maps_flutter.dart';

class Work{

  List<LatLng> work_load(String data)
  {
    List<LatLng> load_data = [];
    List<String> latlng = [];

    latlng = data.split("/");
    for(int i =0;i<latlng.length;i++)
      {
        List<String> box = latlng[i].split(",");
        double latitude = double.parse(box[0]);
        double longitude = double.parse(box[1]);
        print(latlng[i]);
        load_data.add(LatLng(latitude, longitude));
      }
    return load_data;
  }
}