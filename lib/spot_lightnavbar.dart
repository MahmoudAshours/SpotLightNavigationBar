import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spotlightnavbar/showUp.dart';
import 'package:spotlightnavbar/trapezium_painter.dart';

class SpotLightNavBar extends StatefulWidget {
  final List<Icon> icons;
  List<GlobalKey> keys = List();
  SpotLightNavBar({@required this.icons}) {
    for (int i = 0; i < icons.length; i++) {
      keys.add(GlobalKey());
    }
  }

  @override
  _SpotLightNavBarState createState() => _SpotLightNavBarState();
}

class _SpotLightNavBarState extends State<SpotLightNavBar> {
  double _startPosition;
  double _opacity = 0.23;
  int _currentIndex = 0;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        _startPosition = _getPosition();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff3B3B3B),
        height: 50,
        child: Stack(
          children: [
            AnimatedPositionedDirectional(
              duration: Duration(milliseconds: 700),
              curve: Curves.decelerate,
              onEnd: () {
                setState(
                  () {
                    _opacity = 0.23;
                  },
                );
              },
              start: _startPosition ?? 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
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
                          painter: LogoPainter(),
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
                children: widget.icons
                    .asMap()
                    .map(
                      (int i, Icon iconItem) => MapEntry(
                        i,
                        GestureDetector(
                          onTap: () {
                            RenderBox box = widget.keys[i].currentContext
                                .findRenderObject();
                            Offset position = box.localToGlobal(Offset.zero);
                            setState(
                              () {
                                if (_startPosition != position.dx) _opacity = 0;
                                _startPosition = position.dx;
                                _currentIndex = i;
                              },
                            );
                          },
                          key: widget.keys[i],
                          child: Center(child: iconItem),
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

  double _getPosition() {
    RenderBox box = widget.keys[0].currentContext.findRenderObject();
    Offset position = box.localToGlobal(Offset.zero);
    return position.dx;
  }
}
