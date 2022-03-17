import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.deepOrange,
          appBar: AppBar(
            title: const Text("Carouseel"),
            backgroundColor: Colors.deepOrange,
          ),
          body: MyCarouselPage(),
        ),
      )
  );
}

class ImageInfo {
  late final String _path;
  bool _isLiked = false;

  ImageInfo(
    this._path,
    this._isLiked,
  );

  String get path {
    return _path;
  }

  bool get isLiked {
    return _isLiked;
  }

  set isLiked(bool isLiked) {
    _isLiked = isLiked;
  }
}

class MyCarouselPage extends StatefulWidget {
  @override
  State<MyCarouselPage> createState() => _MyCarouselPage();
}

class _MyCarouselPage extends State<MyCarouselPage> {

  List<ImageInfo> images = [
    ImageInfo("images/image_1.jpg", false),
    ImageInfo("images/image_2.jpg", false),
    ImageInfo("images/image_3.jpg", false),
    ImageInfo("images/image_4.jpg", false),
    ImageInfo("images/image_5.jpg", false),
  ];

  int _currentImageIndex = 0;

  _previousImage() {
    setState(() {
      if (_currentImageIndex != 0) {
        _currentImageIndex--;
      }
    });
  }

  _nextImage() {
    setState(() {
      if (_currentImageIndex < 4) {
        _currentImageIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildTextButton("Anterior", _previousImage),
                  buildTextButton("Próxima", _nextImage),
                ]
            ),
          ),
          ImageCard(imageInfo: images[_currentImageIndex],),
        ]
      )
    );
  }

  Container buildTextButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(10),
      ),
     child: TextButton(
       onPressed: onPressed,
       child: Text(
         text,
         style: const TextStyle(
             fontSize: 20,
             color: Colors.white
         ),
       ),
     ),
    );
  }
}

class ImageCard extends StatefulWidget {

  final ImageInfo imageInfo;

  const ImageCard({Key? key, required this.imageInfo}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCard();
}

class _ImageCard extends State<ImageCard> {

  onLikeButtonHandler() {
    setState(() {
      widget.imageInfo.isLiked ^= true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(widget.imageInfo.path),
        Positioned(
          left: 10,
          bottom: 10,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60
              ),
                child: TextButton(
                  onPressed: onLikeButtonHandler,
                  child: Icon(
                    widget.imageInfo._isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    size: 40,
                    color: Colors.red,
                  ),
                ),
              ),
          )
        )
      ],
    );
  }
}