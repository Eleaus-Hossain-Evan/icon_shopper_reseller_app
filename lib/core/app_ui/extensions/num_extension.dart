part of 'extensions.dart';

extension PaddingExt on num {
  EdgeInsetsGeometry get padding => EdgeInsetsDirectional.all(toDouble());
  EdgeInsetsGeometry get paddingHorizontal =>
      EdgeInsetsDirectional.symmetric(horizontal: toDouble());
  EdgeInsetsGeometry get paddingVertical =>
      EdgeInsetsDirectional.symmetric(vertical: toDouble());
  EdgeInsetsGeometry get paddingStart =>
      EdgeInsetsDirectional.only(start: toDouble());
  EdgeInsetsGeometry get paddingEnd =>
      EdgeInsetsDirectional.only(end: toDouble());
  EdgeInsetsGeometry get paddingTop =>
      EdgeInsetsDirectional.only(top: toDouble());
  EdgeInsetsGeometry get paddingBottom =>
      EdgeInsetsDirectional.only(bottom: toDouble());
}

extension PaddingTupleExt on (num, num) {
  EdgeInsetsGeometry get padding => EdgeInsetsDirectional.symmetric(
        horizontal: $1.toDouble(),
        vertical: $2.toDouble(),
      );
}

extension PaddingQuadTupleExt on (num, num, num, num) {
  EdgeInsetsGeometry get padding => EdgeInsetsDirectional.fromSTEB(
        $1.toDouble(),
        $2.toDouble(),
        $3.toDouble(),
        $4.toDouble(),
      );
}

extension NumberConverter on num {
  String toWeightString() {
    if (this < 1) {
      return '${(this * 1000).toStringAsFixed(0)} gm';
    } else {
      return '${toStringAsFixed(0)} kg';
    }
  }
}
