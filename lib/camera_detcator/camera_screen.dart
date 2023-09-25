// import 'dart:typed_data';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraDescription camera;

//   late CameraController _controller;
//   bool isDetecting = false;

//   List<dynamic>? recognitions;
//   Interpreter? interpreter;

//   @override
//   void initState() {
//     getCamera();
//     super.initState();
//   }

//   void getCamera() async {
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;
//     _controller = CameraController(firstCamera, ResolutionPreset.medium);
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//       _controller.startImageStream((CameraImage image) {
//         if (!isDetecting) {
//           isDetecting = true;
//           // Implement object detection logic here
//           // You may use TensorFlow Lite or other libraries
//           // Update the UI based on the detection results
//           isDetecting = false;
//           _runObjectDetection(image);
//         }
//       });
//     });
//   }

//   Future<void> loadModel() async {
//     final interpreterOptions = InterpreterOptions()
//       ..useNnApiForAndroid =
//           true; // Use NNAPI for better performance on Android

//     interpreter = await Interpreter.fromAsset('assets/model.tflite',
//         options: interpreterOptions);
//   }

//   Future<void> _runObjectDetection(CameraImage image) async {
//     final tfliteFlutterPlugin = TfliteFlutterPlugin.instance();
//     final tfliteFlutterHelperPlugin = TfliteFlutterHelperPlugin();

//     if (tfliteFlutterPlugin.interpreter == null) {
//       return;
//     }

//     final inputWidth = image.width;
//     final inputHeight = image.height;
//     final inputChannels = 3; // Assuming a model that uses RGB channels

//     // Preprocess the image data (convert to byte buffer, normalize, etc.) as required by your model
//     final inputImageData = preprocessImageData(image);

//     // Create a TensorImage from the preprocessed image data
//     final inputTensor = TensorImage.fromTensorBuffer(inputImageData);

//     // Run inference using the interpreter
//     final outputs = await tfliteFlutterPlugin.run(inputTensor);

//     // Process the detection results from the output tensor(s)
//     final detections = outputs[
//         yourOutputTensorName]; // Replace with the actual output tensor name

//     // Implement logic to post-process the detection results (e.g., apply confidence threshold)
//     final filteredDetections = postProcessDetections(detections);

//     // Store the filtered detections in the recognitions list
//     setState(() {
//       recognitions = filteredDetections;
//     });

//     isDetecting = false;
//   }

// // Implement preprocessing logic to prepare the camera image for inference
//   TensorBuffer preprocessImageData(CameraImage image) {
//     // Implement your preprocessing logic here
//     // Convert the CameraImage to the required format and normalize pixel values
//     // Return the preprocessed image data as a ByteBuffer
//     return TensorBuffer.createFixedSize(2, 2);
//   }

// // Implement post-processing logic to filter and format detection results
//   List<dynamic> postProcessDetections(TensorBuffer detections) {
//     // Implement your post-processing logic here
//     // Convert the output TensorBuffer to a format suitable for your use case
//     // Example:
//     final filteredDetections = <dynamic>[];
//     // Iterate through the detections and format them
//     // ...
//     return filteredDetections;
//   }

//   // Function to calculate scaling factor based on object size
//   double calculateScalingFactor(Size screenSize, Size imageSize) {
//     // You can adjust the scaling factor as needed
//     final maxWidth = screenSize.width;
//     final maxHeight = screenSize.height;

//     final widthFactor = maxWidth / imageSize.width;
//     final heightFactor = maxHeight / imageSize.height;

//     // Choose the minimum scaling factor to fit the entire object within the screen
//     return widthFactor < heightFactor ? widthFactor : heightFactor;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     interpreter?.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       body: (!_controller.value.isInitialized)
//           ? const Center(
//               child: CircularProgressIndicator.adaptive(),
//             )
//           : SafeArea(
//               child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   /// Camera
//                   CameraPreview(_controller),

//                   /// BoX For Camera
//                   // Display object detection results with dynamically adjusted bounding boxes
//                   if (recognitions != null)
//                     ...recognitions!.map((recognition) {
//                       final rect = recognition['rect'] as Map<String, dynamic>;
//                       final left = rect['left'] as double;
//                       final top = rect['top'] as double;
//                       final width = rect['width'] as double;
//                       final height = rect['height'] as double;

//                       // Calculate the scaling factor based on object size
//                       final scaleFactor = calculateScalingFactor(
//                           screenSize, Size(width, height));

//                       // Scale the bounding box dimensions
//                       final scaledWidth = width * scaleFactor;
//                       final scaledHeight = height * scaleFactor;

//                       // Scale the bounding box position
//                       final scaledLeft = left * scaleFactor;
//                       final scaledTop = top * scaleFactor;

//                       return Positioned(
//                         left: scaledLeft,
//                         top: scaledTop,
//                         width: scaledWidth,
//                         height: scaledHeight,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Colors.red,
//                               width: 2.0,
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               '${recognition['detectedClass']} ${(recognition['confidence'] * 100).toStringAsFixed(2)}%',
//                               style: TextStyle(
//                                 background: Paint()..color = Colors.red,
//                                 color: Colors.white,
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),

//                   /// Back Button
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             )),
//     );
//   }
// }
