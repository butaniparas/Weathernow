import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final String hinttext;
  final String? labletext;
  final bool obsecure;
  final TextInputType? keybordtype;
  final FontWeight? textweight;
  final double? textsize;
  final Color? textcolor;
  final FontWeight? lebleweight;
  final double? leblesize;
  final Color? leblecolor;
  final FontWeight? hintweight;
  final double? hintfontsize;
  final Color? hintcolor;
  final double? borderradius;
  final Color? borderColor;
  final Color? focused_borderColor;
  final FormFieldSetter<String>? onchanged;
  final FormFieldSetter<String>? onsubmitted;
  final FormFieldSetter<String>? onsaved;
  final FormFieldValidator<String>? validator;
  final String? errortext;
  final double? errorstextsize;
  final TextAlign alignment;
  final bool readonly;
  final int minlines;
  final int maxlines;
  final TextEditingController? controller;
  final Widget? suffixicon;

  const CustomTextformfield({
    required this.hinttext,
    this.labletext,
    this.keybordtype,
    required this.obsecure,
    this.textweight,
    this.textsize,
    this.textcolor,
    this.lebleweight,
    this.leblesize,
    this.leblecolor,
    this.hintweight,
    this.hintfontsize,
    this.hintcolor,
    this.borderradius,
    this.borderColor,
    this.focused_borderColor,
    this.onsaved,
    this.validator,
    this.onchanged,
    this.onsubmitted,
    this.errortext,
    this.readonly = false,
    this.controller,
    this.alignment = TextAlign.start,
    this.errorstextsize = 12,
    this.minlines=1,
    this.maxlines=1,
    this.suffixicon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keybordtype,
      obscureText: obsecure,
      onChanged: onchanged,
      onSaved: onsaved,
      onFieldSubmitted: onsubmitted,
      validator: validator,
      readOnly: readonly,
      textAlign: alignment,
      maxLines: maxlines,
      minLines: minlines,

      style: TextStyle(
          fontWeight: textweight, fontSize: textsize, color: textcolor),
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(
            fontWeight: hintweight, fontSize: hintfontsize, color: hintcolor),
        labelText: labletext,
        suffixIcon: suffixicon,
        labelStyle: TextStyle(
            fontWeight: lebleweight, fontSize: leblesize, color: leblecolor),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius!),
            borderSide: BorderSide(color: borderColor!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderradius!),
            borderSide: BorderSide(color: focused_borderColor!)),
        errorText: errortext,
        errorStyle: TextStyle(fontSize: errorstextsize, color: Colors.red),
      ),
    );
  }
}
