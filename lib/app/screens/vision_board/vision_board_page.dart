import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:path/path.dart';

class VisionBoard extends StatefulWidget {
  const VisionBoard({
    super.key,
  });

  @override
  State<VisionBoard> createState() => _VisionBoardState();
}

class _VisionBoardState extends State<VisionBoard> {
  var fileImages = [];

  @override
  Widget build(BuildContext context) {
    if (fileImages.isEmpty) {
      const Scaffold(
        body: Center(child: Text('No images added')),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: fileImages.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  )),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: Image.file(
                    fileImages[index],
                    fit: BoxFit.cover,
                  )),
            );
          },
          staggeredTileBuilder: (index) {
            return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getFromGallery();
        },
        mini: true,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  _getFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      File image = File(pickedImage.path);
      final Directory extDir = await getApplicationSupportDirectory();
      String dirPath = extDir.path;
      final String tmpfilePath = basename(pickedImage.path);
      final String fileExtension = extension(pickedImage.path);
      final String filePath = '$dirPath/$tmpfilePath$fileExtension';
      final File newImage = await image.copy(filePath);
      setState(() {
        image = newImage;
        fileImages.add(image);
      });
    } else {
      print('No image selected');
    }
  }
}
