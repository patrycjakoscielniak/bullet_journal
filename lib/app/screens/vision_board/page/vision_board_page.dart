// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:my_bullet_journal/models/vision_board_model.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:image_picker/image_picker.dart';

import '../features/delete_vision_board_image.dart';

class VisionBoardPage extends StatefulWidget {
  const VisionBoardPage({
    super.key,
  });

  @override
  State<VisionBoardPage> createState() => _VisionBoardPageState();
}

class _VisionBoardPageState extends State<VisionBoardPage> {
  XFile? pickedFile;
  bool _deleteMode = false;
  List<int> _selectedIndexList = [];
  List<String> _selectedIdList = [];
  List<String> _selectedUrlList = [];
  List<VisionBoardModel> images = [];

  @override
  Widget build(BuildContext context) {
    void changeSelection(bool enable, int index) {
      _deleteMode = enable;
      if (index != -1) {
        _selectedIndexList.add(index);
        _selectedIdList.add(images[index].id);
        _selectedUrlList.add(images[index].image);
      }
      if (index == -1) {
        _selectedIdList.clear();
        _selectedIndexList.clear();
        _selectedUrlList.clear();
      }
    }

    return BlocProvider(
      create: (context) => VisionBoardCubit(VisionBoardRepository())..start(),
      child: BlocConsumer<VisionBoardCubit, VisionBoardState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage.toString())));
          }
          if (state.status == Status.loading) {
            const CircularProgressIndicator();
          }
          if (state.status == Status.deleted) {
            changeSelection(false, -1);
          }
        },
        builder: (context, state) {
          images = state.items;
          if (images.isEmpty) {
            return _initialDisplay(context);
          }
          return Builder(builder: (context) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return getGridTile(index, changeSelection);
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                  },
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: _deleteMode
                  ? DeleteImage(
                      selectedIdList: _selectedIdList,
                      selectedUrlList: _selectedUrlList)
                  : addImage(context),
            );
          });
        },
      ),
    );
  }

  Scaffold _initialDisplay(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Create your Vision Board',
              style: GoogleFonts.satisfy(),
            ),
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

  GridTile getGridTile(int index, changeSelection) {
    if (_deleteMode) {
      return GridTile(
        header: GridTileBar(
            leading: Icon(
          _selectedIndexList.contains(index)
              ? Icons.check_circle_outline
              : Icons.radio_button_unchecked,
          color: _selectedIndexList.contains(index)
              ? Colors.black
              : Colors.blueGrey,
        )),
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              changeSelection(false, -1);
            });
          },
          onTap: () {
            setState(() {
              if (_selectedIndexList.contains(index) &&
                  _selectedIdList.contains(images[index].id) &&
                  _selectedUrlList.contains(images[index].image)) {
                _selectedIndexList.remove(index);
                _selectedIdList.remove(images[index].id);
                _selectedUrlList.remove(images[index].image);
              } else {
                _selectedIndexList.add(index);
                _selectedIdList.add(images[index].id);
                _selectedUrlList.add(images[index].image);
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: Image.network(
                images[index].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    } else {
      return GridTile(
        child: GestureDetector(
          onLongPress: () {
            setState(() {
              changeSelection(true, index);
            });
          },
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: Image.network(
              images[index].image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }

  FloatingActionButton addImage(BuildContext context) {
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
        });
      },
      backgroundColor: Colors.white,
      foregroundColor: Colors.blueGrey,
      child: const Icon(
        Icons.add,
        size: 40,
        weight: 20,
      ),
    );
  }
}
