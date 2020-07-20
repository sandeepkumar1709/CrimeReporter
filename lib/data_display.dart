import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:one/Describe_scenario.dart';
import 'package:one/utils.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Ultimatestep extends StatelessWidget{
  Map mapData;
  final Widget container;
  final String title;
  final String route;
  Ultimatestep({this.container,this.mapData,this.title,this.route});
  String url;
  
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> inputData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.email.toString();
    print(uid);
  return uid;
  }
  
  @override
  Widget build(BuildContext context) {
    // var now = DateTime.now();
    // print(mapData['date']);
    // print("lasttttt");
    // print(mapData);
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            container != null ? container : Container(),
            Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 80.0, left: 25.0, right: 25.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    "Incident Summary",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  
                  _bulidRow("What Happend", mapData['incidentType']),
                  _bulidRow("Priority", mapData['priority']),
                  // _bulidRow("Date", mapData['date']),
                  _bulidColum("Injured Body Part", mapData['bodyPart']),
                  // _bulidRow("Description", mapData['Description']),
                  
                  Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 15.0, right: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 100.0,
                        child: ListView(
                          shrinkWrap: true,
                          children:<Widget>[Text(
                            mapData['Description'],
                            style: TextStyle(fontWeight: FontWeight.normal),
                            
                          ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container
                  (
                    child: mapData['image'] == null ?Text('not picked'):Image.file(File(mapData['image']),height: 300,width: 300,),
                  ),
                   Container(

                      padding: EdgeInsets.all(10.0),
                      alignment: Alignment.bottomRight,
                    
                      child: FloatingActionButton(
                        backgroundColor: Colors.black87,
                        child: Icon(Icons.send),
                        onPressed: ()  {
                          var now = DateTime.now();
                          if (mapData['image'] != null)
                          {
                            uploadImage(mapData,now, context);
                          }
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/first', (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                    MyBackButton(),                 
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }


  Widget _bulidRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, top: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }


  Widget _bulidColum(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, top: 16.0, right: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  upload(Map mapData, BuildContext context) {
    // crime = Firestore.instance.collection('crime');
    // 
    // GeoPoint _geoPoint=new GeoPoint(double.parse(mapData['Latitude']), double.parse(mapData['Logitude']));
    // 
    // var doc= Firestore.instance.collection('crime').document('sandeep11');
    // doc.setData({
    //   'Complexity':mapData['priority'],
    //   'Crime-type':mapData['incidentType'],
    //   'Description':"",
    //   'Injuries':mapData['bodyPart'],
    //   'location':_geoPoint,
    //   'date':now,
    //   'Image_uri':mapData['image']
    
    // });
    
    //uploadImage(mapData, context);
      }
    Future uploadImage(Map mapData,var now,BuildContext context) async{
      
      String fileName = basename(mapData['image']);
      final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);

      final StorageUploadTask uploadTask = firebaseStorageRef.child(now.toString()+".jpg").putFile(File(mapData['image']));
      var img_url = await (await uploadTask.onComplete).ref.getDownloadURL();
      print(img_url.toString());  
      url = img_url.toString();
      upload_Database(mapData, context);
       
    }

  void upload_Database(Map mapData, BuildContext context) async{
    // crime = Firestore.instance.collection('crime');
    var dbTime = new DateTime.now();
    // var F_date = new DateFormat('MMM d,yyyy');
    // var F_time = new DateFormat('EEEE,hh:mm aaa');
    // String date = F_date.format(dbTime);
    // String time = F_time.format(dbTime);

    
      
    
    GeoPoint _geoPoint=new GeoPoint(double.parse(mapData['Latitude']), double.parse(mapData['Logitude']));
    String email = await inputData();
    
    
    String docum = email.toString();
    docum = docum+" "+dbTime.toString();
    print(docum);
    var doc= Firestore.instance.collection('crime').document(docum);
    doc.setData({

      'Complexity':mapData['priority'],
      'Crime-type':mapData['incidentType'],
      'Description':mapData['Description'],
      'Injuries':mapData['bodyPart'],
      'location':_geoPoint,
      'date':dbTime,
      'Image_url':url,
      'email':email.toString(),
    });
    
    
  }

}


