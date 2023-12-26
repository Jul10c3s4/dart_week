import 'package:flutter/material.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/pages/order/widgets/payment_types_field.dart';

class OrderField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hintText;

  const OrderField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey)
    );
     
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             const SizedBox(height: 35,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(title,
                style: context.textStyles.textRegular.copyWith(overflow: TextOverflow.ellipsis,
                fontSize: 16),),
              ),
          TextFormField(
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: defaultBorder,
              enabledBorder: defaultBorder,
              focusedBorder: defaultBorder

            ),
          ),
        ],
      ),
    );
  }
}
