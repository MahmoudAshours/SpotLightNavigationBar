import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spotlightnavbar/showUp.dart';
import 'package:spotlightnavbar/trapezium_painter.dart';

class SpotLightNavBar extends StatefulWidget {
  ///The items in the navigation bar.
  ///[items] shouldn't be null
  final List<Widget> items;

  ///Duration of spotlight animation.
  final Duration animationDuration;

  ///Curve of the animation.
  final Curve animationCurve;

  ///Action when the index changes.
  final ValueChanged<int> onItemPressed;

  ///Global keys that identify the global position of the widget.
  final List<GlobalKey> keys = List();

  ///[selectedItemColor] is the item color when selected.
  final Color selectedItemColor;

  ///[nonSelectedItemColor] is when the item is'nt selected.
  final Color nonSelectedItemColor;

  ///The bottom navigation bar color
  final Color bottomNavBarColor;

  /// The small spotlight color
  final Color spotLightColor;

  SpotLightNavBar({
    Key key,
    @required this.items,
    this.onItemPressed,
    this.selectedItemColor,
    this.nonSelectedItemColor,
    this.bottomNavBarColor,
    this.animationCurve,
    this.spotLightColor,
    this.animationDuration,
  }) : assert(items != null) {
    for (int i = 0; i < items.length; i++) {
      keys.add(GlobalKey());
    }
  }

  @override
  _SpotLightNavBarState createState() => _SpotLightNavBarState();
}

class _SpotLightNavBarState extends State<SpotLightNavBar> {
  double _spotLightPosition;
  double _opacity = 0.23;
  int _currentIndex = 0;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        _spotLightPosition = _getPosition();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: widget.bottomNavBarColor ?? Theme.of(context).primaryColor,
        height: 50,
        child: Stack(
          children: [
            AnimatedPositionedDirectional(
              duration: widget.animationDuration ?? Duration(milliseconds: 700),
              curve: widget.animationCurve ?? Curves.decelerate,
              onEnd: () {
                setState(
                  () {
                    _opacity = 0.23;
                    widget.onItemPressed(_currentIndex);
                  },
                );
              },
              start: _spotLightPosition ?? 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.spotLightColor ?? Colors.white,
                      boxShadow: [
                        ///Shadows of [_spotLightPosition]
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 2,
                          blurRadius: 40,
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 40,
                        ),
                        BoxShadow(color: Colors.black38, spreadRadius: 0.3)
                      ],
                    ),
                    width: 38,
                    height: 2,
                  ),
                  ShowUp(
                    delay: 300,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: _opacity,
                      child: SizedBox(
                        width: 30,
                        height: 50,
                        child: CustomPaint(
                          painter: LogoPainter(
                            backgroundColor:
                                widget.bottomNavBarColor ?? Color(0xff3B3B3B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: widget.items
                    .asMap()
                    .map(
                      (int i, Widget iconItem) => MapEntry(
                        i,
                        GestureDetector(
                          onTap: () {
                            RenderBox box = widget.keys[i].currentContext
                                .findRenderObject();
                            Offset position = box.localToGlobal(Offset.zero);
                            setState(
                              () {
                                //To identify the center of the widget
                                var center = box.size.width / 5;
                                _spotLightPosition = position.dx + center;

                                if (_spotLightPosition != position.dx)
                                  _opacity = 0;

                                _currentIndex = i;
                              },
                            );
                          },
                          key: widget.keys[i],
                          child: Center(
                            child: IconTheme(
                              data: _currentIndex == i
                                  ? IconThemeData(
                                      color: widget.selectedItemColor ??
                                          Colors.white,
                                    )
                                  : IconThemeData(
                                      color: widget.nonSelectedItemColor ??
                                          Colors.white24),
                              child: iconItem,
                            ),
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  //To get the widget position globally
  double _getPosition() {
    RenderBox box = widget.keys[0].currentContext.findRenderObject();
    Offset position = box.localToGlobal(Offset.zero);
    return position.dx;
  }
}
