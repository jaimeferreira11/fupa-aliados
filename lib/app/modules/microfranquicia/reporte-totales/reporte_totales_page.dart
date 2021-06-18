import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/data/models/cliente_model.dart';
import 'package:fupa_aliados/app/data/models/persona_model.dart';
import 'package:fupa_aliados/app/data/models/proforma_model.dart';
import 'package:fupa_aliados/app/globlas_widgets/input_select_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/reporte-totales/local_widgets/card_detalle_widget.dart';
import 'package:fupa_aliados/app/modules/microfranquicia/reporte-totales/reporte_totales_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ReporteTotalesPage extends StatelessWidget {
  const ReporteTotalesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<ReporteTotalesController>(
          builder: (_) => SafeArea(
                child: Scaffold(
                  appBar: AppBar(title: Text('Reporte totales')),
                  body: Container(
                    child: Column(children: [
                      _HeaderBackground(),
                      _Totales(),
                      Expanded(child: _Detalles())
                    ]),
                  ),
                ),
              )),
    );
  }
}

class _Detalles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GetBuilder<ReporteTotalesController>(
      initState: (_) {},
      builder: (_) {
        return Container(
            padding: EdgeInsets.all(responsive.dp(1)),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: CustomScrollView(slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      minHeight: responsive.hp(5),
                      maxHeight: responsive.hp(7),
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
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(top: responsive.hp(1)),
                          child: CardDetalleWidget(
                            proforma: new ProformaModel(
                                cliente: ClienteModel(
                                    persona: PersonaModel(
                                        nrodoc: '4800301',
                                        nombres: 'Jaime Dario',
                                        apellidos: 'Ferreira MEDINA')),
                                fechaLog: '21/04/2021',
                                monto: 50000),
                          ),
                        );
                      },
                      childCount: 1000, // 1000 list items
                    ),
                  ),
                ])));
      },
    );
  }
}

class _Totales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GetBuilder<ReporteTotalesController>(
      initState: (_) {},
      builder: (_) {
        return Container(
            padding: EdgeInsets.all(responsive.dp(1)),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(children: [
                _Header(titulo: 'Totales'),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: responsive.hp(2)),
                  child: Column(children: [
                    Text(
                      'G. 2.000.000',
                      style: TextStyle(
                          fontSize: responsive.dp(3.2),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    ),
                    SizedBox(
                      height: responsive.hp(.3),
                    ),
                    Text(
                      '2 operaciones',
                      style: TextStyle(
                          fontSize: responsive.dp(2),
                          fontWeight: FontWeight.w400,
                          color: Colors.black54),
                    )
                  ]),
                )
              ]),
            ));
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
    @required this.titulo,
  }) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
        child: Text(
          titulo,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: responsive.dp(2.2),
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ));
  }
}

class _HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return GetBuilder<ReporteTotalesController>(
      builder: (_) {
        return Container(
          width: double.infinity,
          // height: responsive.hp(20),
          padding: EdgeInsets.symmetric(vertical: responsive.hp(3)),
          decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    AppColors.primaryColor,
                    AppColors.darkColor,
                  ])),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Mes",
                        style: TextStyle(
                            fontSize: responsive.dp(2.2),
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                        width: responsive.wp(40),
                        margin: EdgeInsets.only(left: responsive.wp(2)),
                        child: GetBuilder<ReporteTotalesController>(
                          builder: (_) {
                            return InputSelectWidget(
                              value: DateFormat('MMMM', 'es_US')
                                  .format(DateTime.now()),
                              options: _.generateListofMonths(),
                              onChanged: (text) {
                                // _.plazo = text;
                              },
                            );
                          },
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Año",
                        style: TextStyle(
                            fontSize: responsive.dp(2.2),
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                        width: responsive.wp(40),
                        margin: EdgeInsets.only(right: responsive.wp(2)),
                        child: GetBuilder<ReporteTotalesController>(
                          builder: (_) {
                            return InputSelectWidget(
                              value: DateFormat('y').format(DateTime.now()),
                              options: _.generateListofyears(),
                              onChanged: (text) {
                                // _.plazo = text;
                              },
                            );
                          },
                        )),
                  ],
                ),
              ]),
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
