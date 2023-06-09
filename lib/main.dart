import 'dart:async';
import 'dart:io';
import 'package:celebrity/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

void main() {
  runApp(MaterialApp(
    home: homepage(),
  ));
}

class mainpage extends StatefulWidget {
  mainpage({super.key});
  static File? imgFile;
  static File? imgFile1;
  static String? namecelebrity;
  static bool visiblebtn = false;
  static RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(fontFamily: 'IRANYEKAN'),
      debugShowCheckedModeBanner: false,
     
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text('Celebrity'),
            elevation: 5,
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    mainpage.imgFile = null;
                    mainpage.imgFile1 = null;
                    mainpage.namecelebrity = '';
                    mainpage.visiblebtn = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.refresh),
                ),
              )
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: 20.0),
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //send img to server
                mainpage.imgFile == null
                    ? Container(
                        width: 200,
                        height: 200,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        child: Image.file(
                          mainpage.imgFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  height: 20.0,
                ),
                //btn img to server
                Visibility(
                  visible: mainpage.visiblebtn!,
                  child: RoundedLoadingButton(
                    child:
                        Text('شبیه کدوم سلبریتیه؟', style: TextStyle(color: Colors.white,fontSize: 15)),
                    controller: mainpage._btnController,
                    onPressed: _doSomething,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                //get img from server
                mainpage.imgFile1 == null
                    ? Container(
                        width: 200,
                        height: 200,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        child: Image.file(
                          mainpage.imgFile1!,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  height: 20.0,
                ),
                Text(mainpage.namecelebrity ?? '')
              ],
            ),
          ),
          floatingActionButton: ExpandableFabClass(
            distanceBetween: 80.0,
            subChildren: [
              ActionButton(
                onPressed: () {
                  _getFromGallery();
                },
                icon: const Icon(Icons.image_outlined),
              ),
              ActionButton(
                onPressed: () {
                  _getFromCamera();
                },
                icon: const Icon(Icons.camera_alt_outlined),
              ),
            ],
          ),
       
      ),
    );
  }

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      mainpage._btnController.success();
      mainpage.imgFile1 = mainpage.imgFile;
      mainpage.namecelebrity = 'malihe';

      setState(() {});
    });
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        mainpage.visiblebtn = true;
        mainpage.imgFile = File(pickedFile.path);
        mainpage.imgFile1 = null;
         mainpage.namecelebrity='';
        mainpage._btnController.reset();
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        mainpage.visiblebtn = true;
        mainpage.imgFile = File(pickedFile.path);
        mainpage.imgFile1 = null;
        mainpage.namecelebrity='';
        mainpage._btnController.reset();
      });
    }
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.icon,
    this.tooltip,
    this.onPressed,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.accentColor,
      elevation: 4.0,
      child: IconTheme.merge(
        data: theme.accentIconTheme,
        child: IconButton(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}

class ExpandableFabClass extends StatefulWidget {
  const ExpandableFabClass({
    Key? key,
    this.isInitiallyOpen,
    required this.distanceBetween,
    required this.subChildren,
  }) : super(key: key);

  final bool? isInitiallyOpen;
  final double distanceBetween;
  final List<Widget> subChildren;

  @override
  _ExpandableFabClassState createState() => _ExpandableFabClassState();
}

class _ExpandableFabClassState extends State<ExpandableFabClass>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimationFab;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.isInitiallyOpen ?? false;
    _animationController = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimationFab = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.subChildren.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distanceBetween,
          progress: _expandAnimationFab,
          child: widget.subChildren[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class _ExpandingActionButton extends StatelessWidget {
  _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
