import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glass_kit/glass_kit.dart';

Future modalDelete<T>({
  required BuildContext context,
  required void Function()? onPressed,
}) {
  return showDialog(
      context: context,
      builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: GlassContainer(
        height: 100.h,
        width: double.infinity,
        blur: 10,
        gradient: const LinearGradient(
          colors: [
           
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.60),
            Colors.white.withOpacity(0.10),
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.6)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.39, 0.40, 1.0],
        ),
        borderWidth: 1.2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Expanded(
                      child: Text(
                    'Do you want to delete this playlist?',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                      foregroundColor: Colors.white),
                    child: const Text('Cancel'),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                        foregroundColor: Colors.white),
                      child: const Text('Delete'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    )
  );
}
