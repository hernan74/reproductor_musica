import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reproductor_musica/src/provider/musica_provider.dart';

class ProgresoMusicaWidget extends StatelessWidget {
  final double ancho;
  final double alto;
  final int minutoMaximo;
  final int minActual;

  const ProgresoMusicaWidget(
      {Key key, this.ancho, this.alto, this.minutoMaximo, this.minActual})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MusicaProvider>(context);

    final porcentaje = provider.porcentaje;
    final style =
        TextStyle(color: Color(0xff58565D), fontWeight: FontWeight.bold);
    return Container(
      width: ancho,
      height: alto,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
              top: 10,
              child: Text(
                provider.totalMusica,
                style: style,
              )),
          _BarraProgresoMusica(
            porcentaje: porcentaje,
          ),
          Positioned(
              bottom: 10, child: Text(provider.tiempoActual, style: style))
        ],
      ),
    );
  }
}

class _BarraProgresoMusica extends StatelessWidget {
  final double porcentaje;

  const _BarraProgresoMusica({Key key, this.porcentaje}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 2,
          height: 180,
          color: Colors.white.withOpacity(0.2),
        ),
        Container(
          width: 2,
          height: 180 * porcentaje,
          color: Colors.white.withOpacity(0.8),
        )
      ],
    );
  }
}
