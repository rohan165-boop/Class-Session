import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class CustomPDFViewer extends StatefulWidget {
  const CustomPDFViewer({super.key});

  @override
  State<CustomPDFViewer> createState() => _CustomPDFViewerState();
}

class _CustomPDFViewerState extends State<CustomPDFViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("PDF Viewer",
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: PdfViewer(
        document: PdfDocument.openUri(Uri.parse("")),
      ),
    );
  }
}
