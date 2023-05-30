import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

class SwitchCheckBox extends HookWidget {
  final bool isOn;
  Function(bool)? onChanged;

  SwitchCheckBox({
    Key? key,
    required this.isOn,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> _isOn = useState(isOn);
    const duration = Duration(milliseconds: 300);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTap: () {
          _isOn.value = !_isOn.value;
          onChanged?.call(_isOn.value);
        },
        child: AnimatedContainer(
          duration: duration,
          curve: Curves.easeIn,
          width: constraints.minWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: _isOn.value
                ? getColorScheme(context).colorPrimary
                : const Color(0xFFE8E8E8),
          ),
          child: AnimatedAlign(
            duration: duration,
            alignment: _isOn.value ? Alignment.centerRight : Alignment.centerLeft,
            curve: Curves.easeIn,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: constraints.minWidth * 0.46,
                height: constraints.minWidth * 0.46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
