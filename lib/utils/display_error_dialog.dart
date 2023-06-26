import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? tryAgain;
  const ErrorDialog({
    super.key,
    required this.errorMessage,
    this.tryAgain,
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
        ),
        tryAgain != null
            ? ElevatedButton(
                onPressed: tryAgain,
                child: const Text('Try again'),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

abstract class IShowErrorDialog {
  Widget render(String errorMessage, [VoidCallback? tryAgain]);
}

class ShowErrorDialog implements IShowErrorDialog {
  @override
  Widget render(String errorMessage, [VoidCallback? tryAgain]) {
    return ErrorDialog(
      errorMessage: errorMessage,
      tryAgain: tryAgain,
    );
  }
}
