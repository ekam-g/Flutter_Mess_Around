import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class Boomtroll extends StatelessWidget {
  AudioPlayer player = AudioPlayer();

  Boomtroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ekam's BOOM Troll"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await player.setAsset(
                      'assets/CS_ Global Offensive bomb C4 animation.mp3');
                  player.play();
                },
                child: const Text('Boom Start'),
              ),

              const Text(
                'To Stop Close App',
                textAlign: TextAlign.center,
              )

              ///code here
            ],
          ),
        ),
      ),
    );
  }
}
