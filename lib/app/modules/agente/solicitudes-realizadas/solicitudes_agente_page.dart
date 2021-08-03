import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/globlas_widgets/buscando_progress_w.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'local_widgets/card_detalle_widget.dart';
import 'solicitudes_agente_controller.dart';

class SolicitudesAgentePage extends StatelessWidget {
  const SolicitudesAgentePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<SolicitudesAgenteController>(
          builder: (_) => SafeArea(
                child: Stack(
                  children: [
                    DefaultTabController(
                      length: 3,
                      child: Scaffold(
                          appBar: AppBar(
                            title: Text('Solicitudes realizadas'),
                            bottom: TabBar(
                                physics: ScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color: AppColors.secondaryColor),
                                tabs: [
                                  Tab(
                                    text: 'Pendientes',
                                    icon: Icon(
                                      FontAwesomeIcons.hourglassHalf,
                                      color: Colors.white,
                                    ),
                                    iconMargin: EdgeInsets.only(bottom: 10.0),
                                  ),
                                  Tab(
                                    text: 'Aprobados',
                                    icon: Icon(
                                      FontAwesomeIcons.checkCircle,
                                      color: Colors.white,
                                    ),
                                    iconMargin: EdgeInsets.only(bottom: 10.0),
                                  ),
                                  Tab(
                                    text: 'Rechazados',
                                    icon: Icon(
                                      FontAwesomeIcons.timesCircle,
                                      color: Colors.white,
                                    ),
                                    iconMargin: EdgeInsets.only(bottom: 10.0),
                                  ),
                                ]),
                          ),
                          body: GetBuilder<SolicitudesAgenteController>(
                            id: 'tabs',
                            builder: (_) => RefreshIndicator(
                              onRefresh: _.refresh,
                              child: TabBarView(children: [
                                Column(
                                  children: [
                                    _Cabecera(_.pendientes.length),
                                    Expanded(
                                        child: _Detalles(
                                      list: _.pendientes,
                                    )),
                                  ],
                                ),
                                Column(
                                  children: [
                                    _Cabecera(_.aprobados.length),
                                    Expanded(
                                        child: _Detalles(
                                      list: _.aprobados,
                                    )),
                                  ],
                                ),
                                Column(
                                  children: [
                                    _Cabecera(_.rechazados.length),
                                    Expanded(
                                        child: _Detalles(
                                      list: _.rechazados,
                                    )),
                                  ],
                                ),
                              ]),
                            ),
                          )),
                    ),
                    BuscandoProgressWidget(buscando: _.buscando),
                  ],
                ),
              )),
    );
  }
}

class _Detalles extends StatelessWidget {
  final List<SolicitudAgenteModel> list;

  const _Detalles({Key key, @required this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return this.list.length == 0
        ? Container()
        : Container(
            padding: EdgeInsets.all(responsive.dp(1)),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: CustomScrollView(slivers: <Widget>[
                  /* SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      minHeight: responsive.hp(5),
                      maxHeight: responsive.hp(6),
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                              child: _Header(
                                  titulo: 'Detalles de las operaciones'))),
                    ),
                  ), */
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return Container(
                          margin: EdgeInsets.only(top: responsive.hp(1)),
                          child: CardDetalleWidget(
                            solicitud: list[i],
                          ),
                        );
                      },
                      childCount: list.length, // 1000 list items
                    ),
                  ),
                ])));
  }
}

class _Cabecera extends StatelessWidget {
  final int total;

  _Cabecera(this.total);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Container(
        padding: EdgeInsets.all(responsive.dp(1)),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(children: [
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: responsive.hp(1.5), horizontal: responsive.wp(2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.infoCircle,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    this.total == 0
                        ? Text(
                            'Sin operaciones',
                            style: TextStyle(
                                fontSize: responsive.dp(2),
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                          )
                        : Expanded(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Pulse sobre cada elemento para ver más detalles',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: responsive.dp(1.6),
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                  ],
                ))
          ]),
        ));
  }
}
