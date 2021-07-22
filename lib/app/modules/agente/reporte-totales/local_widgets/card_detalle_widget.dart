import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/data/models/solicitud_agente_model.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

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

    return Container(
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
            '${solicitud.fechaconfirmacion}',
            style: styleSubTitle,
          ),
        ),
      ),
    );
  }
}
