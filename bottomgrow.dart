import 'package:flutter/material.dart';

class AnimatedBottom extends StatefulWidget {
  const AnimatedBottom({super.key});

  static List<IconLabel> get _bottomItens {
    return [
      IconLabel(index: 0, iconData: Icons.add, label: 'Inicio'),
      IconLabel(index: 1, iconData: Icons.ac_unit, label: 'Produtos'),
      IconLabel(index: 2, iconData: Icons.abc, label: 'Ofertas'),
      IconLabel(index: 3, iconData: Icons.add_chart_sharp, label: 'Conta'),
      IconLabel(
        index: 4,
        iconData: Icons.add_circle_outline,
        label: 'Carrinho',
      ),
    ];
  }

  @override
  State<AnimatedBottom> createState() => _AnimatedBottomState();
}

class _AnimatedBottomState extends State<AnimatedBottom> {
  int _initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.pink.shade50,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
            child: Placeholder(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: kBottomNavigationBarHeight,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: kBottomNavigationBarHeight + 22,
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    AnimatedBottom._bottomItens.map((e) {
                      return NavigatorIcon(
                        iconLabel: e,
                        onPress: () {
                          setState(() {
                            _initialIndex = e.index;
                          });
                        },
                        isSelected: _initialIndex == e.index,
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigatorIcon extends StatefulWidget {
  const NavigatorIcon({
    super.key,
    required this.iconLabel,
    required this.isSelected,
    required this.onPress,
  });

  final IconLabel iconLabel;
  final bool isSelected;
  final Function() onPress;

  @override
  State<NavigatorIcon> createState() => _NavigatorIconState();
}

class _NavigatorIconState extends State<NavigatorIcon>
    with TickerProviderStateMixin {
  late final IconLabel _iconLabel;
  late bool _isSelected;
  late final Function() _onPress;

  late final AnimationController _animationController;
  late final Animation<double> _sizeAnimation;

  @override
  void initState() {
    _iconLabel = widget.iconLabel;
    _isSelected = widget.isSelected;
    _onPress = widget.onPress;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _sizeAnimation = Tween<double>(
      begin: 24,
      end: 50,
    ).animate(_animationController);

    if (_isSelected) {
      _animationController.forward();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant NavigatorIcon oldWidget) {
    if (widget.isSelected != _isSelected) {
      _isSelected = widget.isSelected;
    }

    if (_isSelected) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isMin(double width) {
    return width == 24;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 50),
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: _onPress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Container(
                      height: _sizeAnimation.value,
                      width: _sizeAnimation.value,
                      decoration: BoxDecoration(
                        color:
                            !_isMin(_sizeAnimation.value)
                                ? Colors.deepOrange
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(60.0),
                      ),
                      child: Icon(_iconLabel.iconData),
                    );
                  },
                ),

                Text(_iconLabel.label),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconLabel {
  final int index;
  final String label;
  final IconData iconData;

  IconLabel({required this.index, required this.label, required this.iconData});
}
