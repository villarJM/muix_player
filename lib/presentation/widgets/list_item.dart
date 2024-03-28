import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 class ListItem extends StatelessWidget {
 const ListItem({ Key? key }) : super(key: key);
 
   @override
   Widget build(BuildContext context){
     return Container(
      height: 45.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(20),
        ),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 5, 23, 39), Color.fromARGB(200, 228, 211, 182),Color.fromARGB(255, 228, 211, 182),],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(
              'assets/images/better_off.jpg',
              fit: BoxFit.cover,
              height: 45.h,
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Better Off (Alone, pt. II)'),
                  Text('Alan Walker')
                ],
              ),
            ),
          ),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert))
        ],
      ),
    );
   }
 }