class ImageData {
  final int _id;
  late final String _path;
  bool _isLiked = false;

  ImageData(
      this._id,
      this._path,
      this._isLiked,
  );

  int get id {
    return _id;
  }

  String get path {
    return _path;
  }

  bool get isLiked {
    return _isLiked;
  }

  set isLiked(bool isLiked) {
    _isLiked = isLiked;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'path': _path,
      'is_liked': _isLiked ? 1 : 0,
    };
  }
}