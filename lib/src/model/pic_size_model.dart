class PictureSizeModel {
  final Thumbnail? thumbnail;
  final Thumbnail? large;
  final Thumbnail? medium;
  final String? fileUrl;

  PictureSizeModel({this.thumbnail, this.large, this.medium, this.fileUrl});

  factory PictureSizeModel.fromJson(Map<String, dynamic> json) {
    final imageSize = json['imageSize'];
    return PictureSizeModel(
        fileUrl: json['fileUrl'],
        thumbnail: imageSize['thumbnail'] != null
            ? new Thumbnail.fromJson(imageSize['thumbnail'])
            : null,
        large: imageSize['large'] != null
            ? new Thumbnail.fromJson(imageSize['large'])
            : null,
        medium: imageSize['medium'] != null
            ? new Thumbnail.fromJson(imageSize['medium'])
            : null);
  }
}

class Thumbnail {
  final num? width;
  final num? height;
  final String? url;

  Thumbnail({this.url, this.height, this.width});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
