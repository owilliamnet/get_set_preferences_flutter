import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(PreferencesApp());

class PreferencesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Preferences in App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _preferences1 = TextEditingController();
  String _savedData  = "";

  @override
  void initState() {
    super.initState();

    _loadSaveData();
  }

  _loadSaveData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('data').isEmpty) {
        _savedData = "";

      } else {
        _savedData = preferences.getString("data");

      }
    });
  }

  _savePreference1(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data',message);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Preferences'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Preference one saved',style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text(_savedData,style: TextStyle(fontSize: 24.0),),
            ),
            ListTile(
              title: TextField(
                controller: _preferences1,
                decoration: InputDecoration(labelText: 'Preference one'),
              ),
            ),
            ListTile(
                title: FlatButton(
              color: Colors.blue[300],
              child: Text(
                'Save preference',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _savePreference1(_preferences1.text);
              },
            ))
          ],
        ),
      ),
    );
  }
}
