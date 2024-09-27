import 'package:fast_app_base/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nav/dialog/dialog.dart';

class SelectImagesourceDialog extends DialogWidget<ImageSource> {
  SelectImagesourceDialog({super.key});

  @override
  DialogState<SelectImagesourceDialog> createState() => _SelectImagesourceDialogState();
}

class _SelectImagesourceDialogState extends DialogState<SelectImagesourceDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 300
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: context.backgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Tap(
                  onTap: () => widget.hide(ImageSource.camera),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt),
                      Text('카메라')
                    ],
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Line(),),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Tap(
                  onTap: () => widget.hide(ImageSource.gallery),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_outlined),
                      Text('갤러리')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}