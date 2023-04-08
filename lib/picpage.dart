import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class picpage extends StatelessWidget {
   picpage({super.key});
 File? _file;
  PlatformFile? _platformFile;
  double _size = 100.0;
  bool _large = true;
    bool visibleimage = false;
  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: (_file == null)
                          ? Container()
                          : AnimatedSize(
                              curve: Curves.easeIn,
                              duration: const Duration(seconds: 1),
                              child: Image.file(
                                _file!,
                                width: _size,
                              ),
                            )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Visibility(
                      visible: visibleimage,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: (_file == null)
                              ? Container()
                              : Image.file(
                                  _file!,
                                  width: 150,
                                )),
                    ),
                  ),
                ],
              ),
            );
  }
}