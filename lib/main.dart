import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ekams_social_app/NewStuff.dart';
import 'meanno.dart';
import 'sound.dart';
import 'Boomtroll.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer player;
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ekam's Social App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Builder(builder: (context) {
                return SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) => Sound())));
                      },
                      child: const Text('Sound Trolling'),
                    ));
              }),

              Builder(builder: (context) {
                return SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => Boomtroll())));
                      },
                      child: const Text('BOOOOM Trolling'),
                    ));
              }),
              Builder(builder: (context) {
                return SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const SpeechApp())));
                      },
                      child: const Text(
                        'Mean Detector',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ));
              }),

              Builder(builder: (context) {
                return SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const Proggy())));
                      },
                      child: const Text('Work in Progress'),
                    ));
              }),

              ///code here
            ],
          ),
        ),
      ),
    );
  }
}
