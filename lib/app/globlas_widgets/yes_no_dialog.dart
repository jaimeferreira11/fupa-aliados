import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';

class DialogoSiNo {
  Future<int> abrirDialogoSiNo(String titulo, String mensaje) async =>
      await Get.dialog<int>(
        _DialogSiNo(
          titulo: titulo,
          mensaje: mensaje,
        ),
        useSafeArea: true,
        barrierDismissible: false,
      );

  Future<int> abrirDialogo(String titulo, String mensaje) async =>
      await Get.dialog<int>(
        _Dialog(
          titulo: titulo,
          mensaje: mensaje,
        ),
        useSafeArea: true,
        barrierDismissible: false,
      );

  Future<int> abrirDialogoSucccess(String mensaje) async =>
      await Get.dialog<int>(
        _DialogSuccess(
          titulo: "Proceso exitoso",
          mensaje: mensaje,
        ),
        useSafeArea: true,
        barrierDismissible: false,
      );

  Future<int> abrirDialogoError(String mensaje) async => await Get.dialog<int>(
        _DialogError(
          titulo: "Atención, no se completó la operación",
          mensaje: mensaje,
        ),
        useSafeArea: true,
        barrierDismissible: false,
      );
}

class _Dialog extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _Dialog({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _StackDialog(
          mensaje: mensaje,
          titulo: titulo,
        ),
      ),
    );
  }
}

class _DialogSiNo extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _DialogSiNo({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _StackDialogSiNo(
          mensaje: mensaje,
          titulo: titulo,
        ),
      ),
    );
  }
}

class _DialogSuccess extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _DialogSuccess({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _StackDialogSuccess(
          mensaje: mensaje,
          titulo: titulo,
        ),
      ),
    );
  }
}

class _DialogError extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _DialogError({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _StackDialogError(
          mensaje: mensaje,
          titulo: titulo,
        ),
      ),
    );
  }
}

class _StackDialog extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _StackDialog({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 35.0,
            right: 20,
            bottom: 20.0,
          ),
          margin: EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: _Formulario(
            mensaje: mensaje,
            titulo: titulo,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                "assets/images/ic_launcher.png",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StackDialogSiNo extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _StackDialogSiNo({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 40.0,
            right: 20,
            bottom: 20.0,
          ),
          margin: EdgeInsets.only(top: 50.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: _FormularioSiNo(
            mensaje: mensaje,
            titulo: titulo,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                "assets/images/ic_launcher.png",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StackDialogSuccess extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _StackDialogSuccess({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 35.0,
            right: 20,
            bottom: 20.0,
          ),
          margin: EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: _FormularioSuccess(
            mensaje: mensaje,
            titulo: titulo,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Container(
                  color: Colors.white,
                  height: 100,
                  width: 100,
                  child: Icon(
                    FontAwesomeIcons.checkCircle,
                    color: Colors.green.shade700,
                    size: 60,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

class _StackDialogError extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _StackDialogError({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 20,
            top: 35.0,
            right: 20,
            bottom: 20.0,
          ),
          margin: EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: _FormularioError(
            mensaje: mensaje,
            titulo: titulo,
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(300),
                child: Container(
                  color: Colors.white,
                  height: 100,
                  width: 100,
                  child: Icon(
                    FontAwesomeIcons.timesCircle,
                    color: Colors.red.shade700,
                    size: 60,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

class _Formulario extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _Formulario({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 180, maxHeight: 200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            titulo,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            mensaje,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  AppColors.secondaryColor,
                ),
              ),
              child: Text(
                'Aceptar',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onPressed: () => Get.back(result: 0),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormularioSiNo extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _FormularioSiNo({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 180, maxHeight: 200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
          ),
          Text(
            titulo,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            mensaje,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red.shade700,
                    ),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () => Get.back(result: 0),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () => Get.back(result: 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FormularioSuccess extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _FormularioSuccess({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 150, maxHeight: 220),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: TextStyle(
                color: Colors.green.shade700,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          lineSeparator(),
          SizedBox(
            height: 10,
          ),
          Text(
            mensaje,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () => Get.back(result: 1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FormularioError extends StatelessWidget {
  final String titulo;
  final String mensaje;

  const _FormularioError({@required this.titulo, @required this.mensaje});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 150, maxHeight: 250),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            titulo,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 18,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 5,
          ),
          lineSeparator(),
          SizedBox(
            height: 10,
          ),
          Text(
            mensaje ?? '',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 90, maxWidth: 150),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryColor,
                    ),
                  ),
                  child: Text(
                    'Aceptar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
