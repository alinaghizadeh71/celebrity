import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:iconsax/iconsax.dart';

class linearHorizontalloadingwithpic extends StatefulWidget {
   linearHorizontalloadingwithpic({super.key});

  @override
  State<linearHorizontalloadingwithpic> createState() => _linearHorizontalloadingwithpicState();
}

class _linearHorizontalloadingwithpicState  extends State<linearHorizontalloadingwithpic>
    with SingleTickerProviderStateMixin {
   late AnimationController loadingController;
  bool visibleimage = false;
  File? _file;
  PlatformFile? _platformFile;
  double _size = 100.0;
  bool _large = true;

     selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
        _size = 150.0;
      });

      Timer(Duration(seconds: 15), () {
        setState(() {
          visibleimage = true;
          _size = 100.0;
        });
      });
    }

    loadingController.forward();
  }

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[           
                Text(
                  'Who do I look like?',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 10,
                ),
                Image.asset('assets/images/like.jpg'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Upload your file',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'File should be jpg, png',
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: selectFile,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        dashPattern: [10, 4],
                        strokeCap: StrokeCap.round,
                        color: Colors.blue.shade400,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50.withOpacity(.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.folder_open,
                                color: Colors.blue,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select your file',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    'Your images will not be saved',
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                  ),
                ), SizedBox(
                  height: 20,
                ),
                _platformFile != null
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [                     
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: Offset(0, 1),
                                      blurRadius: 3,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(_file!, width: 50,)
                              ),
                              SizedBox(width: 10,),
                               Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _platformFile!.name,
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${(_platformFile!.size / 1024).ceil()} KB',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade500),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                        height: 5,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.blue.shade50,
                                        ),
                                        child: LinearProgressIndicator(
                                          value: loadingController.value,
        
                                        )),
                                  ],
                                ),
                              ),])
                            ),
                          ],
                        ))
                    : Container(),
                SizedBox(
                  height: 10,
                ),
            
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}