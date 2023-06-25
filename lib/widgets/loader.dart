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

abstract class ILoaderDisplay {
  Widget render(bool isLoading, Widget? child);
}

class LoaderDisplay implements ILoaderDisplay {
  @override
  Widget render(bool isLoading, [Widget? child]) {
    return Loader(
      isLoading: isLoading,
      child: child,
    );
  }
}
