import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one/utils.dart';
import 'dart:async';
import 'dart:math';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Description extends StatefulWidget {
  
  final Map mapData;
  final Widget container;
  
  final String route;

  Description(
      { this.mapData, this.container, this.route});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";
  String _currentLocaleId = "en_US";
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  var controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    initSpeechState();
    
  }
  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener);
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // print(widget.mapData);
    
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            widget.container != null ? widget.container : Container(),
            TopTitle(
              topMargin: 80.0,
              leftMargin: 50.0,
              title: "Explain in detail",
            ),
            SizedBox(height: 50.0,),
            Container(
              
              margin: EdgeInsets.only(top: 115.0,left: 15.0,right: 15.0),
              child: new TextField(
                
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                toolbarOptions: ToolbarOptions(
                  cut: true,
                  copy: true,
                  selectAll: true,
                  paste: true,
                ),
                maxLines: 20,
              ),
              

            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(left:140),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Icon(Icons.mic, color: Colors.blue[700],size: 45,),
                    onTap:  !_hasSpeech || speech.isListening
                          ? null
                          : startListening,
                  ),
                  SizedBox(width:15),
                  InkWell(
                    child: Icon(Icons.cancel, color: Colors.blue[700],size: 45,),
                    onTap:  speech.isListening ? stopListening : null,

                  )

              ],)
              

            ),
            Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            // color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.only(top:505),
            child: Center(
              child: speech.isListening
                  ? Text(
                      "I'm listening...",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Not listening',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.black87,
                child: Icon(Icons.arrow_forward),
                onPressed: () {
                  
                  // print(controller.text);
                  widget.mapData['Description'] = controller.text;
                  print(widget.mapData['Description']);
                  Navigator.pushNamed(context, widget.route, arguments: widget.mapData);
                },
              ),
            ),
            
            MyBackButton(),
          ],
        ),
      ),
    );
  }
    void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 90),
        localeId: "en_US",
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        partialResults: true);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} - ${result.finalResult}";
      // print(lastWords);
      controller.text = lastWords;
      // print(controller.text);
      
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    //print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    print("Received error status: $error, listening: ${speech.isListening}");
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    print(
        "Received listener status: $status, listening: ${speech.isListening}");
    setState(() {
      lastStatus = "$status";
    });
  }

  _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }
}