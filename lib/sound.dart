// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class Sound extends StatelessWidget {
  AudioPlayer player = AudioPlayer();

  Sound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ekam's Sound Troll"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player.setAsset(
                            'assets/Dramatic Vine_Instagram Boom - Sound Effect (HD).mp3');
                        player.play();
                      },
                      child: const Text(
                        'Vine Boom',
                        style: TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player.setAsset(
                            'assets/Among Us (Role Reveal) - Sound Effect (HD).mp3');
                        player.play();
                      },
                      child: const Text(
                        'Amoug Us \n Role Reveal',
                        style: TextStyle(fontSize: 8),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player.setAsset('assets/SHEESH SOUND EFFECT.mp3');
                        player.play();
                      },
                      child: const Text('SHEEESH',
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player.setAsset(
                            "assets/_Spy's sappin' my Sentry!_ (Engineer Voice Lines).mp3");
                        player.play();
                      },
                      child: const Text('SPY ZAP!',
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  const Spacer(),
                ],
              ),

              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player
                            .setAsset('assets/Air Horn sound effect.mp3');
                        player.play();
                      },
                      child: const Text('AirHorn'),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player.setAsset('assets/Talking ben Yes.mp3');
                        player.play();
                      },
                      child: const Text('Talking Ben Yes',
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player.setAsset(
                            'assets/Talking Ben Saying No Sound Effect.mp3');
                        player.play();
                      },
                      child: const Text('Talking Ben Saying No',
                          style: TextStyle(fontSize: 6)),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        await player.setAsset('assets/YOUR MOTHER spy tf2.mp3');
                        player.play();
                      },
                      child: const Text('YOUR MOTHER spy TF2',
                          style: TextStyle(fontSize: 6),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),

              ///code here
            ],
          ),
        ),
      ),
    );
  }
}
