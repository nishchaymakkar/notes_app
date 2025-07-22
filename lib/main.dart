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
       TextTheme textTheme = createTextTheme(context, 'Roboto', 'Roboto');
      final themeProvider = Provider.of<ThemeProvider>(context);
     ThemeData theme(ColorScheme colorScheme) => ThemeData(
       useMaterial3: true,
       brightness: colorScheme.brightness,
       colorScheme: colorScheme,
       textTheme: textTheme.apply(
         bodyColor: colorScheme.onSurface,
         displayColor: colorScheme.onSurface,
       ),
       scaffoldBackgroundColor: colorScheme.surface,
       canvasColor: colorScheme.surface,
     );
       return MaterialApp(
         debugShowCheckedModeBanner: false,
         themeMode: themeProvider.themeMode,
          theme: theme(MaterialTheme.lightScheme()),
          darkTheme: theme(MaterialTheme.darkScheme()),
         home:const NotesPage(),

       );
  }
}


