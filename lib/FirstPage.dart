import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final Color bgcolor = Color(0xFF4A4A58);

class FirstPage extends StatefulWidget {
  final String pageRoute;
  final String buttonTitle;
  const FirstPage({this.pageRoute, this.buttonTitle});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
        body: Stack(children: <Widget>[
      menu(context),
      dashboard(context),
    ]));
  }

  Widget menu(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 150),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 150,
                      width: 150,
                     decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/icon.png'),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
      ),
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child: Icon(Icons.home, color: Colors.black),
                                ),
                                SizedBox(width: 20),
                                FlatButton(
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                  onPressed: () => Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/first',
                                          (Route<dynamic> route) => false),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child:
                                      Icon(Icons.settings, color: Colors.black),
                                ),
                                SizedBox(width: 20),
                                FlatButton(
                                  child: Text(
                                    "Instructions",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                  onPressed: ()  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Howtoreport()),
                                    );
                                    
                                    },
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(height: 260),
                  Container(
                      child: Row(
                    children: <Widget>[
                      InkWell(
                          child: Icon(Icons.exit_to_app, color: Colors.black)),
                      SizedBox(width: 5),
                      FlatButton(
                          child: new Text(
                            'Logout',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false))
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.5 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 5.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              // decoration: 
              // BoxDecoration(
              //   image: DecorationImage(
              //     image: ExactAssetImage('assets/zbcolor.jpg'),
              //     fit: BoxFit.cover,
              //   ),
              //   borderRadius: BorderRadius.circular(40.0),
              // ),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 55),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  InkWell(
                    child: Icon(Icons.menu, color: Colors.black),
                    onTap: () {
                      setState(() {
                        if (isCollapsed)
                          _controller.forward();
                        else
                          _controller.reverse();
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  FlatButton(
                      child: Text("Menubar",
                          style: TextStyle(fontSize: 22, color: Colors.black)),
                      onPressed: () => setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isCollapsed = !isCollapsed;
                          }))
                ]),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(90),
                      // shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(height: 60.0),
                Container(
                  padding: EdgeInsets.only(left: 19.0, right: 16.0),
                  child: Row(
                    children: <Widget>[
                      Material(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/second');
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset('assets/Report.jpeg',
                                    width: 100.0, height: 100.0),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Report case',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      )),
                      SizedBox(width: 90),
                      Material(
                          child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/temp');
                        },
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset('assets/police_contact.jpeg',
                                    width: 100.0, height: 100.0),
                              ),
                              SizedBox(height: 7),
                              Text(
                                "PoliceContacts",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                  ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class Howtoreport extends StatefulWidget {
  @override
  _HowtoreportState createState() => _HowtoreportState();
}

class _HowtoreportState extends State<Howtoreport> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
     body: Stack(children: <Widget>[
      menu(context),
      dashboard(context),
      
    ])
    );
  }
  
  Widget menu(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 150),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/icon.png'),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
      ),
                    ),
                  ),
                  SizedBox(
                    height: 45.0,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child: Icon(Icons.home, color: Colors.black),
                                ),
                                SizedBox(width: 30),
                                FlatButton(
                                  child: Text(
                                    "Home",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                  onPressed: () => Navigator.of(context)
                                      .pushNamedAndRemoveUntil('/first',
                                          (Route<dynamic> route) => false),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                InkWell(
                                  child:
                                      Icon(Icons.settings, color: Colors.black),
                                ),
                                SizedBox(width: 30),
                                FlatButton(
                                  child: Text(
                                    "Instructions",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20.0),
                                  ),
                                  onPressed: () => Howtoreport,
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(height: 260),
                  Container(
                      child: Row(
                    children: <Widget>[
                      InkWell(
                          child: Icon(Icons.exit_to_app, color: Colors.black)),
                      SizedBox(width: 5),
                      FlatButton(
                          child: new Text(
                            'Logout',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false))
                    ],
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

Widget dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.5 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 5.0,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              // decoration: 
              // BoxDecoration(
              //   image: DecorationImage(
              //     image: ExactAssetImage('assets/zbcolor.jpg'),
              //     fit: BoxFit.cover,
              //   ),
              //   borderRadius: BorderRadius.circular(40.0),
              // ),
              padding: const EdgeInsets.only(left: 16, right: 16, top: 55),
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  InkWell(
                    child: Icon(Icons.menu, color: Colors.black),
                    onTap: () {
                      setState(() {
                        if (isCollapsed)
                          _controller.forward();
                        else
                          _controller.reverse();
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                  FlatButton(
                      child: Text("Menubar",
                          style: TextStyle(fontSize: 22, color: Colors.black)),
                      onPressed: () => setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();
                            isCollapsed = !isCollapsed;
                          }))
                ]),
                
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(90),
                      // shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(height: 60.0),
                Container(
                  padding: EdgeInsets.only(left: 19.0, right: 16.0),
                  child: Column(
                    children: <Widget>[
                          Container(
                  margin: EdgeInsets.only(
                    top: 50.0,
                    
                  ),
                  alignment: Alignment.centerLeft,
                  child:
                      Text("Tips:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

}