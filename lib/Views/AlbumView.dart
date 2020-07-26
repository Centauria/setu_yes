import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_album_manager/photo_album_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:setuyes/Views.dart';

class AlbumView extends StatefulWidget {
  AlbumView({
    Key key,
    @required this.albumData,
  }) : super(key: key);

  final List<String> albumData;

  @override
  State<StatefulWidget> createState() => AlbumViewState();
}

class AlbumViewState extends State<AlbumView> {
  List<AlbumModelEntity> _pictures;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _getAlbumData();
  }

  _getAlbumData() async {
    List<AlbumModelEntity> albumData;
    albumData = await PhotoAlbumManager.getDescAlbum(maxCount: 10);
    setState(() {
      _pictures = albumData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pictures == null) {
      return loadingWidget(loadingText: 'Loading pictures...');
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.message),
          title: Text(widget.albumData[index]),
        );
      },
      itemCount: widget.albumData.length,
    );
  }
}
