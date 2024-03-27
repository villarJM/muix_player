import 'package:flutter/material.dart';

class CustomBoxActivity extends StatelessWidget {

final String title;
  final double height;
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;
  final Widget? image;

  const CustomBoxActivity({ 
    Key? key,
    required this.title,
    required this.height, 
    required this.topLeft, 
    required this.topRight, 
    required this.bottomLeft, 
    required this.bottomRight ,
    this.image 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
          ),
          border: Border.all(
            color: Colors.black
          )
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft),
                bottomRight: Radius.circular(bottomRight),
                topLeft: Radius.circular(topLeft),
                topRight: Radius.circular(topRight),
              ),
              child: image,
            ),
            Expanded(child: Text(title, overflow: TextOverflow.fade, textAlign: TextAlign.center,)),
          ],
        ),
      ),
    );
  }
}