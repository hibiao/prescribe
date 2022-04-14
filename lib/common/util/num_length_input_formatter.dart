import 'package:flutter/services.dart';

class NumLengthInputFormatter extends TextInputFormatter {
  final int decimalLength;
  final  int integerLength;
  final bool allowInputDecimal;

  NumLengthInputFormatter({this.decimalLength = 2, this.integerLength = 8, this.allowInputDecimal = true});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text;
    int selectionIndex = newValue.selection.end;
    if (newValue.text.contains('.')) {
      int pointIndex = newValue.text.indexOf('.');
      String beforePoint = newValue.text.substring(0, pointIndex);
      //小数点前内容大于integerLength
      if (beforePoint.length > integerLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      } else
        //小数点前内容小于等于integerLength
          {
        String afterPoint = newValue.text.substring(pointIndex + 1, newValue.text.length);
        if (afterPoint.length > decimalLength) {
          value = oldValue.text;
          selectionIndex = oldValue.selection.end;
        }
      }
    } else {
      if (newValue.text.length > integerLength) {
        value = oldValue.text;
        selectionIndex = oldValue.selection.end;
      }
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

}