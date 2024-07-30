import 'package:haruviet/component/input/widgets/masked_input_formator.dart';
import 'package:haruviet/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatefulWidget {
  CustomTextInput(
      {super.key,
      required this.hintTextString,
      this.textEditController,
      required this.inputType,
      this.enableBorder = true,
      this.themeColor,
      this.cornerRadius,
      this.isCheckPadding = false,
      this.isNotPrefixIcon = false,
      this.isNotLabelText = false,
      this.suffixIcon,
      this.isNotValidate = false,
      this.maxLength,
      this.padding,
      this.prefixIcon,
      this.textColor,
      this.isAutofocus = false,
      this.errorMessage,
      this.maxLines,
      this.focusNode,
      required this.onChanged,
      this.labelText});

  // ignore: prefer_typing_uninitialized_variables
  final hintTextString;
  final bool isAutofocus;

  final TextEditingController? textEditController;
  final InputType inputType;
  void Function(String) onChanged;
  final bool enableBorder;
  final Color? themeColor;
  final double? cornerRadius;
  final int? maxLength;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? textColor;
  final String? errorMessage;
  final bool isNotLabelText;
  final String? labelText;
  final bool isCheckPadding;
  final EdgeInsetsGeometry? padding;
  final bool isNotPrefixIcon;
  final int? maxLines;
  final bool isNotValidate;
  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

// input text state
class _CustomTextInputState extends State<CustomTextInput> {
  bool _isValidate = true;
  String validationMessage = '';
  bool visibility = false;
  int oldTextSize = 0;
  final _inputController = TextEditingController();

  // build method for UI rendering
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isCheckPadding
          ? widget.padding!
          : const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        maxLines: widget.maxLines,
        autofocus: widget.isAutofocus,
        textAlign: TextAlign.start,
        controller: _inputController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: colorGray03,
          ),
          hintText: widget.hintTextString as String,
          hintMaxLines: 1,
          errorText: widget.isNotValidate
              ? null
              : _isValidate
                  ? null
                  : validationMessage,
          counterText: '',
          border: getBorder(),
          enabledBorder: widget.enableBorder ? getBorder() : InputBorder.none,
          focusedBorder: widget.enableBorder ? getBorder() : InputBorder.none,
          labelText: widget.isNotLabelText
              ? null
              : widget.labelText ?? widget.hintTextString as String,
          labelStyle: getTextStyle(),
          prefixIcon: widget.isNotPrefixIcon
              ? null
              : widget.prefixIcon ?? getPrefixIcon(),
          suffixIcon: widget.suffixIcon ?? getSuffixIcon(),
        ),
        onChanged: widget.onChanged,
        keyboardType: getInputType(),
        obscureText: widget.inputType == InputType.Password && !visibility,
        maxLength: widget.inputType == InputType.PaymentCard
            ? 19
            : widget.maxLength ?? getMaxLength(),
        style: TextStyle(
          color: widget.textColor ?? Colors.black,
        ),
        inputFormatters: [getFormatter()],
      ),
    );
  }

  //get border of textinput filed
  OutlineInputBorder getBorder() {
    return OutlineInputBorder(
      borderRadius:
          BorderRadius.all(Radius.circular(widget.cornerRadius ?? 12.0)),
      borderSide: BorderSide(
          width: 1, color: widget.themeColor ?? Theme.of(context).primaryColor),
      gapPadding: 2,
    );
  }

  // formatter on basis of textinput type
  TextInputFormatter getFormatter() {
    if (widget.inputType == InputType.PaymentCard) {
      return MaskedTextInputFormatter(
        mask: 'xxxx xxxx xxxx xxxx',
        separator: ' ',
      );
    } else {
      return TextInputFormatter.withFunction((oldValue, newValue) => newValue);
    }
  }

  // text style for textinput
  TextStyle getTextStyle() {
    return TextStyle(fontSize: 14, color: widget.themeColor ?? colorGray03);
  }

  // input validations
  void checkValidation(String textFieldValue) {
    if (widget.inputType == InputType.Default) {
      //default
      _isValidate = textFieldValue.isNotEmpty;
      validationMessage = widget.errorMessage ?? 'Filed cannot be empty';
    } else if (widget.inputType == InputType.Email) {
      //email validation
      _isValidate = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Email is not valid';
    } else if (widget.inputType == InputType.Number) {
      //contact number validation
      _isValidate = textFieldValue.length == widget.maxLength;
      validationMessage = widget.errorMessage ?? 'Contact Number is not valid';
    } else if (widget.inputType == InputType.Password) {
      //password validation
      _isValidate = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
          .hasMatch(textFieldValue);
      validationMessage = widget.errorMessage ?? 'Password is not valid';
    } else if (widget.inputType == InputType.PaymentCard) {
      //payment card validation
      _isValidate = textFieldValue.length == 19;
      validationMessage = widget.errorMessage ?? 'Card number is not correct';
    }
    oldTextSize = textFieldValue.length;
    //change value in state
    setState(() {});
  }

  // return input type for setting keyboard
  TextInputType getInputType() {
    switch (widget.inputType) {
      case InputType.Default:
        return TextInputType.text;
        break;

      case InputType.Email:
        return TextInputType.emailAddress;
        break;

      case InputType.Number:
        return TextInputType.number;
        break;

      case InputType.PaymentCard:
        return TextInputType.number;
        break;

      default:
        return TextInputType.text;
        break;
    }
  }

  // get max length of text
  int getMaxLength() {
    switch (widget.inputType) {
      case InputType.Default:
        return 36;
        break;

      case InputType.Email:
        return 36;
        break;

      case InputType.Number:
        return 10;
        break;

      case InputType.Password:
        return 24;
        break;

      case InputType.PaymentCard:
        return 19;
        break;

      default:
        return 36;
        break;
    }
  }

  // get prefix Icon
  Icon getPrefixIcon() {
    switch (widget.inputType) {
      case InputType.Default:
        return Icon(
          Icons.person,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );
        break;

      case InputType.Email:
        return Icon(
          Icons.email,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );
        break;

      case InputType.Number:
        return Icon(
          Icons.phone,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );
        break;

      case InputType.Password:
        return Icon(
          Icons.lock,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );
        break;

      case InputType.PaymentCard:
        return Icon(
          Icons.credit_card,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );
        break;

      default:
        return Icon(
          Icons.person,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        );
        break;
    }
  }

  // get suffix icon
  Widget getSuffixIcon() {
    if (widget.inputType == InputType.Password) {
      return IconButton(
        onPressed: () {
          visibility = !visibility;
          setState(() {});
        },
        icon: Icon(
          visibility ? Icons.visibility : Icons.visibility_off,
          color: widget.themeColor ?? Theme.of(context).primaryColor,
        ),
      );
    } else {
      return const Opacity(opacity: 0, child: Icon(Icons.phone));
    }
  }
}

//input types
enum InputType { Default, Email, Number, Password, PaymentCard }
