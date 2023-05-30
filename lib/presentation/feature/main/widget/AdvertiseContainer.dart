import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AdvertiseContainer extends HookWidget {
  const AdvertiseContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(16, 78, 16, 0),
        width: double.infinity,
        height: 90,
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: const Center(
          child: Text(
            "광고영역",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ));
  }
}
