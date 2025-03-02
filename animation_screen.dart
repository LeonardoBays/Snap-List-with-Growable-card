import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font/presentation/screens/animation/load_skeleton.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _topAnimation;
  late final Animation<double> _leftAnimation;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size logicalSize = view.physicalSize / view.devicePixelRatio;

    double screenWidth = logicalSize.width;
    double screenHeight = logicalSize.height;

    _topAnimation = Tween<double>(
      begin: screenHeight / 2 - 50,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _leftAnimation = Tween<double>(
      begin: screenWidth / 2 - 50,
      end: 14,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _sizeAnimation = Tween<double>(begin: _iconDefaultSize, end: 32).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.forward();

    super.initState();
  }

  double get _iconDefaultSize => 150;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  AppBar(
                    title: Text("Animação do Ícone"),
                    backgroundColor: Colors.white,
                    leading: Icon(Icons.star, color: Colors.transparent),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LoadSkeleton(),
                          LoadSkeleton(),
                          LoadSkeleton(),
                          LoadSkeleton(),
                          LoadSkeleton(),
                          LoadSkeleton(),
                          LoadSkeleton(),
                          LoadSkeleton(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  left: _leftAnimation.value,
                  top: _topAnimation.value,
                  child: Image.asset(
                    'assets/images/icon.png',
                    height: _sizeAnimation.value,
                    width: _sizeAnimation.value,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
