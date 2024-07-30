import 'package:erkatoy_afex_ai/core/connectivity/connectivity_cubit.dart';
import 'package:erkatoy_afex_ai/core/localization/app_localizations.dart';
import 'package:erkatoy_afex_ai/core/navigation/app_router.dart';
import 'package:erkatoy_afex_ai/design_system/theme/theme.dart';
import 'package:erkatoy_afex_ai/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ConnectivityCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: MaterialTheme.lightTheme,
        darkTheme: MaterialTheme.darkTheme,
        themeMode: ThemeMode.system,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
