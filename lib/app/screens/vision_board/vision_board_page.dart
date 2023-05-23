import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart';
import 'package:my_bullet_journal/repositories/vision_board_repository.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:image_picker/image_picker.dart';

class VisionBoard extends StatefulWidget {
  const VisionBoard({
    super.key,
  });

  @override
  State<VisionBoard> createState() => _VisionBoardState();
}

class _VisionBoardState extends State<VisionBoard> {
  List<String> allImages = [];
  XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisionBoardCubit(VisionBoardRepository())..start(),
      child: BlocBuilder<VisionBoardCubit, VisionBoardState>(
        builder: (context, state) {
          final images = state.items;
          if (images != null) {
            for (final image in images) {
              allImages.add(image.image);
            }
            if (allImages.isNotEmpty) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: allImages.length,
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
                            child: Image.network(
                              allImages[index],
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
                  onPressed: () async {
                    XFile? pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    setState(() {
                      pickedImage = pickedFile;
                      if (pickedImage != null) {
                        context.read<VisionBoardCubit>().addImage(pickedImage!);
                      } else {
                        return;
                      }
                      setState(() {
                        allImages.clear();
                      });
                    });
                  },
                  mini: true,
                  child: const Icon(Icons.add_a_photo),
                ),
              );
            }
          }
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text('Create your Vision Board'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      XFile? pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      setState(
                        () {
                          pickedImage = pickedFile;
                          if (pickedImage != null) {
                            context
                                .read<VisionBoardCubit>()
                                .addImage(pickedImage!);
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
        },
      ),
    );
  }
}
