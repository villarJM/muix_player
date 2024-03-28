import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/list_item.dart';

class Songs extends StatelessWidget {
const Songs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          
          return index % 2 == 0 ?
          ListItem()
          :
          ListItem();
        },
      ),
    );
  }
}