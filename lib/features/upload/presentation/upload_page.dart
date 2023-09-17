import 'dart:io';
import 'package:dayagram/features/upload/bloc/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final ImagePicker picker = ImagePicker();
  File? image;
  Future pickImage() async {
    try {
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (_) {}
  }

  Future takeImage() async {
    try {
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (_) {}
  }

  TextEditingController messageCtrl = TextEditingController();
  TextEditingController videoCtrl = TextEditingController();
  String? message;
  String? videoUrl;

  @override
  Widget build(BuildContext context) {
    UploadBloc uploadBloc = UploadBloc();
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Page")),
      body: BlocConsumer(
        bloc: uploadBloc,
        listener: (context, state) {
          if (state is UploadSuccess) {
            const snackBar = SnackBar(content: Text('Successed Upload'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is UploadInitial ||
              state is UploadLoading ||
              state is UploadSuccess ||
              state is UploadError) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextFormField(
                              controller: messageCtrl,
                              onChanged: (value) {
                                message = value;
                              },
                              maxLines: 3,
                              decoration: const InputDecoration(
                                  hintText: 'Write a caption ...',
                                  label: Text('Message'),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8))),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                            ),
                          ),
                        ),
                        image != null
                            ? Image.file(
                                image!,
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                color: Colors.blueGrey[50],
                                height: 90,
                                width: 90,
                                child: const Center(child: Text('No Photo')),
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: videoCtrl,
                      onChanged: (value) {
                        videoUrl = value;
                      },
                      decoration: InputDecoration(
                          label: Text(
                            'Youtube (Optional)',
                          ),
                          hintText: "Youtube Link ..."),
                    ),
                  ),
                  MaterialButton(
                      color: Colors.blue,
                      child: const Text("Pick Image from Gallery",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        pickImage();
                      }),
                  MaterialButton(
                      color: Colors.blue,
                      child: const Text("Pick Image from Camera",
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        takeImage();
                      }),
                  FloatingActionButton(
                      child: const Icon(Icons.upload),
                      onPressed: () {
                        print(message);
                        print(videoUrl);
                        print(image);
                        uploadBloc.add(UploadPost(
                            image: image,
                            message: message,
                            videoUrl: videoUrl));
                      }),
                  (state is UploadError)
                      ? Container(
                          padding: EdgeInsets.all(16),
                          child: Text(state.message,
                              style: TextStyle(color: Colors.red)),
                          alignment: Alignment.center,
                        )
                      : const SizedBox()
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
