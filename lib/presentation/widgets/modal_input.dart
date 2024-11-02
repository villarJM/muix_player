import 'package:flutter/material.dart';
import 'package:muix_player/presentation/widgets/blur_container.dart';

Future modalInput<T>({
    required BuildContext context,
    required TextEditingController? controller,
    required void Function()? onPressed
  }) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: BlurContainer(
        height: 70,
        width: double.infinity,
        
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: 'New Playlist',
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        color: Colors.white
                      ),
                    ),
                    filled: false,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        color: Colors.white
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: controller,
                ),
              ),
              const SizedBox(width: 10,),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  foregroundColor: Colors.white
                ), 
                child: const Text('Save', style: TextStyle(color: Colors.black),),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

