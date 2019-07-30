import 'dart:async';
import 'dart:math';

import 'package:flutter_web/material.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final StreamController _streamController = StreamController();
  AnimationController _animationController;
  Timer _timer;
  static const List<String> _textes = [
    "Mines de St-Etienne ISMIN 👨‍🎓",
    "Français 🇫🇷",
    "Arduino, Teensy 🤖",
    "Dart 🎯",
    "Flutter Web and Android 🚀",
    "GNU/Linux and Windows 🐧",
    "C, C++, Shell 👨‍💻",
    "Docker 📦",
    "DevOps ⚙️",
    "Gitlab CI 🔧",
  ];
  static const animationDuration = Duration(milliseconds: 100);
  static const refreshDuration = Duration(seconds: 2);
  var randomizer = Random();

  void _randomText() async {
    _animationController.reverse();
    await Future.delayed(animationDuration);
    _animationController.forward();
    setState(() => _streamController.sink
        .add(_textes[randomizer.nextInt(_textes.length)]));
  }

  @override
  void initState() {
    super.initState();
    _streamController.sink.add(_textes[0]);
    _animationController =
        AnimationController(vsync: this, duration: animationDuration);
    _timer = Timer.periodic(refreshDuration, (Timer t) => _randomText());
  }

  @override
  void dispose() {
    _streamController.sink.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Hi ! I'm Marc NGUYEN",
              style: Theme.of(context).textTheme.display1,
            ),
            StreamBuilder<Object>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                Widget child;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    child = CircularProgressIndicator();
                    break;
                  case ConnectionState.active:
                    child = ShowUp(
                      child: Text(
                        '${snapshot.data}',
                        style: Theme.of(context).textTheme.title,
                      ),
                      animController: _animationController,
                    );
                    break;
                  case ConnectionState.done:
                    child = Icon(
                      Icons.check,
                      color: Colors.green,
                    );
                    break;
                }
                return child;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomText,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ShowUp extends StatefulWidget {
  final Widget child;
  final AnimationController animController;

  ShowUp({@required this.child, @required this.animController});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> {
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      curve: Curves.decelerate,
      parent: widget.animController,
    ));
    widget.animController.forward(); // Start animation
  }

  @override
  void dispose() {
    super.dispose();
    widget.animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: widget.animController,
    );
  }
}
