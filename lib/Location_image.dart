import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:one/Img_pick.dart';
import 'package:one/utils.dart';


class FullPageLocationAndImagePicker extends StatefulWidget {
  Map mapData;
  final Widget container;
  final String title;
  final String route;
 
  final String mapkey;
  FullPageLocationAndImagePicker(
    {Key key,
      this.mapData,
      this.container,
      this.title,
      this.route,
      this.mapkey})
      : super(key: key);
  @override
  _FullPageLocationAndImagePickerState createState() => _FullPageLocationAndImagePickerState(
      container,
      mapData,
      title,
      route,
      mapkey,
  );
}

class _FullPageLocationAndImagePickerState extends State<FullPageLocationAndImagePicker> {
  Map mapData;
  final Widget container;
  final String title;
  final String route;
  final String mapkey;
  _FullPageLocationAndImagePickerState(
      this.container,
      this.mapData,
      this.title,
      this.route,
      this.mapkey);
  Position _p;
  sampleFunction() async {
    print("yo");
    _p = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    mapData["Latitude"] = _p.latitude.toString();
    mapData["Logitude"] = _p.longitude.toString();
    print(mapData);
    setState(() {
      
    });
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
            body: Container(
                  child: Stack(
                  
                  children:<Widget>[
                    container != null ? container : Container(),
                    TopTitle(
                      topMargin: 80.0,
                      leftMargin: 50.0,
                      title: title,
                    ),
                    SizedBox(
                      
                      height: 150.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 50.0),
                      child: TakeImage(mapData:mapData),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor: Colors.black87,
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          sampleFunction();
                          
                            Navigator.pushNamed(context, route,arguments: mapData);

                          
                        },
                      ),
                    ),
                    BackButton(),
                  ],
                  )
                )
              );
  }
}


