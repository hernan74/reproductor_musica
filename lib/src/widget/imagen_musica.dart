import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reproductor_musica/src/provider/musica_provider.dart';

class ImagenDiscoWidget extends StatefulWidget {
  final double size;
  final Color colorFondo1;
  final Color colorFondo2;

  const ImagenDiscoWidget(
      {Key key, this.size, this.colorFondo1, this.colorFondo2})
      : super(key: key);

  @override
  _ImagenDiscoWidgetState createState() => _ImagenDiscoWidgetState();
}

class _ImagenDiscoWidgetState extends State<ImagenDiscoWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> giro;

  @override
  void initState() {
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 10));
    giro = Tween(begin: 0.0, end: -pi * 2).animate(controller);

    controller.addListener(() {
      if (controller.isCompleted &&
          Provider.of<MusicaProvider>(context,listen: false).isPlaying) {
        controller.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<MusicaProvider>(context).isPlaying)
      controller.forward();
    else
      controller.stop();

    return Container(
      width: widget.size,
      height: widget.size,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150.0),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [widget.colorFondo1, widget.colorFondo2])),
      child: Stack(alignment: Alignment.center, children: [
        AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Transform.rotate(
              angle: giro.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image(
                  image: AssetImage('assets/aurora.jpg'),
                ),
              ),
            );
          },
        ),
        Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            color: Color(0xff939A9B).withOpacity(0.7),
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40.0),
          ),
        )
      ]),
    );
  }
}
