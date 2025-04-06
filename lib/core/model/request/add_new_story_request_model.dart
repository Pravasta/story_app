import 'dart:io';

class AddNewStoryRequestModel {
  final String? description;
  final File? photo;
  final double? latitude;
  final double? longitude;

  const AddNewStoryRequestModel({
    this.description,
    this.photo,
    this.latitude,
    this.longitude,
  });

  Map<String, File> toMap() {
    return {'photo': photo!};
  }

  Map<String, String> toMapString() {
    return {
      'description': description ?? '',
      // 'latitude': latitude?.toString() ?? '',
      // 'longitude': longitude?.toString() ?? '',
    };
  }

  AddNewStoryRequestModel copyWith({
    String? description,
    File? photo,
    double? latitude,
    double? longitude,
  }) {
    return AddNewStoryRequestModel(
      description: description ?? this.description,
      photo: photo ?? this.photo,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
