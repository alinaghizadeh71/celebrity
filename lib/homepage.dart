import 'dart:async';
import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:celebrity/contant.dart';
import 'package:celebrity/showpic.dart';
import 'package:celebrity/widget/linearHorizontalloadingwithpic.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'ScaleRoute.dart';

class homepage extends StatefulWidget {
   homepage({super.key});
 static File? filepic;
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  late AnimationController loadingController;

  Animation<double>? animation;
  AnimationController? animationC;
  bool visibleimage = false;
  bool complete = false;
 
  PlatformFile? _platformFile;
scroll()
{
     if (_scrollController.hasClients) {
      //final position = _scrollController.position.minScrollExtent;
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
                        duration: Duration(seconds: 2),
                        curve: Curves.ease
      );
    }
  
}
  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        homepage.filepic = File(file.files.single.path!);
        _platformFile = file.files.first;
      });

      Timer(Duration(seconds: 10), () {
        setState(() {
          complete = true;
          visibleimage = true;
        
        });
      });
      Timer(Duration(seconds: 12), () {
        setState(() {
        
          //Navigator.push(context, ScaleRoute(page: showpic()));
        });
         
          
      });
    }

    loadingController.forward();
  }

  @override
  void initState() {
    /*  animationC =
          AnimationController(vsync: this, duration: Duration(seconds: 1));
      animation =
          Tween<double>(begin: 0, end: -300).animate(animationC!)
            ..addListener(() {
              setState(() {});
            });  */

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
              
            child: Column(
              children: <Widget>[
              /*   SvgPicture.asset(
                  'assets/images/looklike.svg',
                  height: 120,
                  width: 120,
                ), */Image.asset('assets/images/woman.png'),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Who do I look like?',
                  style: TextStyle(
                      fontSize: 25,
                      color: kabsolute,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: scroll,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 20.0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        dashPattern: [10, 4],
                        strokeCap: StrokeCap.round,
                        color: kpale,
                        child: Container(
                          width: double.infinity,
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Iconsax.folder_open,
                                color: kabsolute,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: kabsolute,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  'Select your file',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'File should be jpg, png',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade500),
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
                ),
                SizedBox(
                  height: 30,
                ),
                _platformFile != null
                    ? (complete)
                        ? CircleAvatar(
                            radius: 80.0,
                            backgroundColor: Colors.grey[100],
                            child: Image.asset(
                              'assets/images/check.png',
                              width: 50,
                            ) /* Transform.translate(
                              offset: Offset(0, animation!.value),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/check.png',
                                  ),
                                )),
                              ),
                            ), */
                            )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 80.0,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.file(
                                    homepage.filepic!,
                                    fit: BoxFit.cover,
                                    height: 160.0,
                                    width: 160.0,
                                  ),
                                ),
                              ),
                              Container(
                                  height: 170.0,
                                  width: 170.0,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.grey[100],
                                    color: kabsolute,
                                    strokeWidth: 5.0,
                                    value: loadingController.value,
                                  )),
                            ],
                          )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Image.asset('assets/images/woman.png'),
                 SizedBox(
                  height: 10,
                ),
                Image.asset('assets/images/woman.png'),
                 SizedBox(
                  height: 10,
                ),
                Image.asset('assets/images/woman.png'),
                 SizedBox(
                  height: 10,
                ),
                Image.asset('assets/images/woman.png'),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
