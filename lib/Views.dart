import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

final setuView = Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[Text('Setu!')],
);

final albumView = ListView(
  children: <Widget>[
    ListTile(
      leading: Icon(Icons.insert_drive_file),
      title: Text('Album'),
    ),
    ListTile(
      leading: Icon(Icons.folder),
      title: Text('Example'),
    )
  ],
);

final fileView = Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[Text('file!')],
);

final settingsView = Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: <Widget>[Text('Settings!')],
);

loadingWidget({String loadingText}) => loadingText != null
    ? Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
            child: Center(
              child: CupertinoActivityIndicator(
                radius: 20.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
            child: Center(
              child: Text(loadingText),
            ),
          ),
        ],
      )
    : Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 35.0),
        child: Center(
          child: CupertinoActivityIndicator(
            radius: 20.0,
          ),
        ),
      );

loadingImageWidget(String url) => Center(
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/loading.jpg',
        image: url,
      ),
    );
