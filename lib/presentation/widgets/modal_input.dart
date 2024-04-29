import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:muix_player/theme/app_muix_theme.dart';

Future modalInput<T>({
    required BuildContext context,
    required TextEditingController? controller,
    required void Function()? onPressed
  }) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: GlassContainer(
        height: 50.h,
        width: double.infinity,
        blur: 10,
        gradient: LinearGradient(
          colors: [AppMuixTheme.background.withOpacity(0.40), AppMuixTheme.background.withOpacity(0.10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.39, 0.40, 1.0],
        ),
        borderWidth: 1.2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintText: 'New Playlist',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        color: Colors.white
                      ),
                    ),
                    fillColor: AppMuixTheme.backgroundSecondary,
                    filled: true,
                  ),
                  controller: controller,
                ),
              ),
              const SizedBox(width: 10,),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppMuixTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  foregroundColor: Colors.white
                ), 
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

