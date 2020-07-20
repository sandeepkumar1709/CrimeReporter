import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class data_demo extends StatefulWidget {
  @override
  _data_demoState createState() => _data_demoState();
}

class _data_demoState extends State<data_demo> {
  void _launchCaller(String contact) async {
    var url = "tel:${contact}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not place call';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Police Station Contacts"),


        
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Contacts').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading....');

            return ListView.builder(
              itemExtent: 160.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) => Card(
                child: _buildListItem(context, snapshot.data.documents[index]),
                elevation: 5.0,
              ),
            );
          }),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    String branch = document['Branch'].toString();
    String contact = document['contact'].toString();
    return ListTile(
      title: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Area",
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffdd),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    branch,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Contact",
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffdd),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    contact,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
                InkWell(
                  child: Icon(
                    Icons.call,
                    color: Colors.green[900],
                  ),
                  onTap: () {
                    _launchCaller(contact);
                  },
                )
              ],
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
