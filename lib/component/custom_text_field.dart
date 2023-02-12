import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hint;
  final String? hintText;
  final String? labelText;
  final String? counterText;
  final double? radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool obscureText;
  final bool? isOutlineBorder;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final double padding;
  final Color? fillColor;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool? isAuto;
  final bool? enable;
  final TextCapitalization? textCapitalization;
  final EdgeInsetsGeometry? margin;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditComplete;
  final ValueChanged<String>? onFieldSubmit;
  List<TextInputFormatter>? inputFormatters;
  final VoidCallback? callback;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;

  CustomTextFormField({
    Key? key,
    this.controller,
    this.hint,
    this.hintText,
    this.labelText,
    this.radius,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.obscureText = false,
    this.validator,
    this.padding = 10,
    this.fillColor,
    this.maxLines = 1,
    this.inputFormatters,
    this.keyboardType,
    this.maxLength,
    this.readOnly = false,
    this.counterText,
    this.onChanged,
    this.textCapitalization,
    this.isOutlineBorder,
    this.focusNode,
    this.onEditComplete,
    this.textInputAction,
    this.margin,
    this.onFieldSubmit,
    this.callback,
    this.contentPadding,
    this.isAuto,
    this.enable = true,
    this.hintStyle,
    this.labelStyle,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  var labelTextStyle = appTheme.primaryTextStyle();

  @override
  void initState() {
    widget.focusNode!.addListener(() {
      if (widget.focusNode!.hasFocus) {
        setState(() {
          labelTextStyle = appTheme.primaryTextStyle();
        });
      } else {
        setState(() {
          labelTextStyle = appTheme.boldTextStyle(size: 14);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = !(widget.enable ?? false) ? appTheme.boldTextStyle(size: 14) : appTheme.boldTextStyle(size: 14);
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      constraints: BoxConstraints(maxHeight: 80, minHeight: 50),
      child: TextFormField(
        readOnly: widget.readOnly,
        focusNode: widget.focusNode,
        controller: widget.controller,
        onTap: widget.callback,
        maxLength: widget.maxLength,
        enabled: widget.enable,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          counterText: widget.counterText,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: widget.prefixIcon,
                )
              : null,
          suffixIcon: widget.suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: (10)),
                  child: widget.suffixIcon,
                )
              : null,
          alignLabelWithHint: false,
          focusedErrorBorder: (widget.isOutlineBorder ?? true)
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.redColor, width: 2.0),
                  borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: appTheme.redColor, width: 2.0),
                ),
          focusedBorder: (widget.isOutlineBorder ?? true)
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.colorPrimary, width: 2.0),
                  borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: appTheme.colorPrimary, width: 2.0),
                ),
          enabledBorder: (widget.isOutlineBorder ?? true)
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.textFieldBorder, width: 2.0),
                  borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: appTheme.textFieldBorder, width: 2.0),
                ),
          errorBorder: (widget.isOutlineBorder ?? true)
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.redColor, width: 2.0),
                  borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: appTheme.redColor, width: 2.0),
                ),
          disabledBorder: (widget.isOutlineBorder ?? true)
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme.textFieldBorder, width: 2.0),
                  borderRadius: BorderRadius.circular(widget.radius ?? 30.0),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: appTheme.textFieldBorder, width: 2.0),
                ),
          // helperText: " ",
          filled: true,
          fillColor: widget.fillColor ?? Colors.transparent,
          contentPadding: widget.contentPadding ?? const EdgeInsets.only(left: 23, right: 3, top: 14, bottom: 14),
          errorStyle: const TextStyle(fontSize: 11, height: 0.5),
          isDense: true,
          hintText: widget.hintText,
          floatingLabelBehavior: (widget.isAuto ?? true) ? FloatingLabelBehavior.auto : FloatingLabelBehavior.always,
          hintStyle: widget.hintStyle ?? appTheme.primaryTextStyle(size: 14),
          labelText: widget.labelText,
          labelStyle: widget.labelStyle ?? labelTextStyle,
        ),
        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
        style: widget.style ?? textStyle,
        obscureText: widget.obscureText,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditComplete,
        onFieldSubmitted: widget.onFieldSubmit,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
