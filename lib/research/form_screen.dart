import 'package:flutter/material.dart';

class NewForm extends StatefulWidget {
  final String content;
  const NewForm({
    super.key,
    required this.content,
  });

  @override
  State<NewForm> createState() => _NewFormState();
}

class _NewFormState extends State<NewForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Form New",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
            child: Column(
          children: [
            Text(
              widget.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        )),
      ),
    );
  }
}
