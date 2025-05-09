import '../model/photo.dart';

abstract interface class PhotoRepository {
  Future<List<Photo>> getPhotos();

  Future<Photo> getPhoto(int id);
}
