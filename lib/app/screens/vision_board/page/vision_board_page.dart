// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/app/core/enums.dart';
import 'package:my_bullet_journal/app/core/global_variables.dart';
import 'package:my_bullet_journal/app/core/injection_container.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/vision_board_model.dart';
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
      create: (context) {
        return getIt<VisionBoardCubit>()..start();
      },
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
                  FloatingActionButtonLocation.centerDocked,
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Image(image: AssetImage('assets/images/2.png')),
                Column(
                  children: [
                    Text(
                      'Create Your Vision Board',
                      style: initialdiplaysTextStyle,
                    ),
                    empty,
                    ElevatedButton(
                        onPressed: () async {
                          XFile? file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          setState(
                            () {
                              pickedFile = file;
                              if (pickedFile != null) {
                                context
                                    .read<VisionBoardCubit>()
                                    .addImage(pickedFile!);
                              } else {
                                return;
                              }
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: appPurple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: const Icon(Icons.add_a_photo_outlined))
                  ],
                ),
              ],
            ),
          ),
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

  FloatingActionButton addImage(
    BuildContext context,
  ) {
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
      child: const Icon(Icons.add),
    );
  }
}
