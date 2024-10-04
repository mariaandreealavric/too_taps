import 'package:flutter/material.dart';
import 'dart:math';

class SgretolamentoWidget extends StatefulWidget {
  const SgretolamentoWidget({super.key});

  @override
  SgretolamentoWidgetState createState() => SgretolamentoWidgetState();
}

class SgretolamentoWidgetState extends State<SgretolamentoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;
  late Image _image;
  bool _isImageLoaded = false;
  int _taps = 0; // Contatore dei tocchi
  Offset _touchPoint = Offset.zero; // Punto di tocco

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        for (var particle in _particles) {
          particle.update(Size(
              _image.width?.toDouble() ?? 0, _image.height?.toDouble() ?? 0));
        }
      });
    });

    _controller.addListener(() {
      setState(() {
        _particles.removeWhere((particle) => particle.isDead);
        for (var particle in _particles) {
          particle.update(Size(
              _image.width?.toDouble() ?? 0, _image.height?.toDouble() ?? 0));
        }
      });
    });


    _particles = [];
    _image = Image.asset(
        'assets/amorepsiche.jpg'); // Sostituisci con il tuo asset immagine
    _image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool synchronousCall) {
        setState(() {
          _isImageLoaded = true;
        });
      }),
    );
  }

  void _generateParticles(Size imageSize, Offset touchPoint) {
    _particles.clear();
    for (int i = 0; i < 200; i++) {
      Offset startPoint;
      if (touchPoint.dx >= 0 &&
          touchPoint.dx <= imageSize.width &&
          touchPoint.dy >= 0 &&
          touchPoint.dy <= imageSize.height) {
        startPoint = touchPoint;
      } else {
        startPoint = Offset(
          Random().nextDouble() * imageSize.width,
          Random().nextDouble() * imageSize.height,
        );
      }
      _particles.add(Particle.fromStartPoint(startPoint));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTouchEvent(TapUpDetails details) {
    setState(() {
      _taps++; // Incrementa il contatore dei tocchi
      _touchPoint = details.localPosition;

      _generateParticles(
          Size(_image.width?.toDouble() ?? 0, _image.height?.toDouble() ?? 0),
          _touchPoint);

      if (_controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else {
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTapUp: _handleTouchEvent,
              child: _isImageLoaded
                  ? Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    width: _image.width?.toDouble(),
                    height: _image.height?.toDouble(),
                    child: _image,
                  ),
                  CustomPaint(
                    size: Size(_image.width?.toDouble() ?? 0,
                        _image.height?.toDouble() ?? 0),
                    painter: SgretolamentoPainter(_particles),
                  ),
                ],
              )
                  : const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tocchi: $_taps',
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class SgretolamentoPainter extends CustomPainter {
  final List<Particle> particles;

  SgretolamentoPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    // Dipinge le particelle
    final paint = Paint()..color = Colors.white;
    for (var particle in particles) {
      particle.paint(canvas, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  double x, y, dx, dy, size;
  final Random random = Random();
  bool isDead = false;
  Particle(this.x, this.y, this.dx, this.dy, this.size);

  Particle.fromStartPoint(Offset startPoint)
      : x = startPoint.dx,
        y = startPoint.dy,
        dx = (Random().nextDouble() - 0.5) * 4,
        dy = Random().nextDouble() * 8,
        size = Random().nextDouble() * 3;

  Particle.randomPoint(Size imageSize)
      : x = Random().nextDouble() * imageSize.width,
        y = Random().nextDouble() * imageSize.height,
        dx = (Random().nextDouble() - 0.5) * 4,
        dy = Random().nextDouble() * 8,
        size = Random().nextDouble() * 3;

  void update(Size imageSize) {
    x += dx;
    y += dy;
    // Rimuovi la particella se è completamente al di fuori dei bordi dell'immagine
    if (x < 0 || x > imageSize.width || y > imageSize.height) {
      isDead = true;
    }
    // Limita il movimento delle particelle alla larghezza dell'immagine
    if (x < 0) {
      x = 0;
    }
    if (x > imageSize.width) {
      x = imageSize.width;
    }
    // Limita il movimento delle particelle alla parte superiore dell'immagine
    if (y < 0) {
      y = 0;
    }
  }


  void paint(Canvas canvas, Paint paint) {
    canvas.drawCircle(Offset(x, y), size, paint);
  }
}


