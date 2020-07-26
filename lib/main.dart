import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:setuyes/Views/RemoteView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Views.dart';
import 'Views/AlbumView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '色图 Yes!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: '色图 Yes!',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    @required this.title,
  }) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final dio = Dio();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  TextEditingController _controller = TextEditingController();
  Map<String, dynamic> _config;

  @override
  void initState() {
    _loadAsset();
    super.initState();
  }

  void _sendMessage() {
    if (_config == null) {
      _loadAsset();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          child: _getView(_selectedIndex),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _sendMessage,
          tooltip: 'Send Message',
          child: Icon(Icons.send),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.lightBlue,
              primaryColor: Colors.tealAccent,
              textTheme: Theme.of(context).textTheme.copyWith(
                    caption: TextStyle(color: Colors.white),
                  )),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.not_interested), title: Text('色图！')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.photo_album), title: Text('相册')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.insert_drive_file), title: Text('文件')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('设置')),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ));
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _getView(int index) {
    switch (_selectedIndex) {
      case 0:
        return RemoteView(
          dio: widget.dio,
          config: _config,
        );
      case 1:
        return AlbumView(
          albumData: ['yes', 'no', 'Good'],
        );
      case 2:
        return fileView;
      case 3:
        return settingsView;
    }
  }

  _loadAsset() {
    loadAsset().then((value) {
      setState(() {
        _config = jsonDecode(value);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}
