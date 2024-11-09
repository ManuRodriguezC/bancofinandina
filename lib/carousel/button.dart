import 'package:flutter/material.dart';
import '../dataSource/info_pages.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ButtonPage extends StatefulWidget {
  final num currentPage;
  final VoidCallback onNextPage;
  final bool effect;

  const ButtonPage(
      {Key? key,
      required this.currentPage,
      required this.onNextPage,
      required this.effect})
      : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  double _containerHeight = 80;
  double _containerWidth = 0;
  bool _hasEffectStarted = false;

  @override
  void initState() {
    super.initState();
  }

  void _startEffect() {
    if (!_hasEffectStarted) {
      _hasEffectStarted = true;
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && widget.effect) {
          setState(() {
            _containerHeight = 60;
            _containerWidth = double.infinity;
          });
        }
      });
    }
  }

  void _resetEffect() {
    setState(() {
      _containerHeight = 80;
      _hasEffectStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('ButtonPage-${widget.hashCode}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && widget.effect) {
          _startEffect();
        } else {
          _resetEffect();
        }
      },
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          margin: !_hasEffectStarted
              ? const EdgeInsets.all(15)
              : const EdgeInsets.all(25),
          padding: !_hasEffectStarted
              ? const EdgeInsets.all(10)
              : const EdgeInsets.all(0),
          width: double.infinity,
          height: _containerHeight,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color: !_hasEffectStarted ? Colors.white30 : Colors.transparent,
          ),
          child: !_hasEffectStarted
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 22),
                        child: Text(
                          "Saltar",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: List.generate(pages.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: AnimatedContainer(
                              duration: const Duration(microseconds: 20),
                              margin: const EdgeInsets.all(3),
                              width: index == widget.currentPage ? 23 : 11,
                              height: 11,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(100)),
                                color: index == widget.currentPage
                                    ? Colors.white
                                    : Colors.white54,
                              ),
                            ),
                          );
                        }),
                      ),
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                          onPressed: widget.onNextPage,
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 32,
                          ),
                          color: Color(int.parse(pages[widget.currentPage.toInt()]['color'] ?? '0xFFE31952')),
                        ),
                      )
                    ])
              : AnimatedContainer(
                  duration: const Duration(seconds: 10),
                  width: _containerWidth,
                  height: 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.white),
                  alignment: Alignment.centerRight,
                  child: Center(
                    child: Text(
                      "Libera tu banca",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(int.parse(pages[widget.currentPage.toInt()]['color'] ?? '0xFFE31952')),
                          backgroundColor: Colors.transparent),
                    ),
                  ),
                )),
    );
  }
}
