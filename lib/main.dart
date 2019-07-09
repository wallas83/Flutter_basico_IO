import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main()  async{

  var data = await readData();
  if(data != null){
    String message = await readData();
    print(message);
  }
  new MaterialApp(
    title: "IO",
    home: new Home(),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataFiled = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Read/write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
        body: new Container(
      padding: const EdgeInsets.all(13.4),
          alignment: Alignment.topCenter,
          child: new ListTile(
            title: new TextField(
              controller: _enterDataFiled,
              decoration: new InputDecoration(
                labelText: 'write something'
              ),
            ),
            subtitle: new FlatButton(
              onPressed: (){
                writeData(_enterDataFiled.text);

              },
              child: new  Column(
                children: <Widget>[
                  new Text('save Data'),
                  new Padding(padding: new EdgeInsets.all(14.5)),
                  new Text('Saved data goes here')
                ],
              ),
            ),
          ),
        ),
    );

  }

}





  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path; // home/directory/
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return new File('$path/data.txt');
  }

  //write and read from our file

  Future<File> writeData(String message) async {
    final file = await _localFile;
    //write to file

    return file.writeAsString('$message');
  }
  Future<String> readData() async {

    try{
      final file = await _localFile;

      //Read
        String data = await file.readAsString();
        return data;
    }catch(e){
      return "Nothing save yet!";
    }
  }

