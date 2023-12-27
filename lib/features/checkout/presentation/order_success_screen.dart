import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/core.dart';

class OrderSuccessScreen extends HookConsumerWidget {
  static const route = '/order-success';

  const OrderSuccessScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: KAppBar(
        titleText: 'OrderSuccess',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
