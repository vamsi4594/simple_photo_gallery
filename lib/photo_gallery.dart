import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoGallery extends StatefulWidget {
  @override
  _PhotoGalleryState createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGallery> {

  List<String> imagesList = ['images/minion1.jpeg','images/minion2.jpeg','images/minion3.jpeg','images/minion4.jpeg','images/minion5.jpeg','images/minion6.jpeg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          child: Ink.image(
            image: AssetImage(imagesList[2]),
            height: 300,
            fit: BoxFit.cover,
          ),
          onTap: openGallery,
        ),
      ),
    );
  }
  void openGallery() => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GalleryWidget(
    displayImages: imagesList, index: 2,
  )));
}

class GalleryWidget extends StatefulWidget {
  final PageController pageController;
  final List<String> displayImages;
  final int index;

  GalleryWidget({this.displayImages, this.index = 0}) : pageController = PageController(initialPage: index);
  @override
  _GalleryWidgetState createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
   int index ;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PhotoViewGallery.builder(
              // scrollDirection: Axis.vertical, //for vertical scroll of images
              pageController: widget.pageController,
              itemCount: widget.displayImages.length,
              builder: (context, index){
                final imgString = widget.displayImages[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(imgString),
                  //for zooming
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                );
              },
              onPageChanged: (_index) {
                setState(() {
                  index = _index;
                });
              },
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Image: ${index+1} / ${widget.displayImages.length}',
              style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }
}

