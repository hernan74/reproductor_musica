import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reproductor_musica/src/helpers/helpers.dart';
import 'package:reproductor_musica/src/provider/musica_provider.dart';
import 'package:reproductor_musica/src/widget/custom_app_bar.dart';
import 'package:reproductor_musica/src/widget/imagen_musica.dart';
import 'package:reproductor_musica/src/widget/progreso_musica.dart';

class ReproductorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            _CrearReproductor(),
            _CrearLetraMusica()
          ],
        ),
      ),
    );
  }
}

class _CrearReproductor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height * 0.73,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
          gradient:
              LinearGradient(colors: [Color(0xff32323C), Color(0xff201E27)])),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          Container(
            width: double.infinity,
            height: 350.0,
            child: Row(
              children: [
                SizedBox(
                  width: 30.0,
                ),
                ImagenDiscoWidget(
                  size: 254.0,
                  colorFondo1: Color(0xff3F3E46),
                  colorFondo2: Color(0xff1E1C23),
                ),
                Spacer(),
                SizedBox(
                  width: 20.0,
                ),
                ProgresoMusicaWidget(
                  alto: 230.0,
                  ancho: 40.0,
                ),
                SizedBox(
                  width: 25.0,
                )
              ],
            ),
          ),
          _NombreMusicaPley(),
        ],
      ),
    );
  }
}

class _NombreMusicaPley extends StatefulWidget {
  const _NombreMusicaPley({
    Key key,
  }) : super(key: key);

  @override
  __NombreMusicaPleyState createState() => __NombreMusicaPleyState();
}

class __NombreMusicaPleyState extends State<_NombreMusicaPley>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> pleyPause;
  final assetAudioPlayer = new AssetsAudioPlayer();
  bool firstTime = true;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    pleyPause = Tween(begin: 0.0, end: 1.0).animate(controller);

    Provider.of<MusicaProvider>(context, listen: false).controller = controller;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void open() {
    final provider = Provider.of<MusicaProvider>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'));
    assetAudioPlayer.currentPosition.listen((duration) {
      provider.current = duration;
    });
    assetAudioPlayer.current.listen((playingAudio) {
      provider.songDuration = playingAudio.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Far Away',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '-Breaking Benjamin-',
                style: TextStyle(fontSize: 20.0, color: Color(0xff949398)),
              )
            ],
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () {
              if (controller.isCompleted) {
                Provider.of<MusicaProvider>(context, listen: false).isPlaying =
                    false;
                controller.reverse();
              } else {
                Provider.of<MusicaProvider>(context, listen: false).isPlaying =
                    true;
                controller.forward(from: 0.0);
              }
              if (firstTime) {
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: pleyPause,
            ),
            backgroundColor: Color(0xffF1CC66),
          ),
        ],
      ),
    );
  }
}

class _CrearLetraMusica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: ListWheelScrollView(
        itemExtent: 42,
        children: getLyrics()
            .map((e) => Text(
                  e,
                  style: TextStyle(fontSize: 25, height: 2.1),
                ))
            .toList(),
      ),
    );
  }
}
