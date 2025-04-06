import 'package:camera/camera.dart';

class PreviewStoryRequestModel {
  final XFile? imagePicked;
  final bool isCover;

  const PreviewStoryRequestModel({this.imagePicked, this.isCover = false});

  PreviewStoryRequestModel copyWith({XFile? imagePicked, bool? isCover}) {
    return PreviewStoryRequestModel(
      imagePicked: imagePicked ?? this.imagePicked,
      isCover: isCover ?? this.isCover,
    );
  }
}
