import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';

import '../profile_controller.dart';

class CardProfileWidget extends StatelessWidget {
  const CardProfileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GetBuilder<ProfileController>(
      builder: (_) {
        return Container(
          width: responsive.wp(90),
          margin: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
          child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: _listWidget(context, _)),
        );
      },
    );
  }
}

_listWidget(BuildContext context, ProfileController _) {
  final responsive = Responsive.of(context);

  TextStyle styleTitle = TextStyle(
    fontSize: responsive.hp(2),
    fontWeight: FontWeight.w400,
    color: Colors.black87, //Colors.indigo,
  );
  TextStyle styleSubTitle = TextStyle(
    fontSize: responsive.hp(1.8),
    fontWeight: FontWeight.w400,
    color: Colors.black38, //Colors.indigo,
  );

  return ListView(
    shrinkWrap: true,
    physics: BouncingScrollPhysics(),
    children: [
      ListTile(
        leading: Icon(
          FontAwesomeIcons.user,
          color: AppColors.primaryColor,
        ),
        title: Text(
          _.user.username,
          style: styleTitle,
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            'Usuario',
            style: styleSubTitle,
          ),
        ),
      ),
      lineSeparator(),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.idCard,
          color: AppColors.primaryColor,
        ),
        title: Text(
          _.user.name != null ? '${_.user.name} ${_.user.lastname}' : '',
          style: styleTitle,
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            'Nombre y apellido',
            style: styleSubTitle,
          ),
        ),
        onTap: () {},
      ),
      lineSeparator(),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.building,
          color: AppColors.primaryColor,
        ),
        title: Text(
          '${_.user.sanatorio.descripcion}',
          style: styleTitle,
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            'Microfranquicia',
            style: styleSubTitle,
          ),
        ),
        onTap: () {},
      ),
      lineSeparator(),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.mobileAlt,
          color: AppColors.primaryColor,
        ),
        title: Text(
          _.user.phonenumber != null ? _.user.phonenumber : '',
          style: styleTitle,
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            'Número de celular',
            style: styleSubTitle,
          ),
        ),
        trailing: Icon(_.user.phonenumber == null
            ? FontAwesomeIcons.plusCircle
            : FontAwesomeIcons.edit),
        onTap: () => _.showDialog('Celular', '', 'celular', _.user.phonenumber),
      ),
      lineSeparator(),
      lineSeparator(),
      ListTile(
        leading: Icon(
          FontAwesomeIcons.at,
          color: AppColors.primaryColor,
        ),
        title: Text(
          _.user.email != null ? _.user.email : '',
          style: styleTitle,
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            'Correo electrónico',
            style: styleSubTitle,
          ),
        ),
        trailing: Icon(_.user.email == null
            ? FontAwesomeIcons.plusCircle
            : FontAwesomeIcons.edit),
        onTap: () =>
            _.showDialog('Correo electrónico', '', 'correo', _.user.email),
      ),
      lineSeparator(),
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          leading: Icon(
            Icons.exit_to_app_outlined,
            color: AppColors.primaryColor,
          ),
          title: Text(
            'Cerrar sesión',
            style: styleTitle,
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            //  launchDialogCerrarSesion(context);
            _.homeController.launchDialogCerrarSesion();
          },
        ),
      ),
      lineSeparator(),
    ],
  );
}
