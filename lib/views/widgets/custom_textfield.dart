import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../resources/colors_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final Function textFieldValidator;
  final Function()? onTap;
  final String customHintText;
  final TextInputType textInputType;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool isSecure;
  final bool? enableInteractiveSelection;
  final String? helperText;

  const CustomTextField(
      {super.key,
      required this.customHintText,
      required this.textFieldController,
      required this.prefixIcon,
      required this.textInputType,
      required this.isSecure,
      required this.textFieldValidator,
      this.onTap,
      this.suffixIcon,
      this.helperText,
      this.enableInteractiveSelection});
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder:
        (context, authProvider, child) {
        return TextFormField(
            enableInteractiveSelection: enableInteractiveSelection,
            onTap: onTap,
            enabled: (authProvider.isLoading == false),
            obscureText: isSecure,
            controller: textFieldController,
            validator: (value) => textFieldValidator(value),
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            cursorColor: ColorsManager.primaryMain,
            decoration: InputDecoration(
              helperText: helperText,
              hintText: customHintText,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: prefixIcon,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: suffixIcon,
              ),
            ));
      }
    );
  }
}
