import 'package:flutter/material.dart';

class PhotoItem {
  PhotoItem({this.id, this.name, this.resource});

  final String id;
  final String name;
  final String resource;
}

class PhotoItemThumbnail extends StatelessWidget {
  const PhotoItemThumbnail(
      {Key key, this.photoItem, this.onTap})
      : super(key: key);

  final PhotoItem photoItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: photoItem.id,
          child: Image.asset(photoItem.resource, height: 80.0),
        ),
      ),
    );
  }
}