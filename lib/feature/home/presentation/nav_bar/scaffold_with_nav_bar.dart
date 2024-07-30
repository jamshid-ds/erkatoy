import 'package:erkatoy_afex_ai/core/base/base_functions.dart';
import 'package:erkatoy_afex_ai/core/constants/images_constants.dart';
import 'package:erkatoy_afex_ai/design_system/components/image_asset_icon.dart';
import 'package:erkatoy_afex_ai/design_system/extensions/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  List<BottomNavigationBarItem> _bottomNavBarItems = [];

  @override
  void didChangeDependencies() {
    _bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: ImageAssetIcon(
          asset: ImagesConstants.zendModeIconPng,
          color: context.themeColors.onPrimary,
          iconSize: 24,
        ),
        tooltip: 'Zen mode',
        label: 'Zen mode',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined, color: context.themeColors.onPrimary),
        activeIcon: Icon(Icons.home_rounded, color: context.themeColors.onPrimary),
        tooltip: 'Home',
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined, color: context.themeColors.onPrimary),
        activeIcon: Icon(Icons.settings_rounded, color: context.themeColors.onPrimary),
        tooltip: 'Settings',
        label: 'Settings',
      ),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Card(
        margin: getPaddingAll6,
        shape: RoundedRectangleBorder(borderRadius: getBorderAll16),
        child: BottomNavigationBar(
          currentIndex: widget.navigationShell.currentIndex,
          items: _bottomNavBarItems,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: context.themeColors.primary,
          selectedItemColor: context.themeColors.onPrimary,
          onTap: _onTap,
        ),
      ),
    );
  }

  void _onTap(int index) {
    widget.navigationShell
        .goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }
}
