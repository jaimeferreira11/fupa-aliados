import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/data/models/sanatorio_producto_model.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/globlas_widgets/buscando_progress_w.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_widget.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/solicitar-credito/local_widgets/search_header_widget.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/solicitar-credito/solicitar_credito_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SolicitarCreditoPage extends StatelessWidget {
  const SolicitarCreditoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Container(
      child: GetBuilder<SolicitarCreditoController>(
          builder: (_) => SafeArea(
                child: Stack(
                  children: [
                    Scaffold(
                        appBar: AppBar(title: Text('Solicitar credito')),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.centerDocked,
                        floatingActionButton: _.cliente == null ||
                                keyboardIsOpen
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FloatingActionButton.extended(
                                      heroTag: 'cancel',
                                      backgroundColor: Colors.red.shade800,
                                      
                                      onPressed: () {
                                        _.doc = "";
                                        _.reset();
                                      },
                                      label: Text('Cancelar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.dp(1.6))),
                                      icon: Icon(
                                        FontAwesomeIcons.times,
                                        color: Colors.white,
                                      ),
                                    ),
                                    FloatingActionButton.extended(
                                      heroTag: 'save',
                                      onPressed: () {
                                        _.solicitarCodigoVerificacion();
                                      },
                                      label: Text('Enviar solicitud',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: responsive.dp(1.6))),
                                      icon: _.workInProgress
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : Icon(
                                              FontAwesomeIcons.paperPlane,
                                              color: Colors.white,
                                            ),
                                    )
                                  ],
                                ),
                              ),
                        backgroundColor: Colors.grey[200],
                        body: GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              _Encabezado(),
                              Visibility(
                                visible: _.cliente != null,
                                child: FadeIn(
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: responsive.hp(1),
                                        horizontal: responsive.wp(2)),
                                    child: Card(
                                        elevation: 4.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: _listWidget(context, _)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    BuscandoProgressWidget(buscando: _.buscando),
                  ],
                ),
              )),
    );
  }
}

_listWidget(BuildContext context, SolicitarCreditoController _) {
  final responsive = Responsive.of(context);

  return ListView(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    children: [
      Container(
        margin: EdgeInsets.only(
            left: responsive.wp(5),
            top: responsive.hp(2),
            bottom: responsive.hp(0.5)),
        child: Text(
          "Datos de la solicitud",
          style: TextStyle(
              fontSize: responsive.dp(1.8),
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ),
      lineSeparator(),
      Container(
          margin: EdgeInsets.only(
              top: responsive.hp(2),
              bottom: responsive.hp(1),
              left: responsive.wp(5),
              right: responsive.wp(5)),
          child: Obx(() => InputWidget(
                label: 'Monto (Gs.)',
                keyboardType: TextInputType.number,
                fontSize: responsive.dp(1.8),
                error: _.error2.value,
                valor: _.monto,
                onChanged: (text) {
                  _.monto = text;
                },
              ))),
      Container(
        margin: EdgeInsets.only(left: responsive.wp(10)),
        child: Text(
          "Plazo (Dias)",
          style: TextStyle(
              fontSize: responsive.dp(1.8),
              color: Colors.black54,
              fontWeight: FontWeight.w400),
        ),
      ),
      Container(
          margin: EdgeInsets.only(
              left: responsive.wp(5),
              right: responsive.wp(5),
              bottom: responsive.hp(1)),
          child: GetBuilder<SolicitarCreditoController>(
            id: 'plazo',
            builder: (_) {
              return InputSelectWidget(
                fontSize: responsive.dp(1.8),
                value: _.plazo,
                options: ['7', '14', '30'],
                onChanged: (text) {
                  _.plazo = text;
                  _.update(['plazo']);
                },
              );
            },
          )),
      Visibility(
        visible: Cache.instance.user.sanatorio.productos.isNotEmpty,
        child: Container(
            margin: EdgeInsets.only(
                bottom: responsive.hp(3),
                left: responsive.wp(3),
                right: responsive.wp(1)),
            child: GetBuilder<SolicitarCreditoController>(
              id: 'productos',
              builder: (_) {
                return Wrap(
                    children: Cache.instance.user.sanatorio.productos
                        .map((p) => _buildProductos(_, p))
                        .toList());
              },
            )),
      ),
    ],
  );
}

Widget _buildProductos(SolicitarCreditoController _, SanatorioProductoModel p) {
  final responsive = Responsive.of(Get.context);

  return _.idsanatorioproducto == p.idsanatorioproducto
      ? Container(
          margin: EdgeInsets.only(right: 5),
          child: InkWell(
            onTap: () {
              _.idsanatorioproducto = p.idsanatorioproducto;
            },
            child: Chip(
              backgroundColor: Colors.green[200],
              label: Text(
                p.descripcion.capitalize,
                style: TextStyle(
                  fontSize: responsive.dp(1.5),
                  fontWeight: FontWeight.w500,
                  color: Colors.green.shade900,
                ),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              avatar: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.check),
              ),
            ),
          ),
        )
      : Container(
          margin: EdgeInsets.only(right: 5),
          child: InkWell(
            onTap: () {
              _.idsanatorioproducto = p.idsanatorioproducto;
              _.update(['productos']);
            },
            child: Chip(
              label: Text(
                p.descripcion.capitalize,
                style: TextStyle(
                  fontSize: responsive.dp(1.5),
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              avatar: CircleAvatar(
                backgroundColor: Colors.white70,
                child: Icon(
                  FontAwesomeIcons.minus,
                  size: 15,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        );
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SearchHeaderWidget(),
      ],
    );
  }
}
