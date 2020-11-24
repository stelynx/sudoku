import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/admob_factory.dart';
import 'config/theme.dart';
import 'logic/game_bloc.dart';
import 'screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAdMob.instance.initialize(appId: AdMobFactory.getAppId());

  runApp(FifteenPuzzleApp());
}

class FifteenPuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Fifteen Puzzle',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      home: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: Theme.of(context).brightness == Brightness.light
              ? <Color>[
                  Colors.lightBlue[50],
                  Colors.lightBlue[200],
                ]
              : <Color>[
                  Colors.red[600],
                  Colors.black12,
                ],
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider<GameBloc>(
            create: (_) => GameBloc(),
            child: MainScreen(),
          ),
        ),
      ),
    );
  }
}
