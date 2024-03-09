import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubtits/addnote_cubit/add_notes_cubit.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/widgets/bottom_sheet_widget/colors_listview.dart';
import 'package:notes_app/widgets/bottom_sheet_widget/custom_botton.dart';
import 'package:notes_app/widgets/bottom_sheet_widget/custom_textformfield.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key});

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  String? title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              onSave: (value) {
                title = value;
              },
              hint: 'Title',
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              onSave: (value) {
                subtitle = value;
              },
              hint: 'Content',
              maxLines: 5,
            ),
            const SizedBox(
              height: 16,
            ),
            const ColorItemListView(),
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<AddNotesCubit, AddNotesState>(
              builder: (context, state) {
                return CustomButton(
                  // isLoading: true,
                  isLoading: state is AddNotesLoading ? true : false,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      var currentDate = DateTime.now();
                      var formattedDate =
                          DateFormat('dd-MM-yyyy').format(currentDate);
                      var noteModel = NoteModel(
                          title: title!,
                          subtitle: subtitle!,
                          date: formattedDate,
                          color: Colors.teal.value);
                      BlocProvider.of<AddNotesCubit>(context)
                          .addNotes(noteModel);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
