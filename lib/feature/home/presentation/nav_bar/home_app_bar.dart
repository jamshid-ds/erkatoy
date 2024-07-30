import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/core/constants/images_constants.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextView(text: 'Erkatoy', textColor: context.themeColors.onSurface),
      automaticallyImplyLeading: false,
      actions: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(48),
          child: Padding(
            padding: getPaddingAll8,
            child: SvgPicture.asset(
              ImagesConstants.chatIconSvg,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(context.themeColors.onSurface, BlendMode.srcATop),
              fit: BoxFit.cover,
            ),
          ),
        ),
        getWidthSize16,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
