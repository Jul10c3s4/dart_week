import 'package:flutter/material.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_button.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ColoredBox(
      color: Color(0XFF140E0E),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWidth,
                child: Image.asset(
                  'assets/images/lanche.png',
                  fit: BoxFit.cover,
                ),
              )),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: context.percentheight(.20),
                ),
                Image.asset('assets/images/logo.png'),
                const SizedBox(
                  height: 80,
                ),
                DeliveryButton(
                    width: context.percentWidth(.3),
                    heigth: context.percentheight(.02),
                    label: 'Acessar',
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed('/home');
                    })
              ],
            ),
          )
        ],
      ),
    ));
  }
}
