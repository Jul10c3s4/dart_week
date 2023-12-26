import 'package:flutter/material.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/colors_app.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final bool _compact;
  final int amount;
  final VoidCallback increment;
  final VoidCallback decrement;

  const DeliveryIncrementDecrementButton({
    super.key,
    required this.amount,
    required this.increment,
    required this.decrement,
  }) : _compact = false;

  const DeliveryIncrementDecrementButton.compact({
    super.key,
    required this.amount,
    required this.increment,
    required this.decrement,
  }) : _compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? EdgeInsets.all(5) : null,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: context.colors.secondary,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: decrement,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '-',
                style: context.textStyles.textMedium
                    .copyWith(fontSize: _compact ? 14: 22, color: Colors.grey),
              ),
            ),
          ),
          Text(
            amount.toString(),
            style: context.textStyles.textBold.copyWith(
              fontSize: _compact ? 14:17,
              color: context.colors.secondary,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
                onTap: increment,
                child: Text(
                  '+',
                  style: context.textStyles.textMedium
                      .copyWith(fontSize: _compact ? 14 : 22, color: context.colors.secondary),
                )),
          ),
        ],
      ),
    );
  }
}
