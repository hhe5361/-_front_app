// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:trackproject/src/models/Album.dart';
// import 'package:trackproject/src/services/albumApi.dart';
// import 'package:trackproject/src/utilities/permission_handler.dart';

// enum AlbumStatus { getimage, loading, nothing }

// class ImageAlbumProvider with ChangeNotifier {
//   final AlbumService _api = AlbumService(requesttype: RequestType.image);
//   List<Album>? _albums; //can null
//   int _currentpage = 0;
//   Album? _currentalbum;
//   List<AssetEntity> _images = [];
//   AlbumStatus _currentstatus = AlbumStatus.loading;

//   List<Album> get album => _albums!;
//   get currentalbum => _currentalbum;
//   get images => _images;
//   get status => _currentstatus;

//   void initdata() async {
//     bool checkpermission = await PermissionHandlerService()
//         .handlePhotosPermission(Permission.photos);
//     if (checkpermission == true) {
//       createAlbumlist();
//     } else {
//       //여기는 동작 안 함. ㅇㅇ true일 때만 동작하도록 하겠음
//     }
//   }

//   Future<void> createAlbumlist() async {
//     _currentstatus = AlbumStatus.loading;
//     notifyListeners();

//     List<AssetPathEntity> paths = await _api.getAlbum();
//     if (paths.isEmpty) {
//       _currentstatus = AlbumStatus.nothing;
//       notifyListeners();
//     } else {
//       _albums = paths
//           .map(
//               (e) => Album(id: e.id, path: e, name: e.isAll ? '모든 사진' : e.name))
//           .toList();
//       _currentalbum = _albums!.first;
//       getimages();
//       _currentstatus = AlbumStatus.getimage;
//       notifyListeners();
//     }
//   }

//   Future<void> changealbum(Album album) async {
//     _currentstatus = AlbumStatus.loading;
//     notifyListeners();


//     _currentalbum = album;
//     _currentpage = 0;
//     _images.clear();

//     await getimages();
//     _currentstatus = AlbumStatus.getimage;
//     notifyListeners();
//   }

//   Future getimages() async {
//     _images +=
//         await _api.getassets(_currentalbum!.path, currentpage: _currentpage);
//     notifyListeners();
//   }

//   //scroll은 나중에 해보자
//   Future<void> scrollon() async {
//     _currentpage = _currentpage + 1;
//     await getimages();
//   }
// }
