import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/vision_board_model.dart';

class VisionBoard extends StatefulWidget {
  const VisionBoard({
    super.key,
  });

  @override
  State<VisionBoard> createState() => _VisionBoardState();
}

class _VisionBoardState extends State<VisionBoard> {
  List<String> allImages = [];
  List<String> allID = [];
  List<String> pickedID = [];
  List<String> pickedImage = [];
  XFile? pickedFile;
  var itemModel = VisionBoardModel(image: '', id: '');
  List<int> _selectedIndexList = [];
  bool _selectionMode = false;

  void _changeSelection(
      {required bool enable,
      required int index,
      required String imageID,
      required String imageURL}) {
    _selectionMode = enable;
    _selectedIndexList.add(index);
    pickedImage.add(imageURL);
    pickedID.add(imageID);
    if (index == -1) {
      _selectedIndexList.clear();
      pickedID.clear();
      pickedImage.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisionBoardCubit(VisionBoardRepository())..start(),
      child: BlocConsumer<VisionBoardCubit, VisionBoardState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage.toString())));
          }
        },
        builder: (context, state) {
          final images = state.items;
          for (final image in images) {
            allImages.add(image.image);
            itemModel = image;
            allID.add(image.id);
          }
          if (allImages.isNotEmpty) {
            return Builder(builder: (context) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: allImages.length,
                    itemBuilder: (context, index) {
                      return getGridTile(index);
                    },
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                    },
                  ),
                ),
                floatingActionButton: _getFAB(context),
              );
            });
          }
          return _initialDisplay(context);
        },
      ),
    );
  }

  Scaffold _initialDisplay(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Create your Vision Board'),
          ),
          ElevatedButton(
              onPressed: () async {
                XFile? file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                setState(
                  () {
                    pickedFile = file;
                    if (pickedFile != null) {
                      context.read<VisionBoardCubit>().addImage(pickedFile!);
                    } else {
                      return;
                    }
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                fixedSize: const Size(40, 40),
              ),
              child: const Icon(Icons.add_a_photo))
        ],
      ),
    );
  }

  GridTile getGridTile(int index) {
    if (_selectionMode) {
      return GridTile(
        header: GridTileBar(
          leading: Icon(
            _selectedIndexList.contains(index)
                ? Icons.check_circle_outline
                : Icons.radio_button_unchecked,
            color: _selectedIndexList.contains(index)
                ? Colors.white
                : Colors.black,
          ),
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
                width: 10,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                allImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
          onLongPress: () {
            setState(() {
              _changeSelection(
                  enable: false, index: -1, imageID: '', imageURL: '');
            });
          },
          onTap: () {
            setState(() {
              if (_selectedIndexList.contains(index)) {
                _selectedIndexList.remove(index);
              } else {
                _selectedIndexList.add(index);
              }
              setState(() {
                if (pickedID.contains(allID[index])) {
                  pickedID.remove(allID[index]);
                } else {
                  pickedID.add(allID[index]);
                }
              });
              setState(() {
                if (pickedImage.contains(allImages[index])) {
                  pickedImage.remove(allImages[index]);
                } else {
                  pickedImage.add(allImages[index]);
                }
              });
            });
          },
        ),
      );
    }
    return GridTile(
      child: InkResponse(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: Image.network(
            allImages[index],
            fit: BoxFit.cover,
          ),
        ),
        onLongPress: () {
          setState(() {
            _changeSelection(
                enable: true,
                index: index,
                imageID: allID[index],
                imageURL: allImages[index]);
          });
        },
      ),
    );
  }

  Widget _getFAB(context) {
    if (_selectionMode) {
      return BlocBuilder<VisionBoardCubit, VisionBoardState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              for (final image in pickedImage) {
                context
                    .read<VisionBoardCubit>()
                    .deleteImageFromFirestore(url: image);
              }
              for (final image in pickedID) {
                context.read<VisionBoardCubit>().deleteImageFromFirebase(
                      docID: image,
                    );
              }
              setState(() {
                allImages.clear();
              });
              setState(() {
                pickedImage.clear();
              });
              setState(() {
                pickedID.clear();
              });
            },
            child: const Icon(Icons.delete),
          );
        },
      );
    }
    return BlocBuilder<VisionBoardCubit, VisionBoardState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () async {
            XFile? file =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            setState(() {
              pickedFile = file;
              if (pickedFile != null) {
                context.read<VisionBoardCubit>().addImage(pickedFile!);
              } else {
                return;
              }
              setState(() {
                allImages.clear();
              });
            });
          },
          child: const Icon(Icons.add_a_photo),
        );
      },
    );
  }
}
