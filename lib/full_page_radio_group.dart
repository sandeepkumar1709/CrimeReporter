library custom_radio_button;

import 'package:one/utils.dart';
import 'package:flutter/material.dart';

import 'custom_radio_button.dart';
import 'radio_model.dart';


class FullPageRadioGroup extends StatelessWidget {
  Map mapData;
  final Widget container;
  final String title;
  final String route;
  List<RadioModel> radioList;
  final bool isSquareRadioGroup;
  final String mapKey;

  FullPageRadioGroup(
      {Key key,
      this.mapData,
      this.container,
      this.title,
      this.route,
      this.radioList,
      this.isSquareRadioGroup,
      this.mapKey})
      : super(key: key);

  String _selectedValue;

  @override
  Widget build(BuildContext context) {
    
    if (radioList == null) {
      List<RadioModel> priorityList = new List<RadioModel>();
      priorityList.add(new RadioModel(false, null, 'High', Colors.redAccent));
      priorityList
          .add(new RadioModel(false, null, 'Medium', Colors.orangeAccent));
      priorityList
          .add(new RadioModel(false, null, 'Slight', Colors.greenAccent));
      

      List<RadioModel> incidentTypeList = new List<RadioModel>();
      incidentTypeList.add(new RadioModel(false,null,'kidnapping',Colors.red));
      incidentTypeList.add(new RadioModel(false,null,'child abuse',Colors.deepPurple));
      incidentTypeList.add(new RadioModel(false,null,'Accident',Colors.blueAccent));
      incidentTypeList.add(new RadioModel(false,null,'Chain Snatching',Colors.purpleAccent));
      incidentTypeList.add(new RadioModel(false,null,'Other',Colors.greenAccent));
      if (mapKey == "priority") {
        radioList = priorityList;
      } else if (mapKey == "incidentType") {
        radioList = incidentTypeList;
      }
    }
    return Scaffold(
      body: new Container(
        child: Stack(
          children: <Widget>[
            container != null ? container : Container(),
            TopTitle(
              topMargin: 80.0,
              leftMargin: 50.0,
              title: title,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50.0),
              child: CustomRadioGroupWidget(
                onChanged: getPriority,
                isSquareRadioGroup: isSquareRadioGroup,
                radioList: radioList,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black87,
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  // print('yoooo');
                  // print(_selectedValue);

                  if (_selectedValue != null) {
                    print(mapData);
                    print("obj333333ect");
                    if (mapData == null) {
                      Map newMap = new Map();
                      newMap[mapKey] = _selectedValue;

                      Navigator.pushNamed(context, route, arguments: newMap);
                    } 
                    else {
                      mapData[mapKey] = _selectedValue;

                      Navigator.pushNamed(context, route, arguments: mapData);
                    }
                  } else {
                    Utils().showMyDialog(context, "Please Select a Option");
                  }
                },
              ),
            ),
            MyBackButton(),
          ],
        ),
      ),
    );
  }

  void getPriority(String value) {
    _selectedValue = value;
  }
}