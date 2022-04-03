import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:albums_view/album.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ScrollController _scrollController = ScrollController();
  late List<Album> albumList = [];
  int pageCounter = 1;
  bool loading = false, allLoaded = false;

  Future<Album> fetchAlbum(int index) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$index'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load album');
    }

    Album album = Album.fromJson(jsonDecode(response.body));

    return album;
  }

  Future<void> fetchElevenAlbums() async {
    if (allLoaded) {
      return;
    }

    setState(() {
      loading = true;
    });

    List<Album> tmpList = [];

    int tmpCounter = pageCounter;

    for (int counter = tmpCounter; counter < tmpCounter + 11 + 1; counter++) {
      Album album = await fetchAlbum(counter);
      tmpList.add(album);
    }

    tmpCounter += 11;

    albumList.addAll(tmpList);

    setState(() {
      pageCounter = tmpCounter;
      loading = false;
      allLoaded = pageCounter >= 100 ? true : false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchElevenAlbums();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading) {
        fetchElevenAlbums();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
            if (albumList.isNotEmpty) {
              return Stack(
                children: <Widget>[
                  ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      String? title = albumList[index].title;
                      return Container(
                        padding: const EdgeInsets.all(4),
                        child: TextButton(
                          child: Text(
                            title,
                          ),
                          onPressed: () {
                            final snackBar = SnackBar(
                                content: Text(
                                    "Álbum $index clicado."
                                ),
                                action: SnackBarAction(
                                  label: 'Close',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                )
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 10, color: Colors.orange);
                  },
                    itemCount: albumList.length,
                  ),
                  if (loading)... {
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          width: constraints.maxWidth,
                          height: 80,
                          child: const Center(
                              child: CircularProgressIndicator()
                          ),
                        )
                    )
                  }
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator()
              );
            }
        })
      ),
    );
  }
}