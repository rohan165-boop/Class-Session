// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:p_1/research/form_screen.dart';

class TextResearchScreen extends StatefulWidget {
  const TextResearchScreen({super.key});

  @override
  State<TextResearchScreen> createState() => _TextResearchScreenState();
}

class _TextResearchScreenState extends State<TextResearchScreen> {
  SelectedContent? _selectedcontent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Text Reseearch",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SelectionArea(
            onSelectionChanged: (value) {
              setState(() {
                _selectedcontent = value;
              });
              log(value?.plainText ?? '');
            },
            contextMenuBuilder: (context, selectableRegionState) {
              return AdaptiveTextSelectionToolbar.buttonItems(
                  anchors: selectableRegionState.contextMenuAnchors,
                  buttonItems: [
                    ContextMenuButtonItem(
                      type: ContextMenuButtonType.selectAll,
                      label: "Select All",
                      onPressed: () {
                        selectableRegionState
                            .selectAll(SelectionChangedCause.toolbar);
                      },
                    ),
                    ContextMenuButtonItem(
                      label: "Comment",
                      type: ContextMenuButtonType.custom,
                      onPressed: () {
                        // ContextMenuController.removeAny();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewForm(
                                      content:
                                          _selectedcontent?.plainText ?? '',
                                    )));
                      },
                    ),
                  ]);
            },
            child: const Text(
              "DISCLAIMER: These example sentences appear in various news sources and books to reflect the usage of the word ‘content'. Views expressed in the examples do not represent the opinion of Vocabulary.com or its editors. Send us feedback \n\nBut every one of us, except the Negroes forced here as slaves, are descended from the restless ones, the wayward ones who were not content to stay at home.",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
