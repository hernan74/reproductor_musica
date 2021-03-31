import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reproductor_musica/src/pages/reproductor_page.dart';
import 'package:reproductor_musica/src/provider/musica_provider.dart';
import 'package:reproductor_musica/src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MusicaProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: ' Titulo',
        initialRoute: '/',
        theme: miTema,
        routes: {'/': (_) => ReproductorPage()},
      ),
    );
  }
}
