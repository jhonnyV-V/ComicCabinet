import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final bool isLoading;
  final Widget? child;
  const Loader({
    super.key,
    required this.isLoading,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (child != null) {
      return child!;
    }
    return const SizedBox.shrink();
  }
}
