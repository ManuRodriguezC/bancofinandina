import 'package:flutter/material.dart';
import 'package:bancofinandina/carousel/button.dart';

class ViewCarousel extends StatelessWidget {
  final String? title;
  final String? background;
  final String subtitle;
  final String parraf;
  final String? image;
  final String? size;
  final VoidCallback onNextPage;
  final num currentPage;
  final bool end;

  const ViewCarousel({
    Key? key,
    required this.title,
    this.background,
    required this.subtitle,
    required this.parraf,
    this.image,
    this.size,
    required this.onNextPage,
    required this.currentPage,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[300],
            image: background != null
                ? DecorationImage(
                    // Imagen de Fondo de Pantalla
                    image: AssetImage("assets/images/$background"),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                // Imagen de Logo
                duration: const Duration(seconds: 1),
                width: (title?.isEmpty ?? true ? 50 : 100),
                height: (title?.isEmpty ?? true ? 50 : 100),
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              if (title?.isNotEmpty ?? false)
                const SizedBox(
                  height: 40,
                ),
              if (title != null)
                Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      title!,
                      style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          color: Colors.white,
                          fontFamily: 'Roboto'),
                      textAlign: TextAlign.center,
                    )),
              title?.isNotEmpty ?? false
                  ? const SizedBox(height: 300)
                  : AnimatedContainer(
                      width: (size?.isEmpty ?? true) ? 310 : (screenWidth),
                      height: 380,
                      duration: const Duration(seconds: 2),
                      child: Image.asset(
                        "assets/images/$image",
                        fit: BoxFit.contain,
                      ),
                    ),
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(children: [
                  Padding(
                    padding: (title?.isEmpty ?? true
                        ? const EdgeInsets.only(bottom: 20)
                        : EdgeInsets.zero),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: (title?.isEmpty ?? true)
                              ? (screenWidth * 0.08)
                              : (screenWidth * 0.043),
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: (title?.isEmpty ?? true)
                              ? FontWeight.bold
                              : FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    parraf,
                    style: TextStyle(
                        fontSize: (title?.isEmpty ?? true)
                            ? (screenWidth * 0.044)
                            : (screenWidth * 0.075),
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: (title?.isEmpty ?? true)
                            ? FontWeight.w400
                            : FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: ButtonPage(
            currentPage: currentPage,
            onNextPage: onNextPage,
            effect: end,
          ),
        ),
      ],
    );
  }
}
