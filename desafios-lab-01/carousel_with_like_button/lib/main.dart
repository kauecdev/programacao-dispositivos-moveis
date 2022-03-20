import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'image_info.dart';

main() {
  return runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.deepOrange,
          appBar: AppBar(
            title: const Text("Carouseel"),
            backgroundColor: Colors.deepOrange,
          ),
          body: const MyCarouselPage(),
        ),
      )
  );
}

class MyCarouselPage extends StatefulWidget {
  const MyCarouselPage({Key? key}) : super(key: key);

  @override
  State<MyCarouselPage> createState() => _MyCarouselPage();
}

class _MyCarouselPage extends State<MyCarouselPage> {

  List<ImageData> images = [
    ImageData(1, "images/image_1.jpg", false),
    ImageData(2, "images/image_2.jpg", false),
    ImageData(3, "images/image_3.jpg", false),
    ImageData(4, "images/image_4.jpg", false),
    ImageData(5, "images/image_5.jpg", false),
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
      if (_currentImageIndex < images.length - 1) {
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

  final ImageData imageInfo;

  const ImageCard({Key? key, required this.imageInfo}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCard();
}

class _ImageCard extends State<ImageCard> {

  bool _isLiked = false;
  int _imageId = 0;

  @override
  initState() {
    getIsLiked();
    super.initState();
  }

  @override
  didUpdateWidget(ImageCard oldImageCard) {
    super.didUpdateWidget(oldImageCard);

    if (oldImageCard.imageInfo.id != widget.imageInfo.id) {
      setState(() {
        getIsLiked();
      });
    }
  }

  getIsLiked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _imageId = widget.imageInfo.id;
      _isLiked = prefs.getBool("image-$_imageId") ?? false;
    });
  }

  onLikeButtonHandler() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("image-$_imageId", !_isLiked);

    setState(() {
      _isLiked = (prefs.getBool("image-$_imageId") ?? false);
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
                    _isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
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