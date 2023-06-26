import 'package:comic_cabinet/utils/constants.dart';
import 'package:flutter/material.dart';

class TabIcon extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData iconData;
  final VoidCallback callback;
  const TabIcon({
    super.key,
    required this.label,
    required this.isActive,
    required this.iconData,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          Icon(
            iconData,
            color: isActive ? Colors.black : green,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.black : green,
            ),
          ),
        ],
      ),
    );
  }
}

abstract class ITabIconView {
  Widget render(
    String label,
    bool isActive,
    IconData iconData,
    VoidCallback callback,
  );
}

class TabIconView implements ITabIconView {
  @override
  Widget render(
    String label,
    bool isActive,
    IconData iconData,
    VoidCallback callback,
  ) {
    return TabIcon(
      label: label,
      isActive: isActive,
      iconData: iconData,
      callback: callback,
    );
  }
}
