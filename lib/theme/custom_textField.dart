import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function validator;
  final FocusNode focusNode;
  final Function function;
  final Size size;
  final String hintText;
  final TextInputType type;
  final IconData? prefix;
  final IconButton? suffix;
  final bool obscureText;

  const CustomTextField({
    required this.focusNode,
    required this.size,
    required this.function,
    required this.hintText,
    required this.prefix,
    this.suffix,
    required this.type,
    required this.validator,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 12,
      child: TextFormField(
        focusNode: focusNode,
        obscureText: obscureText,
        onChanged: (value) => function(value),
        validator: (value) => validator(value),
        cursorColor: const Color(0xFF11253d),
        keyboardType: type,
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(0xFF11253d),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          fillColor: Colors.grey[200],
          filled: true,

          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  prefix,
                  color: const Color(0xFF11253d),
                ),
                const SizedBox(
                  width: 16,
                ),
                //divider svg
              ],
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color:  Color(0xFF11253d),
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
