import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  const ErrorDialog({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
        ),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 24,
          ),
        )
      ],
    );
  }
}

abstract class IShowErrorDialog {
  Widget render(String errorMessage);
}

class ShowErrorDialog implements IShowErrorDialog {
  @override
  Widget render(String errorMessage) {
    return ErrorDialog(
      errorMessage: errorMessage,
    );
  }
}
