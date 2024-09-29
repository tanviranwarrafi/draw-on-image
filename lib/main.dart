import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial/screen_craft.dart';
import 'package:tutorial/services/providers.dart';
import 'package:tutorial/tutorial_app.dart';

import 'di.dart' as dependency_injection;

Future<void> main() async {
  await dependency_injection.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: providers, child: _screenCraft()));
}

Widget _screenCraft() => ScreenCraft(builder: (context, orientation) => TutorialApp());
