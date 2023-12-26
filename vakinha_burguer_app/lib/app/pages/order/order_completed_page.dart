import 'package:flutter/material.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/widgets/delivery_button.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: context.percentheight(.1),
                ),
                Image.asset('assets/images/logo_rounded.png'),
                Text(
                  'Pedido realizado com sucesso, em breve você receberá a confirmação de seu pedido',
                  style:
                      context.textStyles.textExtraBold.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                DeliveryButton(
                    label: 'FECHAR',
                    onPressed: () {
                      Navigator.pop(context); 
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
