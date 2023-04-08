
import 'package:celebrity/homepage.dart';
import 'package:flutter/material.dart';
import 'contant.dart';

class showpic extends StatelessWidget {
  const showpic({super.key});

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){} ,
        backgroundColor: kabsolute,
        child: Icon(Icons.share)),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
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
                               SizedBox(height: 10.0,),
                          Text('you',style: TextStyle(fontSize: 20.0))
                      ],
                   
                    )
                  ],
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: Image.asset(
                                'assets/images/arrow.png',
                                width: 100,
                              ),
                    ),
                           
                    Column(
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
                              SizedBox(height: 10.0,),
                            Text('Selena',style: TextStyle(fontSize: 20.0),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 50.0,),
                 GestureDetector(child:     Container(
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
                 onTap: () {
                   Navigator.pop(context);
                 },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
