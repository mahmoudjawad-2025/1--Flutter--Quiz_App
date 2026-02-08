import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final VoidCallback onStartPressed;

  const IntroPage({Key? key, required this.onStartPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: Stack(
        children: [
          // Background image or color
          // Positioned.fill(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         colors: [
          //           Colors.white,
          //           const Color.fromARGB(255, 166, 231, 168)
          //           // const Color.fromARGB(255, 125, 181, 127)
          //         ],
          //         begin: Alignment.topLeft,
          //         end: Alignment.bottomRight,
          //       ),
          //     ),
          //   ),
          // ),

          // text, image  and button
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // title
                  Text(
                    "Welcome to Quiz App ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      shadows: [
                        Shadow(
                            color: Colors.black54,
                            offset: Offset(2, 2),
                            blurRadius: 5),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Image.asset(
                    "lib/assets/quiz_icon2.png",
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: width * 1,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 60),

                  Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: TextButton(
                      onPressed: onStartPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Play Now ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 55,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(120),
                        border: Border.all(color: Colors.green)),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "About  ",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
