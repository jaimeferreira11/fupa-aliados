import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/config/constants.dart';
import 'package:fupa_aliados/app/data/models/adjunto_solicitud_agente_model.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/globlas_widgets/full_screen_image_view.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../solicitudes_agente_controller.dart';

class CardDetalleWidget extends StatelessWidget {
  final SolicitudAgenteModel solicitud;

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

    bool isPending =
        solicitud.estadosolicitudagente.idestadosolicitudagente == 1 ||
            solicitud.estadosolicitudagente.idestadosolicitudagente == 3;

    bool isApproved =
        solicitud.estadosolicitudagente.idestadosolicitudagente == 2;

    List<AdjuntoSolicitudAgenteModel> cedulas =
        solicitud.adjuntos.where((e) => e.tipo == 'CEDULA').toList();
    List<AdjuntoSolicitudAgenteModel> fotos =
        solicitud.adjuntos.where((e) => e.tipo == 'FOTO-CLIENTE').toList();
    List<AdjuntoSolicitudAgenteModel> inforconf = solicitud.adjuntos
        .where((e) => e.tipo == 'AUTORIZACION INFORCONF')
        .toList();

    Widget _buildImageNetwork(String url) {
      Widget widget = Image.asset(
        'assets/images/no-image.jpg',
        width: responsive.wp(25),
        height: responsive.hp(15),
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
                print('Error image network');
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

    return InkWell(
      onTap: () => showCupertinoModalBottomSheet(
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
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 20),
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
                    child: _Header(titulo: 'Documento cliente'),
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
                                      builder: (context) => FullScreenImageView(
                                            imageProvider: NetworkImage(
                                                '${AppConstants.API_URL}public/image/public/fupapp/agente/${e.adjunto}'),
                                          )),
                                ),
                                child: _buildImageNetwork(
                                    '${AppConstants.API_URL}public/image/public/fupapp/agente/${e.adjunto}'),
                              ))
                          .toList(),
                      Visibility(
                        visible: solicitud.estadosolicitudagente
                                .idestadosolicitudagente ==
                            1,
                        child: GetBuilder<SolicitudesAgenteController>(
                          id: 'adjuntos',
                          builder: (_) {
                            return Container(
                              width: responsive.wp(25),
                              height: responsive.hp(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        final origen =
                                            await _.dialogSelectOrigen();
                                        print(origen);
                                        if (origen != null && origen > 0) {
                                          _.adjuntarArchivo(
                                              origen,
                                              solicitud.idsolicitudagente,
                                              'CEDULA');
                                        }
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.upload,
                                        color: Colors.grey,
                                      )),
                                  Text(
                                    'Subir otro archivo',
                                    textAlign: TextAlign.center,
                                    style: AppFonts.secondaryFont
                                        .copyWith(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: _Header(titulo: 'Autorizacion Inforconf'),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      ...inforconf
                          .map((e) => InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreenImageView(
                                            imageProvider: NetworkImage(
                                                '${AppConstants.API_URL}public/image/public/fupapp/agente/${e.adjunto}'),
                                          )),
                                ),
                                child: _buildImageNetwork(
                                    '${AppConstants.API_URL}public/image/public/fupapp/agente/${e.adjunto}'),
                              ))
                          .toList(),
                      Visibility(
                        visible: solicitud.estadosolicitudagente
                                .idestadosolicitudagente ==
                            1,
                        child: GetBuilder<SolicitudesAgenteController>(
                          id: 'adjuntos',
                          builder: (_) {
                            return Container(
                              width: responsive.wp(25),
                              height: responsive.hp(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        final origen =
                                            await _.dialogSelectOrigen();
                                        print(origen);
                                        if (origen != null && origen > 0) {
                                          _.adjuntarArchivo(
                                              origen,
                                              solicitud.idsolicitudagente,
                                              'AUTORIZACION INFORCONF');
                                        }
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.upload,
                                        color: Colors.grey,
                                      )),
                                  Text(
                                    'Subir otro archivo',
                                    textAlign: TextAlign.center,
                                    style: AppFonts.secondaryFont
                                        .copyWith(fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: _Header(titulo: 'Foto cliente'),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceAround,
                    children: [
                      ...fotos
                          .map((e) => InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreenImageView(
                                            imageProvider: NetworkImage(
                                                '${AppConstants.API_URL}public/image/public/fupapp/agente/${e.adjunto}'),
                                          )),
                                ),
                                child: _buildImageNetwork(
                                    '${AppConstants.API_URL}public/image/public/fupapp/agente/${e.adjunto}'),
                              ))
                          .toList(),
                      Visibility(
                        visible: solicitud.estadosolicitudagente
                                .idestadosolicitudagente ==
                            1,
                        child: GetBuilder<SolicitudesAgenteController>(
                          id: 'adjuntos',
                          builder: (_) {
                            return Container(
                              width: responsive.wp(25),
                              height: responsive.hp(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        final origen =
                                            await _.dialogSelectOrigen();
                                        print(origen);
                                        if (origen != null && origen > 0) {
                                          _.adjuntarArchivo(
                                              origen,
                                              solicitud.idsolicitudagente,
                                              'FOTO-CLIENTE');
                                        }
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.upload,
                                        color: Colors.grey,
                                      )),
                                  Text(
                                    'Subir otro archivo',
                                    textAlign: TextAlign.center,
                                    style: AppFonts.secondaryFont
                                        .copyWith(fontWeight: FontWeight.w500),
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
      ),
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
            child: Text(
              'G. ${f.format(solicitud.monto)}',
              style: TextStyle(
                fontSize: responsive.dp(1.7),
                color: AppColors.accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            "${solicitud.cliente.persona.nrodoc} - ${solicitud.cliente.persona.nombres} ${solicitud.cliente.persona.apellidos}"
                .capitalize,
            style: styleTitle,
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
    );
  }

  String _getDescriprion(SolicitudAgenteModel agente) {
    String contenido = "";
    var f = new NumberFormat("###,###", "es_ES");

    String cliente = (agente.cliente.persona != null)
        ? '${agente.cliente.persona.nombres} ${agente.cliente.persona.apellidos}'
        : "";
    String lugarTrabajo = agente.lugartrabajo ?? "";
    String cargo = agente.cargo ?? "";
    String antiguedad = agente.antiguedad ?? "";
    String salario = agente.salario ?? "";
    String dirTrabajo = agente.direcciontrabajo ?? "";
    String telTrabajo = agente.telefonotrabajo ?? "";
    String ciudadTrabajo = agente.ciudadtrabajo ?? "";
    String tipoVivienda = agente.tipovivienda ?? "";
    String profesion = agente.profesion ?? "";
    String otrosIngresos = agente.otrosingresos ?? "0";
    // String activos = (agente.getActivos() != null) ? agente.getActivos() : "";
    String referencia1 = agente.referencia1 ?? "";
    String referencia2 = agente.referencia2 ?? "";
    int cantCuotas = agente.cantidadcuota;
    String destino = agente.destino ?? "";

    contenido += "<b>Cliente:</b> " + cliente + "<br>";
    contenido += "<b>Doc:</b> " + agente.cliente.persona.nrodoc + "<br>";
    contenido += "<b>Lugar de trabajo:</b> " + lugarTrabajo + "<br>";
    contenido += "<b>Cargo:</b> " + cargo + "<br>";
    contenido += "<b>Antiguedad:</b> " + antiguedad + "<br>";
    contenido += "<b>Salario:</b> " + salario + " Gs. <br>";
    contenido += "<b>Dir. de trabajo:</b> " + dirTrabajo + "<br>";
    contenido += "<b>Tel. de trabajo:</b> " + telTrabajo + "<br>";
    contenido += "<b>Ciudad de trabajo:</b> " + ciudadTrabajo + "<br>";
    contenido += "<b>Vivienda:</b> " + tipoVivienda + "<br>";
    contenido += "<b>Profesion:</b> " + profesion + "<br>";
    contenido += "<b>Otros ingresos:</b> " + otrosIngresos + " Gs. <br>";
    //contenido += "<b>Activos:</b> " + activos + "<br>";
    contenido += "<b>Referencia 1:</b> " + referencia1 + "<br>";
    contenido += "<b>Referencia 2:</b> " + referencia2 + "<br>";
    contenido += "<b>Monto:</b> " + f.format(agente.monto) + " Gs. <br>";
    contenido += "<b>Cant. cuotas:</b> ${cantCuotas.toString()} <br>";
    contenido += "<b>Destino crédito:</b> " + destino + "<br>";

    return contenido;
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
