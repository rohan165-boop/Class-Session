// import 'dart:io';

// import 'package:flutter/material.dart';
// // import 'package:pdf_render/pdf_render.dart' as doc;
// // import 'package:pdf_render/pdf_render_widgets.dart';
// import 'package:http/http.dart' as http;
// // import 'package:pdfrx/pdfrx.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdfrx/pdfrx.dart';

// class CustomPDFViewer extends StatefulWidget {
//   const CustomPDFViewer({super.key});

//   @override
//   State<CustomPDFViewer> createState() => _CustomPDFViewerState();
// }

// class _CustomPDFViewerState extends State<CustomPDFViewer> {
//   // late doc.PdfDocument _document;
//   final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(true);

//   @override
//   void initState() {
//     super.initState();
//     // _loadDocument();
//   }

//   // Future<void> _loadDocument() async {
//   //   // if (widget.pdfArgModel.isLocal) {
//   //   //   _document = await doc.PdfDocument.openFile(
//   //   //       widget.pdfArgModel.contentBySlugModel.pdf!.path!);
//   //   // } else {
//   //   final response = await http.get(Uri.parse(
//   //       "https://dev.fileswarehouse.com/e2p2/medias/Beekeeping---Wikipedia-1.pdf?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=QGIUS14H222LVH8T52WN%2F20231213%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Date=20231213T081250Z&X-Amz-SignedHeaders=host&X-Amz-Expires=554530&X-Amz-Signature=07013f2858053202ae17191a844b09bc69b0f3b89da2ef77bcb5c57a07f16f06"));
//   //   final bytes = response.bodyBytes;

//   //   final dir = await getTemporaryDirectory();
//   //   final file = File('${dir.path}/document.pdf');
//   //   await file.writeAsBytes(bytes);

//   //   _document = await doc.PdfDocument.openFile(file.path);
//   //   _isLoading.value = true;
//   //   // }
//   //   // _isLoading.value = false;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: Text("PDF Viewer",
//             style: Theme.of(context).textTheme.headlineSmall),
//       ),
//       body: PdfViewer(
//         document: PdfDocument.openUri(
//           Uri.parse(
//               "https://dev.fileswarehouse.com/e2p2/medias/Beekeeping---Wikipedia-1.pdf?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=QGIUS14H222LVH8T52WN%2F20231213%2Fus-west-1%2Fs3%2Faws4_request&X-Amz-Date=20231213T081250Z&X-Amz-SignedHeaders=host&X-Amz-Expires=554530&X-Amz-Signature=07013f2858053202ae17191a844b09bc69b0f3b89da2ef77bcb5c57a07f16f06"),
//         ),
//       ),
//     );
//   }
// }
