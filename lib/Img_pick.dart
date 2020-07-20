
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class TakeImage extends StatefulWidget {
  Map mapData;
  @override
  TakeImage({this.mapData});
  _TakeImageState createState() => _TakeImageState(mapData);
}

class _TakeImageState extends State<TakeImage> {
  Future<File> _imageFile;
  Map mapData;
  _TakeImageState(this.mapData);
  // Future getImage(bool isCamera)async{
  //   File image;
  //   if (isCamera)
  //   {
  //     image = await ImagePicker.pickImage(source: ImageSource.camera);
  //   }
  //   else
  //   {
  //     image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   }
  //   setState(() {
  //       // s['image'] = image;
  //       print(image);
  //       print("hiiiiii");
  //     _image = image;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    Widget _buildPicText() => new Container(
      padding: EdgeInsets.only(left: 50.0, bottom: 30.0, top: 50.0),
      child: Text(
        "Picture of the incident (optional)",
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[ _buildPicText(), _imageContainer()],
    );
  
}
Widget _imageContainer() {
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0, // has the effect of softening the shadow
                  spreadRadius: 3.0, // has the effect of extending the shadow
                  offset: Offset(
                    5.0, // horizontal, move right 10
                    5.0, // vertical, move down 10
                  ),
                )
              ],
              color: Colors.white,
              border: new Border.all(width: 1.0, color: Colors.white),
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            width: 200.0,
            height: 150.0,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(const Radius.circular(20.0)),
              child: _previewImage(),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery);
                  },
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.camera);
                    },
                    heroTag: 'image1',
                    tooltip: 'Take a Photo',
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
 Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
           mapData['image'] = snapshot.data.path;
            return Image.file(
              snapshot.data,
              fit: BoxFit.cover,
            );
          } else if (snapshot.error != null) {
            return Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: const Text(
                'Error picking image.',
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: const Text(
                'You have not yet picked an image.',
                textAlign: TextAlign.center,
              ),
            );
          }
        });
  }

  void _onImageButtonPressed(ImageSource source) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: source);
    });
  }

  
}

