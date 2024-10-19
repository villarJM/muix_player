import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';

class BoxItemMusic extends StatelessWidget {

  final Widget title;

  const BoxItemMusic({ 
    Key? key, required this.title 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadiusDirectional.vertical(top: Radius.circular(25)),
                  child: Image.asset(
                    'assets/images/better_off.jpg',
                    fit: BoxFit.cover,
                    width: 300,
                    alignment: Alignment.center
                  ),
                ),
              ),
              BlurContainer(
                borderRadius: const BorderRadiusDirectional.vertical(bottom: Radius.circular(25)),
                height: 60,
                color: Colors.white.withOpacity(0.11),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(child: title ),
            )
          ),
        ],
      ),
    );
  }
}