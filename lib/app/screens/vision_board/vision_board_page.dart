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

class VisionBoard extends StatefulWidget {
  const VisionBoard({
    super.key,
  });

  @override
  State<VisionBoard> createState() => _VisionBoardState();
}

class _VisionBoardState extends State<VisionBoard> {
  XFile? pickedFile;

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
          if (state.status == Status.loading) {
            const CircularProgressIndicator();
          }
        },
        builder: (context, state) {
          final images = state.items;
          if (images.isNotEmpty) {
            return Builder(builder: (context) {
              return displayImages(images, context);
            });
          }
          return _initialDisplay(context);
        },
      ),
    );
  }

  Scaffold displayImages(List<VisionBoardModel> images, BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return InkResponse(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: Image.network(
                  images[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add_a_photo),
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
}
