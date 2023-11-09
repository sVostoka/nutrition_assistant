import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_assistant/core/theme.dart';

class TabBarClipper extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onChange;
  final List<BottomNavigationBarItem> items;

  const TabBarClipper({
    required this.selectedIndex,
    required this.onChange,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  _TabBarClipperState createState() => _TabBarClipperState();
}

class _TabBarClipperState extends State<TabBarClipper> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }

  @override
  Widget build(BuildContext context) {
    return buildNotchedCupertino(
      child: BottomNavigationBar(
        selectedItemColor: basicTheme().primaryColor,
        onTap: widget.onChange,
        currentIndex: widget.selectedIndex,
        items: widget.items,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget buildNotchedCupertino({required Widget child}) {
    const colorCupertinoBorder = CupertinoDynamicColor.withBrightness(
      color: Color(0x4C000000),
      darkColor: Color(0x29000000),
    );

    return CustomPaint(
      painter: _BottomAppBarPainter(
        color: colorCupertinoBorder,
        shape: const CircularNotchedRectangle(),
        geometry: geometryListenable,
        notchMargin: 5,
      ),
      child: PhysicalShape(
        clipper: _BottomAppBarClipper(
          shape: const CircularNotchedRectangle(),
          geometry: geometryListenable,
          notchMargin: 5,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        child: Material(color: Colors.transparent, child: child),
      ),
    );
  }
}

class _BottomAppBarPainter extends CustomPainter {
  const _BottomAppBarPainter({
    required this.color,
    required this.geometry,
    required this.shape,
    required this.notchMargin,
  });

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect? button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop! * -1.0,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;

    final path = shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _BottomAppBarClipper extends CustomClipper<Path> {
  const _BottomAppBarClipper({
    required this.geometry,
    required this.shape,
    required this.notchMargin,
  })  : super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final double notchMargin;

  @override
  Path getClip(Size size) {
    final Rect? button = geometry.value.floatingActionButtonArea?.translate(
      0.0,
      geometry.value.bottomNavigationBarTop! * -1.0,
    );
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_BottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}