import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/core/constants/images_constants.dart';
import 'package:erkatoy_afex_ai/design_system/components/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widget/change_lang_floating_ac_btn.dart';
import 'widget/locale_item.dart';

class ChangeLangScreen extends StatefulWidget {
  const ChangeLangScreen({super.key});

  static const String routeName = 'change_lang';

  static void open(BuildContext context) {
    context.pushReplacementNamed(routeName);
  }

  @override
  State<ChangeLangScreen> createState() => _ChangeLangScreenState();
}

class _ChangeLangScreenState extends State<ChangeLangScreen> {
  List<Map<String, String>> localeItems = [];

  @override
  void initState() {
    localeItems = [
      {
        'name': 'O`zbekcha',
        'asset': ImagesConstants.uzIconSvg,
      },
      {
        'name': 'Ruscha',
        'asset': ImagesConstants.ruIconSvg,
      },
      {
        'name': 'Inglizcha',
        'asset': ImagesConstants.enIconSvg,
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'Select language'),
      body: Padding(
        padding: getPaddingAll8,
        child: Column(
          children: <Widget>[
            getHeightSize10,
            ...List.generate(localeItems.length, (index) {
              final item = localeItems[index];
              return LocaleItem(
                iconsAsset: item['asset']!,
                localeName: item['name']!,
              );
            })
          ],
        ),
      ),
      floatingActionButton: const ChangeLangFloatingAcBtn(),
    );
  }
}
