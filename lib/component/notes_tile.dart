import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'note_settings.dart';

class NotesTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  const NotesTile({super.key,required this.text, required this.onEditPressed, required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: const EdgeInsets.only(top: 10,left: 25,right: 25),
      child: ListTile(
        title: Text(text),
        trailing: Builder(builder: (context)=> IconButton(
            onPressed: ()=>
                showPopover(
                    width: 100,
                    height: 100,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    context: context,
                    bodyBuilder: (context) => NoteSettings(onEditPressed: onEditPressed,onDeletePressed: onDeletePressed,)
                ),
            icon:  Icon( Icons.more_vert)))
      ),
    );
  }
}
