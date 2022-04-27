import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApp extends StatefulWidget {
  const SpeechApp({Key? key}) : super(key: key);

  @override
  _SpeechAppState createState() => _SpeechAppState();
}

class _SpeechAppState extends State<SpeechApp> {
  bool _hasSpeech = false;
  bool _visible = false;
  bool mean = false;
  bool gaslight = false;
  bool _logEvents = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  @override
  void initState() {
    super.initState();
  }

  /// This initializes SpeechToText. That only has to be done
  Future<void> initSpeechState() async {
    _logEvent('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
      );
      if (hasSpeech) {
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = systemLocale?.localeId ?? '';
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
      });
    } catch (e) {
      setState(() {
        lastError = 'Speech recognition failed: ${e.toString()}';
        _hasSpeech = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mean Detector'),
        ),
        body: Column(children: [
          const HeaderWidget(),
          Column(
            children: <Widget>[
              InitSpeechWidget(_hasSpeech, initSpeechState),
              SpeechControlWidget(_hasSpeech, speech.isListening,
                  startListening, stopListening, cancelListening),
              SessionOptionsWidget(_currentLocaleId, _switchLang, _localeNames,
                  _logEvents, _switchLogging),
            ],
          ),
          Expanded(
            flex: 4,
            child: RecognitionResultsWidget(lastWords: lastWords, level: 1),
          ),
          Expanded(
            flex: 1,
            child: ErrorWidget(lastError: lastError),
          ),
          SpeechStatusWidget(speech: speech),
        ]),
      ),
    );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    _logEvent('start listening');
    lastWords = '';
    lastError = '';
    // Note that `listenFor` is the maximum, not the minimun, on some
    // recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 500),
        pauseFor: const Duration(seconds: 10),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: false,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void showMean() {
    setState(() {
      _visible = !_visible;
    });
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    setState(() {
      level = 0.0;
    });
    setState(() {});
  }

  void cancelListening() {
    _logEvent('cancel');
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  /// This callback is invoked each time new recognition results are
  /// available after `listen` is called.
  void resultListener(SpeechRecognitionResult result) {
    _logEvent(
        'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent(
        'Received error status: $error, listening: ${speech.isListening}');
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    _logEvent(
        'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = 'status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
  }

  void _logEvent(String eventDescription) {
    if (_logEvents) {}
  }

  void _switchLogging(bool? val) {
    setState(() {
      _logEvents = val ?? false;
    });
  }
}

/// Displays the most recently recognized words and the sound level.
class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({
    Key? key,
    required this.lastWords,
    required this.level,
  }) : super(key: key);

  final String lastWords;
  final double level;

  @override
  Widget build(BuildContext context) {
    bool gaslight = false;
    bool mean = false;
    int meanness = 0;
    String meanDisplay = "$meanness";

    //AI
    if (lastWords.contains("code")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("suck")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("f**k")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("d**k")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("s**t")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("crap")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("bad")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("not good")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("trash")) {
      mean = true;
      (meanness + 2);
    }

    if (lastWords.contains("die")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("no one likes")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("who cares")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("f**king")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("s****y")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("no one")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("hell")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("go to")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("ass")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("suck my")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("horrible")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Can't")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Dumb")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("Irresponsible")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Fool")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Failure")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("Ashamed")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Incompetent")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Hate")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Weird")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Disappointment")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("Don't")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Shy")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Wrong")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Lazy")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Inferior")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("Mad")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Ugly")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("fat")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("Never")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Grumpy")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Ridiculous")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("Useless")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("jerk")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("jackass")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("dumbass")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("dork")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("nerd")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("stupid")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("imbecile")) {
      mean = true;
      (meanness + 1);
    }
    //AI exeptions

    if (lastWords.contains("next time")) {
      mean = false;
      (meanness - 3);
    }

    if (lastWords.contains("better")) {
      mean = false;
      (meanness - 3);
    }
    if (lastWords.contains("sorry")) {
      mean = false;
      (meanness - 5);
    }
    if (lastWords.contains("improve")) {
      mean = false;
      (meanness - 5);
    }
    if (lastWords.contains("change")) {
      mean = false;
      (meanness - 3);
    }
    if (lastWords.contains("please")) {
      mean = false;
      (meanness - 5);
    }
    if (lastWords.contains("your good")) {
      mean = false;
      (meanness - 3);
    }
    if (lastWords.contains("tip")) {
      mean = false;
      (meanness - 3);
    }
    if (lastWords.contains("solution")) {
      mean = false;
      (meanness - 3);
    }
    if (lastWords.contains("tips")) {
      mean = false;
      (meanness - 3);
    }

    ///weird exeptions
    ///of ai

    if (lastWords.contains("not very good")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("never improve")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("never do anything")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("do good for once")) {
      mean = true;
      (meanness + 3);
    }
    if (lastWords.contains("for once be nice")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("never nice")) {
      mean = true;
      (meanness + 1);
    }
    if (lastWords.contains("you never")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("I don't mean to be rude")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("That was a surprisingly good decision")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("You're so lucky")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("if only you were better")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("You're too sensitive")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("If that's what you")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("I’m not one to talk")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("I don’t understand why you ")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("I'm not mad")) {
      mean = true;
      (meanness + 2);
    }
    if (lastWords.contains("Is that what you")) {
      mean = true;
      (meanness + 2);
    }
    ///Gaslighting AI

    if (lastWords.contains("stop being")) {
      gaslight = true;
    }
    if (lastWords.contains("your being")) {
      gaslight = true;
    }
    if (lastWords.contains("your just")) {
      gaslight = true;
    }
    if (lastWords.contains("being emotional")) {
      gaslight = true;
    }
    if (lastWords.contains("faking")) {
      gaslight = true;
    }
    if (lastWords.contains("fake")) {
      gaslight = true;
    }
    if (lastWords.contains("imaging")) {
      gaslight = true;
    }
    if (lastWords.contains("that never")) {
      gaslight = true;
    }
    if (lastWords.contains("your over")) {
      gaslight = true;
    }
    if (lastWords.contains("exaggerating")) {
      gaslight = true;
    }
    if (lastWords.contains("joke")) {
      gaslight = true;
    }
    if (lastWords.contains("joking")) {
      gaslight = true;
    }
    if (lastWords.contains("take a joke")) {
      gaslight = true;
    }
    if (lastWords.contains("stop taking")) {
      gaslight = true;
    }
    if (lastWords.contains("your being")) {
      gaslight = true;
    }
    if (lastWords.contains("the problem is you")) {
      gaslight = true;
    }
    if (lastWords.contains("you are")) {
      gaslight = true;
    }
    if (lastWords.contains("that wasn't my")) {
      gaslight = true;
    }
    if (lastWords.contains("i think you")) {
      gaslight = true;
    }
    if (lastWords.contains("just forget")) {
      gaslight = true;
    }
    if (lastWords.contains("stop making")) {
      gaslight = true;
    }
    // if (lastWords.contains("")) {
    //   gaslight = true;
    // }


    ///end of gaslighing ai
    

    if (meanness == 0){

    }else {
      print(meanness);
    }


    //end of AI

    return Column(
      children: <Widget>[
        Center(
          child: Column(
            children: [
              mean ? const Text("Passive aggresive or mean") : const Text(""),
              gaslight ? const Text("Gaslighting") : const Text(""),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                color: Theme.of(context).selectedRowColor,
                child: Center(
                  child: Text(
                    lastWords,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(height: 20),
    );
  }
}

/// Display the current error status from the speech
/// recognizer
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.lastError,
  }) : super(key: key);

  final String lastError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Center(
          child: Text(
            'Error Status',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        Center(
          child: Text(lastError),
        ),
      ],
    );
  }
}

/// Controls to start and stop speech recognition
class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(this.hasSpeech, this.isListening,
      this.startListening, this.stopListening, this.cancelListening,
      {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final bool isListening;
  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: !hasSpeech || isListening ? null : startListening,
          child: const Text('Start'),
        ),
        TextButton(
          onPressed: isListening ? stopListening : null,
          child: const Text('Stop'),
        ),
      ],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget(this.currentLocaleId, this.switchLang,
      this.localeNames, this.logEvents, this.switchLogging,
      {Key? key})
      : super(key: key);

  final String currentLocaleId;
  final void Function(String?) switchLang;
  final void Function(bool?) switchLogging;
  final List<LocaleName> localeNames;
  final bool logEvents;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: const [],
          ),
          Row(
            children: const [],
          )
        ],
      ),
    );
  }
}

class InitSpeechWidget extends StatelessWidget {
  const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key? key})
      : super(key: key);

  final bool hasSpeech;
  final Future<void> Function() initSpeechState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: hasSpeech ? null : initSpeechState,
          child: const Text('Initialize'),
        ),
      ],
    );
  }
}

/// Display the current status of the listener
class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({
    Key? key,
    required this.speech,
  }) : super(key: key);

  final SpeechToText speech;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: speech.isListening
            ? const Text(
                "I'm listening...",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : const Text(
                'Not listening',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
