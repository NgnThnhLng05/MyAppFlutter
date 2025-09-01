// Widget
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildButtonMenu({
  required String label,
  required VoidCallback onPressed,
}) {
  return Container(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.yellow.shade100,
        padding: EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 18),
      ),
      onPressed: onPressed,
      child: Text(label),
    ),
  );
}
enum InputType { text, number, textAndNumber }

Widget buildTextField({
  required String label,
  required TextEditingController controller,
  required InputType inputType,
  String? Function(String?)? extraValidator, // validator riêng cho SBD
}) {
  // Chọn bàn phím
  final keyboard = inputType == InputType.number
      ? TextInputType.number
      : TextInputType.text;

  // Chọn bộ lọc ký tự
  final formatters = <TextInputFormatter>[
    // if (inputType == InputType.number)
    //   FilteringTextInputFormatter.digitsOnly
    // else if (inputType == InputType.text)
    //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))
    // else if (inputType == InputType.textAndNumber)
    //     FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
    // Dung ep buoc ko hien thong bao
  ];

  return TextFormField(
    controller: controller,
    keyboardType: keyboard,
    inputFormatters: formatters,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.yellow.shade100,
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return "$label không được để trống";
      }

      // Kiểm tra định dạng
      if (inputType == InputType.number && !RegExp(r'^\d+$').hasMatch(value.trim())) {
        return "$label chỉ được nhập số";
      }
      if (inputType == InputType.text && !RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
        return "$label chỉ được nhập chữ";
      }
      if (inputType == InputType.textAndNumber && !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value.trim())) {
        return "$label chỉ được chứa chữ và số";
      }

      // Kiểm tra validator riêng (ví dụ: trùng SBD)
      if (extraValidator != null) {
        return extraValidator(value);
      }

      return null;
    },
  );
}
