import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/helpers/size_extentions.dart';
import 'package:vakinha_burguer_app/app/core/ui/styles/text_styles.dart';
import 'package:vakinha_burguer_app/app/models/payment_Type_model.dart';

class PaymentTypesField extends StatelessWidget {
  final List<PaymentTypeModel> paymentTypes;
  final ValueChanged<int> valueChanged;
  final bool valid;
  final String valueSelected;

  const PaymentTypesField(
      {super.key, required this.paymentTypes, required this.valueChanged, required this.valid, required this.valueSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forma de pagamento',
              style: context.textStyles.textRegular.copyWith(fontSize: 16),
            ),
            SmartSelect<String>.single(
              title: '',
              //essa variável é usada para que a tela atualize somente um widget 
              selectedValue: valueSelected,
              modalType: S2ModalType.bottomSheet,
              onChange: (selected) {
                valueChanged(int.parse(selected.value));
              },
              tileBuilder: (context, state) {
                return InkWell(
                  onTap: state.showModal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: context.screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.selected.title ?? '',
                                style: context.textStyles.textRegular),
                            const Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !valid,
                        child: Divider(color: Colors.red, height: 3,)),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Visibility(
                            visible: !valid,
                            child: Text('Selecione uma forma de pagamento', style: context.textStyles.textRegular.copyWith(fontSize: 13,
                           color: Colors.red),)),
                        )
                    ],
                  ),
                );
              },
              choiceItems: S2Choice.listFrom<String, Map<String, String>>(
                  source: //[
                      paymentTypes
                          .map((p) =>
                              {'value': p.id.toString(), 'title': p.name})
                          .toList()
                  /*{'value': 'VA', 'title': 'Vale Alimentação'},
                    {'value': 'VR', 'title': 'Vale Refeição'},
                    {'value': 'CC', 'title': 'Cartão de Credito'},*/
                  //],
                  ,
                  title: (index, item) => item['title'] ?? '',
                  value: (index, item) => item['value'] ?? '',
                  group: (index, item) => 'Selecione uma forma de pagamento'),
              choiceType: S2ChoiceType.radios,
              choiceGrouped: true,
              modalFilter: true,
              placeholder: '',
            )
          ],
        ));
  }
}
