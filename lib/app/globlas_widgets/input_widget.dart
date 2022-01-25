import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_widget/focus_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';

// ignore: must_be_immutable
class InputWidget extends StatelessWidget {
  final String label;
  final String placeHolder;
  final String tipo;
  final String valor;
  final int maxLength;
  final List<String> options;
  final TextInputType keyboardType;
  final bool obscureText, borderEnabled;
  final double fontSize;
  final IconData icon;
  final void Function(String text) onChanged;
  final String Function(String text) validator;
  final String error;
  final List<TextInputFormatter> inputFormatters;
  final String titulo;
  final bool editable;
  final FocusNode focusNode;

  InputWidget(
      {Key key,
      this.label = 'Label',
      this.placeHolder = 'Escriba aquí',
      this.tipo = 'text',
      this.options,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.borderEnabled = true,
      this.icon,
      this.fontSize = 18,
      this.onChanged,
      this.validator,
      this.error = "",
      this.valor,
      this.focusNode,
      this.maxLength,
      this.inputFormatters,
      this.editable = true,
      this.titulo})
      : super(key: key);

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
  int actualFormCompleted;

  Map<String, TextEditingController> inputsValuesControllers = {};

  List<Widget> _getSlider(BuildContext context) {
    final responsive = Responsive.of(context);
    var listaWidgets = <Widget>[];
    var dias;
    var meses;
    var anos;

    dias = [
      "día",
      "01",
      "02",
      "03",
      "04",
      "05",
      "06",
      "07",
      "08",
      "09",
      "10",
      "11",
      "12",
      "13",
      "14",
      "15",
      "16",
      "17",
      "18",
      "19",
      "20",
      "21",
      "22",
      "23",
      "24",
      "25",
      "26",
      "27",
      "28",
      "29",
      "30",
      "31"
    ];
    meses = [
      "mes",
      "enero",
      "febrero",
      "marzo",
      "abril",
      "mayo",
      "junio",
      "julio",
      "agosto",
      "setiembre",
      "octubre",
      "noviembre",
      "diciembre"
    ];
    anos = [
      "año",
      "1980",
      "1981",
      "1982",
      "1983",
      "1984",
      "1985",
      "1986",
      "1987",
      "1988",
      "1989",
      "1990",
      "1991",
      "1992",
      "1993",
      "1994",
      "1995",
      "1996",
      "1997",
      "1998",
      "1999",
      "2000",
      "2001",
      "2002",
      "2003",
      "2004",
      "2005",
      "2006",
      "2007",
      "2008",
      "2009",
      "2010",
    ];

    if (titulo != null && this.titulo.length > 0) {
      listaWidgets.add(
        Container(
          margin: EdgeInsets.only(bottom: responsive.hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              this.titulo,
              style: TextStyle(
                  fontSize: this.fontSize,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      );
    }

    switch (tipo) {
      case "text":
        Widget errorTextWidget = Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.error ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.red.shade800),
                )));
        listaWidgets.add(this.error.isEmpty ? SizedBox() : errorTextWidget);
        String keyInputValue = "$key";
        bool existeValor = inputsValues.containsKey(keyInputValue);
        bool existeNodo = inputsFocusNodes.containsKey(keyInputValue);
        bool existeController =
            inputsValuesControllers.containsKey(keyInputValue);
        if (existeValor) {
          //DO NOTHING
        } else {
          inputsValues[keyInputValue] = "";
        }
        if (existeNodo) {
          //NOTHING
        } else {
          inputsFocusNodes[keyInputValue] = FocusNode();
        }
        if (existeController) {
          //NOTHING
        } else {
          inputsValuesControllers[keyInputValue] = TextEditingController();
        }
        inputsValuesControllers[keyInputValue].text = valor;
        listaWidgets.add(Container(
            child: TextFormField(
          enabled: this.editable,
          onFieldSubmitted: (value) {
            FocusScope.of(context).unfocus();
            if (inputsFocusNodes.containsKey("$key")) {
              print("key siguiente encontrada $key");
              FocusScope.of(context).requestFocus(inputsFocusNodes["$key"]);
            } else {
              //NO EN ESTA PAGINA
              print("key siguiente inexistente $key");
            }
          },
          //  focusNode: focusNode ?? FocusNode(),
          onChanged: (valor) {
            inputsValues[keyInputValue] = valor;
            this.onChanged(valor);
          },
          validator: this.validator,
          maxLength: maxLength,
          //focusNode: inputsFocusNodes[keyInputValue] ?? FocusNode(),
          controller: inputsValuesControllers[keyInputValue],
          textCapitalization: TextCapitalization.words,
          inputFormatters: this.inputFormatters ?? [],
          textInputAction: inputsFocusNodes.containsKey("$key")
              ? TextInputAction.next
              : TextInputAction.done,
          keyboardType: this.keyboardType,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            // cambie icon por prefixIcon
            prefixIcon: icon != null
                ? Icon(
                    icon,
                    color: AppColors.secondaryColor,
                    size: fontSize,
                  )
                : null,
            hintText: placeHolder,
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              color: Colors.black26,
              fontSize: fontSize,
            ),
            labelText: label,
            labelStyle: TextStyle(color: Colors.blueGrey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: this.error.isEmpty ? Colors.grey : Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.blueGrey),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                color: this.error.isEmpty ? AppColors.inputColor : Colors.red,
              ),
            ),
          ),
        )));
        break;

      case "select":
        Widget errorTextWidget = Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.error ?? "",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
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
          // focusNode: inputsFocusNodes[keyInputValue] ?? FocusNode(),
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
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: fontSize,
              ),
              isExpanded: true,
              value: inputsValues[keyInputValue],
              onChanged: (valor) {
                FocusScope.of(context).requestFocus(new FocusNode());
                inputsValues[keyInputValue] = valor;
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
        break;
      case "radio":
        Widget errorTextWidget = Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.validator ?? "",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
                )));
        listaWidgets.add(this.validator == null ? SizedBox() : errorTextWidget);
        String keyInputValue = "$key";
        List<Widget> radioList = [];
        for (var i = 0; i < options.length; i++) {
          bool existeValor = inputsValues.containsKey(keyInputValue);
          bool existeNodo = inputsFocusNodes.containsKey(keyInputValue);
          if (existeValor) {
            //DO NOTHING
          } else {
            print("ADD NEW RADIO ENTRY");
            inputsValues[keyInputValue] = "";
          }
          if (existeNodo) {
            //NOTHING
          } else {
            inputsFocusNodes[keyInputValue] = FocusNode();
          }
          radioList.add(Container(
              margin: EdgeInsets.only(
                  top: 0.0, bottom: 0.0, left: 20.0, right: 20.0),
              child: RadioListTile(
                  title: Text(
                    options[i],
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  value: options[i].toString(),
                  groupValue: inputsValues[keyInputValue],
                  onChanged: (valor) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  })));
        }
        listaWidgets.add(FocusWidget(
          // focusNode: inputsFocusNodes[keyInputValue] ?? FocusNode(),
          child: Container(
            margin: EdgeInsets.only(
                top: 8.0, bottom: 25.0, left: 20.0, right: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: this.validator == null ? Colors.grey : Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              margin: EdgeInsets.only(bottom: 0.0),
              child: Column(
                children: radioList,
              ),
            ),
          ),
        ));
        break;
      case "checkbox":
        Widget errorTextWidget = Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.validator ?? "",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, color: Colors.red),
                )));
        listaWidgets.add(this.validator == null ? SizedBox() : errorTextWidget);
        String keyInputValue = "$key";
        List<Widget> checkBoxList = [];
        Map<String, bool> defaultValues = Map();
        for (var i = 0; i < options.length; i++) {
          defaultValues[options[i]] = false;
        }
        for (var i = 0; i < options.length; i++) {
          String keyCheckBox = options[i].toString();
          bool existeValor = inputsValues.containsKey(keyInputValue);
          bool existeNodo = inputsFocusNodes.containsKey(keyInputValue);
          if (existeValor) {
            //DO NOTHING
          } else {
            print("ADD NEW CHECKBOXGROUP ENTRY");
            inputsValues[keyInputValue] = defaultValues;
          }
          if (existeNodo) {
            //NOTHING
          } else {
            inputsFocusNodes[keyInputValue] = FocusNode();
          }
          checkBoxList.add(Container(
              margin: EdgeInsets.only(
                  top: 8.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: CheckboxListTile(
                  title: Text(
                    keyCheckBox,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  value: inputsValues[keyInputValue][keyCheckBox],
                  onChanged: (valor) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    print("TOUCHED: $keyCheckBox OF $label VALUE: $valor");
                  })));
        }
        listaWidgets.add(FocusWidget(
          // focusNode: inputsFocusNodes[keyInputValue] ?? FocusNode(),
          child: Container(
              margin: EdgeInsets.only(
                  top: 8.0, bottom: 25.0, left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color:
                      this.validator == null ? Colors.transparent : Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: checkBoxList,
              )),
        ));
        break;
      case "date":
        Widget errorTextWidget = Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.validator ?? "",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                )));
        listaWidgets.add(this.validator == null ? SizedBox() : errorTextWidget);
        String keyInputValue = "$key";
        Map<String, dynamic> defaultDateValues = {
          "dias": dias[0],
          "meses": meses[0],
          "anos": anos[0]
        };
        bool existeValor = inputsValues.containsKey(keyInputValue);
        bool existeNodo = inputsFocusNodes.containsKey(keyInputValue);
        if (existeValor) {
          //DO NOTHING
        } else {
          inputsValues[keyInputValue] = defaultDateValues;
        }
        if (existeNodo) {
          //NOTHING
        } else {
          inputsFocusNodes[keyInputValue] = FocusNode();
        }
        listaWidgets.add(FocusWidget(
          focusNode: inputsFocusNodes[keyInputValue] ?? FocusNode(),
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: this.validator == null ? Colors.grey : Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: EdgeInsets.only(
                  top: 8.0, bottom: 25.0, left: 20.0, right: 20.0),
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                        value: inputsValues[keyInputValue]["dias"],
                        items: dias.map<DropdownMenuItem<String>>((valor) {
                          return DropdownMenuItem<String>(
                            child: Text(valor),
                            value: valor,
                          );
                        }).toList(),
                        onChanged: (valor) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                        value: inputsValues[keyInputValue]["meses"],
                        items: meses.map<DropdownMenuItem<String>>((valor) {
                          return DropdownMenuItem<String>(
                            child: Text(valor),
                            value: valor,
                          );
                        }).toList(),
                        onChanged: (valor) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                          fontSize: fontSize,
                        ),
                        value: inputsValues[keyInputValue]["anos"],
                        items: anos.map<DropdownMenuItem<String>>((valor) {
                          return DropdownMenuItem<String>(
                            child: Text(valor),
                            value: valor,
                          );
                        }).toList(),
                        onChanged: (valor) {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ));
        break;
      default:
        print("input no implementado: $tipo");
    }

    return listaWidgets;
  }
}
