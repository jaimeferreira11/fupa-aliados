import 'package:flutter/material.dart';
import 'package:focus_widget/focus_widget.dart';

class InputSelectWidget extends StatelessWidget {
  final String label;
  final List<String> options;
  String value;
  final bool borderEnabled;
  final double fontSize;
  final bool requerido;
  final void Function(String text) onChanged;
  final String Function(String text) validator;

  InputSelectWidget({
    Key key,
    this.label = 'Label',
    this.options,
    this.value = 'Seleccione una opción',
    this.borderEnabled = true,
    this.fontSize = 18,
    this.onChanged,
    this.requerido = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: _getSlider(context),
      ),
    );
  }

  Map<String, dynamic> inputsValues = {};
  Map<String, FocusNode> inputsFocusNodes = {};

  Map<String, TextEditingController> inputsValuesControllers = {};

  List<Widget> _getSlider(BuildContext context) {
    var listaWidgets = <Widget>[];

    Widget errorTextWidget = Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Campo requerido" ?? "",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: Colors.red),
            )));
    listaWidgets.add(this.validator == null ? SizedBox() : errorTextWidget);
    String keyInputValue = "$key";
    bool existeValor = inputsValues.containsKey(keyInputValue);
    bool existeNodo = inputsFocusNodes.containsKey(keyInputValue);
    if (existeValor) {
      //DO NOTHING
    } else {
      inputsValues[keyInputValue] = options[0];
    }
    if (existeNodo) {
      //NOTHING
    } else {
      inputsFocusNodes[keyInputValue] = FocusNode();
    }
    listaWidgets.add(FocusWidget(
      focusNode: inputsFocusNodes[keyInputValue] ?? FocusNode(),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: this.validator == null ? Colors.grey : Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 5, bottom: 5),
        width: MediaQuery.of(context).size.width,
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontSize: fontSize,
          ),
          isExpanded: true,
          value: value,
          onChanged: (valor) {
            value = valor;
            FocusScope.of(context).requestFocus(new FocusNode());
            this.onChanged(valor);
          },
          items: options.map<DropdownMenuItem>((valor) {
            return DropdownMenuItem(
              child: Text(valor),
              value: valor,
            );
          }).toList(),
        )),
      ),
    ));

    return listaWidgets;
  }
}
