import 'package:one/Describe_scenario.dart';
import 'package:one/LoginPage.dart';
import 'package:one/data_demo.dart';
import 'package:one/data_display.dart';
import 'package:one/full_page_human_anatomy.dart';
import 'package:one/full_page_radio_group.dart';
import 'package:one/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:one/Location_image.dart';
import 'package:one/FirstPage.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomePage(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return PageTransition(child: HomePage(),type: PageTransitionType.leftToRight);
            break;
          case '/first':
            return PageTransition(child: v_page1(),type: PageTransitionType.leftToRight);
            break;
          case '/temp':
            return PageTransition(child:temp(),type: PageTransitionType.leftToRight);
            break;

          case '/second':
            return PageTransition(child: PageOne(),type: PageTransitionType.leftToRight);
            break;
          case '/third':
            return PageTransition(
                child: PageTwo(
                  mapData: settings.arguments,
                ),type: PageTransitionType.leftToRight);
            break;
          case '/fourth':
            // print('body testing');
            return PageTransition(
                child: PageThree(
                  mapData: settings.arguments,
                ),type: PageTransitionType.leftToRight);
            break;
          case '/fifth':
            return PageTransition(
                child: PageFour(
                  mapData: settings.arguments,
                ),type: PageTransitionType.leftToRight);
            break;
          case '/sixth':
            print('body testing');
            return PageTransition(
                child: PageFive(
                  mapData: settings.arguments,
                ),type: PageTransitionType.leftToRight);
            break;
          case '/seventh':
            return PageTransition(
              child: PageSix(
                mapData: settings.arguments,
            ), type: PageTransitionType.leftToRight);
            }
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class v_page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FirstPage(
      pageRoute: "/second",
      buttonTitle: "Swipe to report incident",
    );
  }
}

class temp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return data_demo();
  }

}


class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FullPageRadioGroup(
      container: TopPrograssBar(
        progressBarImagePath: "assets/step_1.png",
      ),
      isSquareRadioGroup: true,
      title: "Severty?",
      route: "/third",
      mapKey: 'priority',
    );
  }
}
class PageTwo extends StatelessWidget {
  final Map mapData;
  const PageTwo({Key key, this.mapData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return new FullPageRadioGroup(
        container: TopPrograssBar(
          progressBarImagePath: "assets/step_2.png",
        ),
        isSquareRadioGroup: false,
        title: "What happended?",
        route: "/fourth",
        mapData: mapData,
        mapKey: 'incidentType');
  }
}



class PageThree extends StatelessWidget {
  final Map mapData;
  const PageThree({Key key, this.mapData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FullPageHumanAnatomy(
      container: TopPrograssBar(
        progressBarImagePath: "assets/step_3.png",
      ),
      mapData: mapData,
      title: "Where it is?",
      route: "/fifth",
    );
  }
}
class PageFour extends StatelessWidget {
  final Map mapData;
  const PageFour({Key key, this.mapData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Description(
      mapData: mapData,
      container: TopPrograssBar(
        progressBarImagePath: "assets/step_4.png",
      ),
      route: "/sixth",
    );
  }
}


class PageFive extends StatelessWidget {
  final Map mapData;
  const PageFive({Key key, this.mapData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FullPageLocationAndImagePicker(
      container: TopPrograssBar(
        progressBarImagePath: "assets/step_5.png",
      ),
      mapData: mapData,
      title: "Where it happened?",
      route: "/seventh",
      mapkey:"loc_img",
    );
  }
}
 class PageSix extends StatelessWidget{
   final Map mapData;
   const PageSix({Key key,this.mapData}):super(key : key);

  @override
  Widget build(BuildContext context) {
    return Ultimatestep
    (
      container:TopPrograssBar(
        progressBarImagePath:"assets/step_6.png",
      ),
      mapData:mapData,
      title:"Report",
      route:"upload"
    );
  }
 }