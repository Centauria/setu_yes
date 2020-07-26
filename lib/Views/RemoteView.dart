import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:setuyes/Network/url.dart';
import 'package:setuyes/Views.dart';

class RemoteView extends StatefulWidget {
  RemoteView({
    Key key,
    @required this.dio,
    @required this.config,
  }) : super(key: key);

  final Dio dio;
  final Map<String, dynamic> config;

  @override
  State<StatefulWidget> createState() => RemoteViewState();
}

class RemoteViewState extends State<RemoteView> {
  Map<String, dynamic> _serverInfo;
  DataManager _dataManager;
  List<String> _imageList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.config != null) {
      _dataManager = DataManager(widget.dio, widget.config['server']);
      _getServerInfo();
      _getImageList();
    }
  }

  _getServerInfo() {
    _dataManager.getServerInfo().then((result) {
      setState(() {
        _serverInfo = result;
      });
    });
  }

  _getImageList() {
    _dataManager
        .getId(
      start: _imageList == null ? 0 : _imageList.length,
      ascending: true,
    )
        .then((value) {
      setState(() {
        if (_imageList == null) {
          _imageList = [];
        }
        _imageList.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (widget.config == null) {
      return loadingWidget(loadingText: 'Loading config...');
    } else if (_imageList == null) {
      return loadingWidget(loadingText: 'Loading image list...');
    } else if (_imageList.length == 0) {
      return loadingWidget(loadingText: 'Image list empty');
    } else {
      return Container(
        color: Colors.transparent,
        child: GridView.extent(
          maxCrossAxisExtent: 150.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: List<Container>.generate(
              _imageList.length,
              (index) => Container(
                    child: GestureDetector(
                      child: _dataManager.getImageById(_imageList[index]),
                      onTap: () {
                        log('Tapped #$index');
                      },
                      onLongPress: () {
                        log('Long press #$index');
                      },
                    ),
                  )),
        ),
      );
    }
  }
}
