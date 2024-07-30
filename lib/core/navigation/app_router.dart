import 'package:erkatoy_afex_ai/di.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/bloc/create_account_bloc.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/creating_account/creating_account_screen.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/login/bloc/login_bloc.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/login/login_screen.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/register/bloc/register_bloc.dart';
import 'package:erkatoy_afex_ai/feature/auth/presentation/register/register_screen.dart';
import 'package:erkatoy_afex_ai/feature/change_lang/bloc/change_lang_bloc.dart';
import 'package:erkatoy_afex_ai/feature/change_lang/change_lang_screen.dart';
import 'package:erkatoy_afex_ai/feature/home/presentation/home_screen.dart';
import 'package:erkatoy_afex_ai/feature/home/presentation/nav_bar/scaffold_with_nav_bar.dart';
import 'package:erkatoy_afex_ai/feature/settings/settings_screen.dart';
import 'package:erkatoy_afex_ai/feature/splash/splash_screen.dart';
import 'package:erkatoy_afex_ai/feature/zen/zen_mode_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _sectionNavKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: SplashScreen.routeName,
    navigatorKey: _navigatorKey,
    routes: [
      /// splash
      GoRoute(
        path: SplashScreen.routeName,
        builder: (context, _) => const SplashScreen(),
        routes: [
          GoRoute(
            path: ChangeLangScreen.routeName,
            name: ChangeLangScreen.routeName,
            pageBuilder: (context, _) => _materialPage(BlocProvider(
              create: (context) => getIt<ChangeLangBloc>(),
              child: const ChangeLangScreen(),
            )),
          ),
        ],
      ),

      ///auth
      GoRoute(
        path: RegisterScreen.routeName,
        pageBuilder: (context, _) => _cupertinoPage(BlocProvider(
          create: (context) => getIt<RegisterBloc>(),
          child: const RegisterScreen(),
        )),
        routes: [
          GoRoute(
            path: LoginScreen.routeName,
            name: LoginScreen.routeName,
            pageBuilder: (context, _) => _cupertinoPage(BlocProvider(
              create: (context) => getIt<LoginBloc>(),
              child: const LoginScreen(),
            )),
          ),
          GoRoute(
            path: CreatingAccountScreen.routePath,
            name: CreatingAccountScreen.routeName,
            pageBuilder: (context, state) {
              final phone = state.pathParameters['phone'];
              final password = state.pathParameters['pass'];
              return _cupertinoPage(BlocProvider(
                create: (context) => getIt<CreateAccountBloc>(),
                child: CreatingAccountScreen(phone: phone!, password: password!),
              ));
            },
          ),
        ],
      ),

      /// home
      StatefulShellRoute.indexedStack(
        builder: (context, _, navShell) => ScaffoldWithNavBar(navigationShell: navShell),
        branches: [
          /// zen
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ZenModeScreen.routeName,
                builder: (context, _) => const ZenModeScreen(),
              )
            ],
          ),

          /// home
          StatefulShellBranch(
            navigatorKey: _sectionNavKey,
            routes: [
              GoRoute(
                path: HomeScreen.routeName,
                builder: (context, _) => const HomeScreen(),
                routes: [],
              )
            ],
          ),

          /// settings
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: SettingsScreen.routeName,
                builder: (context, _) => const SettingsScreen(),
                routes: [],
              )
            ],
          )
        ],
      ),
    ],
  );

  static GoRouter get router => _router;

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static Page<dynamic> _materialPage(Widget screen) => MaterialPage(child: screen);

  static Page<dynamic> _cupertinoPage(Widget screen) => CupertinoPage(child: screen);
}
