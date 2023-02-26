import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();

  String description = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                ),
                keyboardType: TextInputType.text,
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Need to enter a description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Container(
                      width: 300,
                      height: 180,
                      decoration: BoxDecoration(border: Border.all(width: 1), color: Colors.grey),
                      alignment: Alignment.center,
                      // _storedImage != null
                      //     ? Image.file(_storedImage as File,
                      //         fit: BoxFit.cover, width: double.infinity)
                      //     : const Text('No Image Taken', textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 0, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.camera),
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.photo_size_select_actual_rounded),
                            ),
                            Spacer(),
                            ElevatedButton(
                              onPressed: () => {},
                              child: Text('Post'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
