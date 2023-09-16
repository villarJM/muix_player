import 'package:flutter/material.dart';

class DashboardPlayer extends StatelessWidget {
  const DashboardPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 90, 0, 0),
                child: Text('New Single', textAlign: TextAlign.left,)),
            ),
            // Card New Single Music
            _CardNewMusic(),
          ],
        ),
      ),
    );
  }
}

class _CardNewMusic extends StatelessWidget {
  const _CardNewMusic();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SizedBox(
        height: 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(10),
            elevation: 10,
          
            // Dentro de esta propiedad usamos ClipRRect
            child: ClipRRect(
              // Los bordes del contenido del card se cortan usando BorderRadius
              borderRadius: BorderRadius.circular(10),
          
              // EL widget hijo que será recortado segun la propiedad anterior
              child: const Column(
                children: <Widget>[
                  // Usamos el widget Image para mostrar una imagen
                  Image(
                    width: double.infinity,
                    height: 170,
                    // Como queremos traer una imagen desde un url usamos NetworkImage
                    image: NetworkImage(
                        'https://www.yourtrainingedge.com/wp-content/uploads/2019/05/background-calm-clouds-747964.jpg'),
                        fit: BoxFit.cover,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
