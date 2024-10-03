import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderlust/Controller/EditeUserPhoto.dart';
import 'dart:io';



choisimageprof(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  var image = await picker.pickImage(source: ImageSource.gallery);
  if (image!.path.isNotEmpty) {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio7x5,
      ],
      uiSettings: [
        AndroidUiSettings(
            hideBottomControls: true,
            statusBarColor: Color(0xff4C4DDC),
            activeControlsWidgetColor:Color(0xff4C4DDC) ,
            toolbarColor: Color(0xff4C4DDC),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true
        ),
      ],
    );
    await EditePhotoAPIS(context).EditePhotoAPI(File(croppedFile!.path));
  }
}