import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/config/constants.dart';
import 'package:fupa_aliados/app/data/models/adjunto_solicitud_seguro_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_seguro_model.dart';
import 'package:fupa_aliados/app/globlas_widgets/full_screen_image_view.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../solicitudes_seguros_controller.dart';

class CardDetalleWidget extends StatelessWidget {
  final SolicitudSeguroModel solicitud;

  const CardDetalleWidget({Key key, @required this.solicitud})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    var f = new NumberFormat("###,###", "es_ES");
    TextStyle styleTitle = TextStyle(
      fontSize: responsive.hp(1.8),
      fontWeight: FontWeight.w400,
      color: Colors.black87, //Colors.indigo,
    );
    TextStyle styleSubTitle = TextStyle(
      fontSize: responsive.hp(1.6),
      fontWeight: FontWeight.w400,
      color: Colors.black38, //Colors.indigo,
    );

    bool isPending = solicitud.estado.idestadosolicitudagente == 1 ||
        solicitud.estado.idestadosolicitudagente == 3;

    bool isApproved = solicitud.estado.idestadosolicitudagente == 2;

    List<AdjuntoSolicitudSeguroModel> cedulas =
        solicitud.adjuntos.where((e) => e.tipo == 'CEDULA').toList();

    bool isLiquidacionFirmada =
        solicitud.adjuntos.indexWhere((e) => e.tipo == "LIQUIDACION-FIRMADO") >
            -1;
    bool isFormularioFirmado =
        solicitud.adjuntos.indexWhere((e) => e.tipo == "FORMULARIO-FIRMADO") >
            -1;
    List<AdjuntoSolicitudSeguroModel> documetosFirmados =
        solicitud.adjuntos.where((e) {
      return e.tipo.indexOf('FIRMADO') > -1;
    }).toList();

    Widget _buildImageNetwork(String url) {
      print(url);
      Widget widget = Image.asset(
        'assets/images/no-image.jpg',
        width: responsive.wp(30),
        height: responsive.hp(10),
      );

      var _image = NetworkImage(url);

      _image.resolve(ImageConfiguration()).addListener(
            ImageStreamListener(
              (info, call) {
                widget = FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loader.gif',
                  image: url,
                  width: responsive.wp(25),
                  height: responsive.hp(15),
                );
              },
              onError: (exception, stackTrace) {
                print('Error image network' + exception.toString());
                widget = Image.asset(
                  'assets/images/no-image.jpg',
                  width: responsive.wp(25),
                  height: responsive.hp(15),
                );
              },
            ),
          );
      return widget;
    }

    return GetBuilder<SolicitudesSegurosController>(
        builder: (_) => InkWell(
              onTap: () {
                showCupertinoModalBottomSheet(
                  expand: true,
                  context: context,
                  useRootNavigator: true,
                  builder: (_) => Material(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          children: [
                            Center(
                              child: _Header(titulo: 'Detalles'),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                top: 5,
                              ),
                              child: Material(
                                child: HtmlWidget(
                                  _getDescriprion(solicitud),
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    height: 1.3,
                                    wordSpacing: 1.4,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: _Header(titulo: 'Documento titular')),
                            ),
                            Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.spaceAround,
                              children: [
                                ...cedulas
                                    .map((e) => InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenImageView(
                                                      imageProvider: NetworkImage(
                                                          '${AppConstants.API_URL}public/image/public/fupapp/seguros/${e.adjunto}'),
                                                    )),
                                          ),
                                          child: CachedNetworkImage(
                                            width: responsive.wp(40),
                                            height: responsive.hp(15),
                                            imageUrl:
                                                '${AppConstants.API_URL}public/image/public/fupapp/seguros/${e.adjunto}',
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                              width: 50,
                                              height: 50,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/images/no-image.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ))
                                    .toList(),
                              ],
                            ),
                            if (solicitud.tiposeguro == 'FAMILIAR')
                              ..._beneficiarios(context, solicitud),
                            if (solicitud.estado.idestadosolicitudagente == 5)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: _Header(titulo: 'Observación'),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${solicitud.motivorechazo ?? ''}",
                                    style:
                                        TextStyle(fontSize: responsive.dp(1.8)),
                                  )
                                ],
                              ),
                            if (solicitud.estado.idestadosolicitudagente > 1 &&
                                solicitud.estado.idestadosolicitudagente < 5)
                              Center(
                                child: _Header(titulo: 'Documentos firmados'),
                              ),
                            Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.spaceAround,
                              children: [
                                ...documetosFirmados
                                    .map((e) => Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: InkWell(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenImageView(
                                                        imageProvider: NetworkImage(
                                                            '${AppConstants.API_URL}public/image/public/fupapp/seguros/${e.adjunto}'),
                                                      )),
                                            ),
                                            child: CachedNetworkImage(
                                              width: responsive.wp(40),
                                              height: responsive.hp(15),
                                              imageUrl:
                                                  '${AppConstants.API_URL}public/image/public/fupapp/seguros/${e.adjunto}',
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      Container(
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                ),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      'assets/images/no-image.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                Visibility(
                                  visible: isApproved && !isLiquidacionFirmada,
                                  child:
                                      GetBuilder<SolicitudesSegurosController>(
                                    id: 'adjuntos',
                                    builder: (_) {
                                      return Container(
                                        width: responsive.wp(25),
                                        height: responsive.hp(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  final origen = await _
                                                      .dialogSelectOrigen();
                                                  print(origen);
                                                  if (origen != null &&
                                                      origen > 0) {
                                                    _.adjuntarArchivo(
                                                        origen,
                                                        solicitud
                                                            .idsolicitudseguro,
                                                        'LIQUIDACION-FIRMADO');
                                                  }
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.upload,
                                                  color: Colors.grey,
                                                )),
                                            Text(
                                              'Subir liquidación crédito',
                                              textAlign: TextAlign.center,
                                              style: AppFonts.secondaryFont
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: isApproved && !isFormularioFirmado,
                                  child:
                                      GetBuilder<SolicitudesSegurosController>(
                                    id: 'adjuntos',
                                    builder: (_) {
                                      return Container(
                                        width: responsive.wp(25),
                                        height: responsive.hp(15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  final origen = await _
                                                      .dialogSelectOrigen();
                                                  print(origen);
                                                  if (origen != null &&
                                                      origen > 0) {
                                                    _.adjuntarArchivo(
                                                        origen,
                                                        solicitud
                                                            .idsolicitudseguro,
                                                        'FORMULARIO-FIRMADO');
                                                  }
                                                },
                                                icon: Icon(
                                                  FontAwesomeIcons.upload,
                                                  color: Colors.grey,
                                                )),
                                            Text(
                                              'Subir Formulario de adhesion',
                                              textAlign: TextAlign.center,
                                              style: AppFonts.secondaryFont
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
                margin: EdgeInsets.symmetric(horizontal: responsive.wp(1)),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 0.5),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: isPending
                      ? Icon(FontAwesomeIcons.hourglass, color: Colors.blueGrey)
                      : isApproved
                          ? Icon(
                              FontAwesomeIcons.checkCircle,
                              color: Colors.green.shade600,
                            )
                          : Icon(
                              FontAwesomeIcons.timesCircle,
                              color: Colors.red.shade700,
                            ),
                  trailing: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      'G. ${f.format(solicitud.monto)}',
                      style: TextStyle(
                        fontSize: responsive.dp(1.7),
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SEGURO ${solicitud.tiposeguro}",
                        style: TextStyle(
                          fontSize: responsive.hp(1.7),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor, //Colors.indigo,
                        ),
                      ),
                      SizedBox(
                        height: responsive.hp(1),
                      ),
                      Text(
                        "${solicitud.cliente.persona.nrodoc} - ${solicitud.cliente.persona.nombres} ${solicitud.cliente.persona.apellidos}"
                            .capitalize,
                        style: styleTitle,
                      ),
                    ],
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: responsive.hp(1)),
                    child: Text(
                      isPending
                          ? '${solicitud.fechasolicitud}'
                          : isApproved
                              ? '${solicitud.fechaaprobacion}'
                              : '${solicitud.fecharechazo}',
                      style: styleSubTitle,
                    ),
                  ),
                ),
              ),
            ));
  }

  String _getDescriprion(SolicitudSeguroModel agente) {
    String contenido = "";
    var f = new NumberFormat("###,###", "es_ES");

    String cliente = (agente.cliente.persona != null)
        ? '${agente.cliente.persona.nombres} ${agente.cliente.persona.apellidos}'
        : "";
    int cantCuotas = agente.cantidadcuota;

    contenido += "<b>Cliente:</b> " + cliente + "<br>";
    contenido += "<b>Doc:</b> " + agente.cliente.persona.nrodoc + "<br>";
    contenido += "<b>Tipo seguro:</b> " + agente.tiposeguro + "<br>";
    contenido += "<b>Monto:</b> " + f.format(agente.monto) + " Gs. <br>";
    contenido += "<b>Cant. cuotas:</b> ${cantCuotas.toString()} <br>";

    return contenido;
  }

  List<Widget> _beneficiarios(
      BuildContext context, SolicitudSeguroModel agente) {
    final responsive = Responsive.of(Get.context);
    List<Widget> list = [];

    list.add(Container(
        margin: EdgeInsets.only(
          top: 5,
          left: 15,
        ),
        child: Center(
          child: Container(
              margin: EdgeInsets.only(top: 10),
              child: _Header(titulo: 'Beneficiarios')),
        )));

    agente.beneficiarios.forEach((e) {
      if (e.persona.nrodoc != null &&
          e.persona.nombres != null &&
          e.persona.apellidos != null) {
        list.add(ListTile(
          leading: Icon(
            FontAwesomeIcons.userFriends,
            color: AppColors.secondaryColor,
          ),
          title: Text(
            "${e.persona.nombres} ${e.persona.apellidos}",
            style: AppFonts.primaryFont.copyWith(
                fontSize: responsive.dp(1.65),
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(e.idparentezco == 1 ? "Cónyuge" : "Hijo/a"),
        ));
        list.add(lineSeparator());
      }
    });

    return list;
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
    return Material(
      child: Container(
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
                fontSize: responsive.dp(2),
                color: Colors.white,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
