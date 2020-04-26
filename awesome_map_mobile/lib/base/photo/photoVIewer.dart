import 'package:awesome_map_mobile/base/photo/photoItem.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatelessWidget {
  const PhotoViewer({Key key, @required this.galleryItems}) : super(key: key);
  final List<PhotoItem> galleryItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView(
        children: <Widget>[
          for (var i = 0; i < this.galleryItems.length; i++)
            PhotoItemThumbnail(
              photoItem: this.galleryItems[i],
              onTap: () {
                open(context, i);
              },
            )
        ],
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoViewerGalary(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
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
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<PhotoItem> galleryItems;
  final Axis scrollDirection;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
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
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "${widget.galleryItems[currentIndex].name}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    decoration: null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final PhotoItem item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetImage(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
