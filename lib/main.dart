import 'package:flutter/material.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:notes_app/theme/theme.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:notes_app/theme/util.dart';
import 'package:provider/provider.dart';
import 'models/note_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  final textTheme = ThemeData.light().textTheme.apply(fontFamily: 'Roboto');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteDatabase()),

      ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ],
    child: const MyApp(),
     ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
   @override
  Widget build(BuildContext context) {
     final brightness = View.of(context).platformDispatcher.platformBrightness;
       TextTheme textTheme = createTextTheme(context, 'Roboto', 'Roboto');

       MaterialTheme theme = MaterialTheme(textTheme);
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         theme: brightness == Brightness.light ? theme.light() : theme.dark(),
         home:const NotesPage(),

       );
  }
}


