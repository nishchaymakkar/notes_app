import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
        margin: const EdgeInsets.only(left: 25,right: 25, top:10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("DarkMode",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),),
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
                onChanged: (value) => Provider.of<ThemeProvider>(context,listen: false).toggleTheme())
          ],
        ),
      ) ,
    );
  }
}
