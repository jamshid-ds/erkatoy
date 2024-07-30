import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/core/constants/images_constants.dart';
import 'package:erkatoy_afex_ai/design_system/components/single_child_scroll_with_size.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/home/presentation/nav_bar/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  static open(BuildContext context) {
    context.go(routeName);
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollWithSize(
        statusBarHeight: MediaQuery.of(context).viewPadding.top,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0.05.screenWidth(context)),
        screenWithAppBar: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: 1.screenWidth(context),
              padding: getPaddingAll20,
              decoration: BoxDecoration(
                color: context.themeColors.secondary,
                borderRadius: getBorderAll16,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextView.boldStyle(
                        text: 'Yig`i sababini\naniqlash',
                        textSize: 18.textSize(context),
                        textColor: context.themeColors.onSecondary,
                        maxLines: 2,
                      ),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: context.themeColors.surface.withOpacity(0.8),
                          borderRadius: getBorderAll16,
                        ),
                        child: SvgPicture.asset(ImagesConstants.voiceIconSvg),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
