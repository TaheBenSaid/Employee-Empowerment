import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../../domain/entities/post.dart';
import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  List<double> _sliderValues = [1.0, 1.0, 1.0, 1.0]; // Slider values for each section
  final int sectionCount = 4; // Number of sections to duplicate

  @override
  void initState() {
    super.initState();
    _titleController.text = _getCurrentDate();
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            TextFormFieldWidget(
              name: "Title",
              multiLines: false,
              controller: _titleController,
            ),
            SizedBox(height: 10),
            for (int i = 0; i < sectionCount; i++) buildSection(i),
            SizedBox(height: 10),
            TextFormFieldWidget(
              name: "Body",
              multiLines: true,
              controller: _bodyController,
            ),
            SizedBox(height: 10),
            FormSubmitBtn(
              isUpdatePost: widget.isUpdatePost,
              onPressed: validateFormThenUpdateOrAddPost,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(int index) {
    String sectionTitle;
    switch (index) {
      case 0:
        sectionTitle = 'Happiness';
        break;
      case 1:
        sectionTitle = 'Personal Motivations';
        break;
      case 2:
        sectionTitle = 'Company Motivations';
        break;
      case 3:
        sectionTitle = 'Relationships';
        break;
      default:
        sectionTitle = '';
    }

    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          sectionTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Slider(
          value: _sliderValues[index],
          onChanged: (newValue) {
            setState(() {
              _sliderValues[index] = newValue;
            });
          },
          min: 1.0,
          max: 5.0,
          divisions: 4,
          label: _sliderValues[index].toString(),
        ),
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Additional Field',
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final post = Post(
        id: widget.isUpdatePost ? widget.post!.id : null,
        title: _titleController.text,
        body: _bodyController.text,
      );

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
