import 'dart:developer';

import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';

class ESewaScreen extends StatefulWidget {
  const ESewaScreen({super.key});

  @override
  State<ESewaScreen> createState() => _ESewaScreenState();
}

class _ESewaScreenState extends State<ESewaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "e-Sewa",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: IconButton(
          icon: const Icon(
            Icons.money,
            size: 50,
          ),
          onPressed: () {
            try {
              EsewaFlutterSdk.initPayment(
                esewaConfig: EsewaConfig(
                  environment: Environment.test,
                  clientId:
                      "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
                  secretId: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
                ),
                esewaPayment: EsewaPayment(
                  productId: "000123roh",
                  productName: "test Purpose",
                  productPrice: "100",
                  // callbackUrl:
                  // paymentModel.paymentCredentials!.esewaCallbackUrl,
                  // ebpNo: paymentModel.transactionId,
                ),
                onPaymentSuccess: (EsewaPaymentSuccessResult data) {
                  // onSuccess(data);

                  log(" Payment Successful");
                  log(data.totalAmount);
                  log(data.refId);
                },
                onPaymentFailure: (data) {
                  log("Payment Failed");
                },
                onPaymentCancellation: (data) {
                  debugPrint(":::CANCELLATION::: => $data");
                  log("Payment cancelled"); // showToast(msg: "Payment cancelled");
                },
              );
            } on Exception catch (e) {
              debugPrint("EXCEPTION : ${e.toString()}");
            }
          },
        ),
      ),
    );
  }
}
