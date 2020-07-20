import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map mapData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // String _username,_phone;
  final _username = new TextEditingController();
  final _phone = new TextEditingController();
  final _email = new TextEditingController();
  final _password = new TextEditingController();
  bool isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 900);
  double screenWidth, screenHeight;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return new Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.purple[50], Colors.purple[300]]),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              // margin: EdgeInsets.only(left: 30.0,bottom: 200.0,right: 30.0,),
              padding: EdgeInsets.fromLTRB(25.0, 35.0, 25.0, 25.0),
              width: 325.0,
              height: 350.0,
              decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0, // has the effect of softening the shadow
                      spreadRadius:
                          3.0, // has the effect of extending the shadow
                      offset: Offset(
                        7.5, // horizontal, move right 10
                        7.5, // vertical, move down 10
                      ),
                    )
                  ],
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(50.0)),
                  color: Colors.white),

              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new TextField(
                      controller: _email,
                      decoration: new InputDecoration(
                        labelText: "Email",
                        contentPadding:
                            EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 25.0),
                        prefixIcon: Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 12.0),
                          child: Icon(
                            Icons.email,
                          ), // myIcon is a 48px-wide widget.
                        ),
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    new TextField(
                      controller: _password,
                      decoration: new InputDecoration(
                          labelText: "Password",
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 25.0),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 12.0),
                            child: Icon(
                              Icons.lock,
                            ), // myIcon is a 48px-wide widget.
                          ),
                          // fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          fillColor: Colors.green),
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xff01A0C7),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: validateandSubmit,
                        child: Text("Login",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    new FlatButton(
                      child: new Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        setState(() {
                          isCollapsed = !isCollapsed;
                        });
                      },
                    )
                  ]),
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            top: 0,
            bottom: 0,
            left: 0,
            right: isCollapsed ? 0 : -2.0 * screenWidth,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.only(left: 30.0,bottom: 200.0,right: 30.0,),
                padding: EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 25.0),
                width: 325.0,
                height: 500.0,
                decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius:
                            5.0, // has the effect of softening the shadow
                        spreadRadius:
                            3.0, // has the effect of extending the shadow
                        offset: Offset(
                          7.5, // horizontal, move right 10
                          7.5, // vertical, move down 10
                        ),
                      )
                    ],
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(50.0)),
                    color: Colors.white),

                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new TextField(
                        controller: _username,
                        decoration: new InputDecoration(
                          labelText: "Username",
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 25.0),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 12.0),
                            child: Icon(
                              Icons.perm_identity,
                            ), // myIcon is a 48px-wide widget.
                          ),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      new TextField(
                        controller: _phone,
                        decoration: new InputDecoration(
                          labelText: "PhoneNumber",
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 25.0),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 12.0),
                            child: Icon(
                              Icons.phone,
                            ), // myIcon is a 48px-wide widget.
                          ),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      new TextField(
                        controller: _email,
                        decoration: new InputDecoration(
                          labelText: "Email",
                          contentPadding:
                              EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 25.0),
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 12.0),
                            child: Icon(
                              Icons.email,
                            ), // myIcon is a 48px-wide widget.
                          ),
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      new TextField(
                        controller: _password,
                        decoration: new InputDecoration(
                            labelText: "Password",
                            contentPadding:
                                EdgeInsets.fromLTRB(25.0, 15.0, 20.0, 25.0),
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 12.0),
                              child: Icon(
                                Icons.lock,
                              ), // myIcon is a 48px-wide widget.
                            ),
                            // fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                            fillColor: Colors.green),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff01A0C7),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: Signup,
                          child: Text("Signup",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      new FlatButton(
                        child: new Text(
                          'Login',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        onPressed: () {
                          setState(() {
                            isCollapsed = !isCollapsed;
                          });
                        },
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> validateandSubmit() async {
    try {
      String temp = _email.text.toString();
      print("hi");
      print(_email.text);

      FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: temp, password: _password.text.toString()))
          .user;
      final snackBar = SnackBar(
        content: Text(
          'welcome ${user.email}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Navigator.pushNamed(context, '/first', arguments: mapData);

      print('Signed in: ${user.uid}');
    } catch (e) {
      print("exception:" + e.message);
      final snackBar = SnackBar(
        content: Text(
          e.message,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red[600],
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Future<void> Signup() async {
    String mobile,u_name;
    mobile = _phone.text.toString();
    u_name = _username.text.toString();
    if (mobile.isNotEmpty && u_name.isNotEmpty){

    try {
      String temp = _email.text.toString();
      FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: temp, password: _password.text.toString()))
          .user;
      print('registered successfully');
      setState(() {
        isCollapsed = !isCollapsed;
      });
      var doc= Firestore.instance.collection('userdetails').document(temp);
    doc.setData({

      'username':_username.text.toString(),
      'mobile':_phone.text.toString()
      
    });
     
      final snackBar = SnackBar(
        content: Text(
          'Registered successfully, login!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlueAccent[300],
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } catch (e) {
      String s = e.message;
      print("exception:" + s);
      final snackBar = SnackBar(
        content: Text(
          e.message,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red[600],
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
    }
    else{
      final snackBar = SnackBar(
        content: Text(
          "Mobile and username is required",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red[600],
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);

    }
  }
}
