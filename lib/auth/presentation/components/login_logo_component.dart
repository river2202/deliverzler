import 'package:flutter/material.dart';

import '../../../core/presentation/helpers/localization_helper.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../gen/my_assets.dart';

class LoginLogoComponent extends StatelessWidget {
  const LoginLogoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            color: colorLogoBg,
            borderRadius: BorderRadius.circular(70),
          ),
          child: Center(
            child: Text(
              'G',
              style: TextStyles.f28(context).copyWith(
                color: const Color(0xFFFFFFFF),
                fontSize: 70,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: Sizes.marginV12,
        ),
        Text(
          'ClodFlow',
          style:
              TextStyles.f28(context).copyWith(color: const Color(0xFF5D67B4)),
        ),
      ],
    );
  }
}

const colorLogoBg = Color(0xFF5D67B4);
const colorButton = Color(0xFF737FD7);
