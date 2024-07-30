import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/core/constants/images_constants.dart';
import 'package:erkatoy_afex_ai/design_system/components/single_child_scroll_with_size.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/widget/weight_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'bloc/create_account_bloc.dart';
import 'widget/change_birth_date.dart';
import 'widget/gender_pop_up.dart';
import 'widget/start_button.dart';

class CreatingAccountScreen extends StatefulWidget {
  const CreatingAccountScreen({super.key, required this.phone, required this.password});

  final String phone;
  final String password;

  static const String routePath = 'creating_account/:phone/:pass';
  static const String routeName = 'creating_account';

  static void open(BuildContext context, {required String phone, required String pass}) {
    context.pushReplacementNamed(routeName, pathParameters: {'phone': phone, 'pass': pass});
  }

  @override
  State<CreatingAccountScreen> createState() => _CreatingAccountScreenState();
}

class _CreatingAccountScreenState extends State<CreatingAccountScreen> {
  final GlobalKey<FormState> _weightFormKey = GlobalKey<FormState>();
  final _weightEditingController = TextEditingController();
  late double statusBarHeight;

  @override
  void initState() {
    _weightEditingController.addListener(() {
      String weightValue = _weightEditingController.text;
      context.read<CreateAccountBloc>().add(OnWeightEditingAuthEvent(weightValue));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: TextView(text: 'Erkatoy', textColor: context.themeColors.onSurface),
      ),
      body: SingleChildScrollWithSize(
        statusBarHeight: MediaQuery.of(context).viewPadding.top,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        screenWithAppBar: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: getPaddingAll16,
              decoration: BoxDecoration(
                borderRadius: getCustomBorder(400),
                border: Border.fromBorderSide(
                  BorderSide(color: context.themeColors.secondary, width: 8),
                ),
              ),
              child: Padding(
                padding: getPaddingAll4,
                child: ClipRRect(
                  borderRadius: getCustomBorder(400),
                  child: SvgPicture.asset(
                    ImagesConstants.gradientImg,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            TextView(
              text: 'Xush kelibsiz!',
              textSize: 32.textSize(context),
              textColor: context.themeColors.onSurface,
            ),
            getHeightSize10,
            Container(
              width: 1.screenWidth(context),
              padding: EdgeInsets.symmetric(
                horizontal: 0.08.screenWidth(context),
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: context.themeColors.secondary,
                borderRadius: getBorderAll20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextView(
                    text: "Farzandingiz ma'lumotlarini kiriting:",
                    textSize: 18.textSize(context),
                    textColor: context.themeColors.onSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  getHeightSize10,
                  const ChangeBirthDate(),
                  getHeightSize20,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const GenderPopUp(),
                      const Spacer(),
                      getWidthSize4,
                      WeightInput(
                        weightKey: _weightFormKey,
                        controller: _weightEditingController,
                      ),
                      TextView.boldStyle(
                        text: 'KG',
                        textColor: context.themeColors.onSurface,
                        textSize: 16.textSize(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const StartButton(),
            getHeightSize8,
          ],
        ),
      ),
    );
  }
}
