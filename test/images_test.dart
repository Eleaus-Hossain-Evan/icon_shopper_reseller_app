import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:icon_shopper_reseller_app/core/utils/assets/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.cart).existsSync(), isTrue);
    expect(File(Images.cod).existsSync(), isTrue);
    expect(File(Images.home).existsSync(), isTrue);
    expect(File(Images.logoSmall).existsSync(), isTrue);
    expect(File(Images.logo).existsSync(), isTrue);
    expect(File(Images.onlinePayment).existsSync(), isTrue);
    expect(File(Images.webFooter).existsSync(), isTrue);
    expect(File(Images.iconPriceList).existsSync(), isTrue);
  });
}
