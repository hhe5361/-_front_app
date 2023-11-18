// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:provider/provider.dart';
// import 'package:trackproject/src/models/Album.dart';
// import 'package:trackproject/src/provider/AlbumData.dart';

// class ImageSelectPage extends StatelessWidget {
//   ImageSelectPage({super.key});

//   late ImageAlbumProvider _imageAlbumProvider;
//   Widget _dropalbums() {
//     return Container(
//         child: _imageAlbumProvider.album != null
//             ? DropdownButton<Album>(
//                 value: _imageAlbumProvider.currentalbum,
//                 items: _imageAlbumProvider.album!
//                     .map((e) => DropdownMenuItem<Album>(
//                           value: e,
//                           child: Text(e.name),
//                         ))
//                     .toList(),
//                 onChanged: (Album? value) =>
//                     _imageAlbumProvider.changealbum(value!),
//               )
//             : null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     _imageAlbumProvider = Provider.of<ImageAlbumProvider>(context);

//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               iconTheme: const IconThemeData(color: Colors.black),
//               title: const Text("사진 선택",
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold)),
//               centerTitle: true,
//               elevation: 0.5,
//               backgroundColor: Colors.white,
//               //actions: [_dropalbums()],
//             ),
//             body: _imageAlbumProvider.loading != true
//                 ? GridPhoto(
//                     images: _imageAlbumProvider.images,
//                   )
//                 : const Center(
//                     child: CircularProgressIndicator(),
//                   )));
//   }
// }

// class GridPhoto extends StatefulWidget {
//   List<AssetEntity> images;

//   GridPhoto({
//     required this.images,
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<GridPhoto> createState() => _GridPhotoState();
// }

// class _GridPhotoState extends State<GridPhoto> {
//   Widget _renderimage(AssetEntity e) {
//     return Padding(
//       padding: const EdgeInsets.all(5),
//       child: AssetEntityImage(
//         e,
//         isOriginal: false,
//         fit: BoxFit.cover,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       physics: const BouncingScrollPhysics(),
//       gridDelegate:
//           const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//       itemCount: widget.images.length,
//       itemBuilder: (context, index) {
//         return _renderimage(widget.images[index]);
//       },
//     );
//   }
// }
