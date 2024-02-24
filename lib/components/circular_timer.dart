import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;


// import 'package:ten_ants/shared/shared.dart';

class CircularCountdown extends StatefulWidget {
  final int duration;
  final double indicatorThickness;
  final Color fillColor;
  final Color backgroundColor;
  final VoidCallback onCountdownComplete;

  const CircularCountdown({
    Key? key,
    required this.duration,
    this.indicatorThickness = 5,
    this.fillColor = const Color(0xFF10DB78),
    this.backgroundColor = const Color(0xFFD9D9D9),
    required this.onCountdownComplete,
  }) : super(key: key);

  @override
  CircularCountdownState createState() => CircularCountdownState();
}

class CircularCountdownState extends State<CircularCountdown> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
      reverseDuration: Duration(seconds: widget.duration),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          // Animation completed, call the function
          widget.onCountdownComplete();
        }
      });
    _controller!.reverse(from: 1.0); // Start the countdown
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _controller!.value;
    double angle = 2 * math.pi * progress;

    // Calculate remaining seconds
    int remainingSeconds = (_controller!.duration!.inSeconds * progress).ceil();

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 49,
            height: 45,
            child: CustomPaint(
              painter: CircularPainter(
                fillColor: widget.fillColor,
                backgroundColor: widget.backgroundColor,
                progress: angle,
                strokeWidth: widget.indicatorThickness,
              ),
            ),
          ),
          Text(
            "$remainingSeconds",
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularPainter extends CustomPainter {
  final Color fillColor;
  final Color backgroundColor;
  final double progress;
  final double strokeWidth;

  CircularPainter({
    required this.fillColor,
    required this.backgroundColor,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = fillColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    const startAngle = -math.pi / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TimerCountdown extends StatefulWidget {
  final Duration initialTime;
  final double indicatorThickness;
  final Color fillColor;
  final Color backgroundColor;
  final VoidCallback onCountdownComplete;

  const TimerCountdown({
    super.key,
    required this.initialTime,
    this.indicatorThickness = 10.0,
    this.fillColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    required this.onCountdownComplete,
  });

  @override
  TimerCountdownState createState() => TimerCountdownState();
}

class TimerCountdownState extends State<TimerCountdown> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.initialTime,
      reverseDuration: widget.initialTime,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          // Animation completed, call the function
          widget.onCountdownComplete();
        }
      });
    _controller.reverse(from: 1.0); // Start the countdown
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _controller.value;
    double angle = 2 * math.pi * progress;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 149,
            height: 149,
            child: CustomPaint(
              painter: TimerCountdownPainter(
                fillColor: widget.fillColor,
                backgroundColor: widget.backgroundColor,
                progress: angle,
                strokeWidth: widget.indicatorThickness,
              ),
            ),
          ),
          Text(
            "${(_controller.duration!.inMinutes * progress).toInt()}:${((_controller.duration!.inSeconds * progress) % 60).toInt().toString().padLeft(2, '0')}",
            style: TextStyle(
                fontSize: 40,
                height: 48 / 40,
                color: const Color(0XFF404164)),
          ),
        ],
      ),
    );
  }
}

class TimerCountdownPainter extends CustomPainter {
  final Color fillColor;
  final Color backgroundColor;
  final double progress;
  final double strokeWidth;

  TimerCountdownPainter({
    required this.fillColor,
    required this.backgroundColor,
    required this.progress,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, backgroundPaint);

    final progressPaint = Paint()
      ..color = fillColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    const startAngle = -math.pi / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}