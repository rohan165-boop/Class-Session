import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiScreen extends StatefulWidget {
  const KhaltiScreen({super.key});

  @override
  State<KhaltiScreen> createState() => _KhaltiScreenState();
}

class _KhaltiScreenState extends State<KhaltiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Khalti",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: IconButton(
          icon: const Icon(
            Icons.money,
            size: 100,
          ),
          onPressed: () {
            final config = PaymentConfig(
              amount: 10000, // Amount should be in paisa
              productIdentity: 'roh_an_645',
              productName: 'roh_an_645',
              // productUrl: 'https://www.khalti.com/#/bazaar',
              additionalData: {
                // Not mandatory; can be used for reporting purpose
                'vendor': 'Rohan Test',
              },
            );
            KhaltiScope.of(context).pay(
              config: config,
              preferences: [
                PaymentPreference.khalti,
              ],
              onSuccess: (PaymentSuccessModel model) {
                log("Payment Success");
                log("${model.amount}");
                log(model.idx);
              },
              onFailure: (PaymentFailureModel model) {
                log("Payment Failed");
              },
            );
          },
        ),
      ),
    );
  }
}
