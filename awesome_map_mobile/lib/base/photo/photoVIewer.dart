import 'package:awesome_map_mobile/base/system/transparentPageRoute.dart';
import 'package:awesome_map_mobile/models/files/serverFile.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'FileItemThumbnail.dart';

class PhotoViewer extends StatelessWidget {
  PhotoViewer({Key key, @required this.galleryItems}) : super(key: key);
  final List<ServerFile> galleryItems;
  final List<String> pathFiles = new List<String>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView(
        children: <Widget>[
          for (var i = 0; i < this.galleryItems.length; i++)
            FileItemThumbnail(
              file: this.galleryItems[i],
              onTap: (path) {
                open(context, i, path);
              },
            )
        ],
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  void open(BuildContext context, final int index, String mainPath) {
    Navigator.push(
      context,
      TransparentPageRoute(
        builder: (context) => PhotoViewerGalary(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          mainPath: mainPath,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class PhotoViewerGalary extends StatefulWidget {
  PhotoViewerGalary({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
    this.mainPath,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<ServerFile> galleryItems;
  final Axis scrollDirection;
  final String mainPath;
  @override
  State<StatefulWidget> createState() {
    return _PhotoViewerGalaryState();
  }
}

class _PhotoViewerGalaryState extends State<PhotoViewerGalary> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // onVerticalDragUpdate: (drapUpdateDetails) {
  //   if (drapUpdateDetails.delta.distanceSquared > MediaQuery.of(context).size.height /4)
  //     Navigator.of(context).pop();
  // },
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('key'),
      direction: DismissDirection.vertical,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: _buildItem,
            itemCount: widget.galleryItems.length,
            loadingBuilder: widget.loadingBuilder,
            backgroundDecoration: widget.backgroundDecoration,
            pageController: widget.pageController,
            onPageChanged: onPageChanged,
            scrollDirection: widget.scrollDirection,
          ),
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final ServerFile item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider:
          AssetImage(this.widget.mainPath + '/' + item.id + '/' + item.name),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
