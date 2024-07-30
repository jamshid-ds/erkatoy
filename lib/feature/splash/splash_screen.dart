import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/core/connectivity/connectivity_cubit.dart';
import 'package:erkatoy_afex_ai/design_system/components/text_view.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      RegisterScreen.open(context);
      context.read<ConnectivityCubit>().observeConnectivity();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // BlocListener<ConnectivityCubit, ConnectivityState>(
          //   listener: (context, state) async {
          //     if (state.status == ConnectivityStatus.connectionFailed) {
          //       await context.showConnectivityDialog().whenComplete(() {
          //         context.read<ConnectivityCubit>().onDialogOpen(true);
          //       });
          //     } else if (state.status == ConnectivityStatus.connectionRestored) {
          //       if (state.isDialogShows) {
          //         Navigator.pop(context);
          //         context.read<ConnectivityCubit>().onDialogOpen(false);
          //       }
          //     }
          //   },
          //   child:
          Padding(
        padding: getPaddingAll20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            getFullWidth(context),
            TextView(text: 'Splash screen', textSize: 30.textSize(context)),
            SizedBox(
              width: 0.5.screenWidth(context),
              child: LinearProgressIndicator(
                color: context.themeColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
