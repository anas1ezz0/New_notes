import 'package:flutter/material.dart';

import '../../const/const.dart';
import 'package:notes_app/widgets/home_widget/notes_view_body.dart';
import 'package:notes_app/widgets/bottom_sheet_widget/add_note_bottomsheet.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                )),
                context: context,
                builder: (context) {
                  return const AddNoteBottomSheet();
                });
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          )),
      body: const SafeArea(
        child: NotesViewBody(),
      ),
    );
  }
}
