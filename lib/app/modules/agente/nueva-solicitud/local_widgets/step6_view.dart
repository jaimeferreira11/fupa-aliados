import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/agente/nueva-solicitud/nueva_solicitud_controller.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';

class Step6View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudController>(
        id: 'adjuntos',
        builder: (_) => Container(
                child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceAround,
                  children: _.cedulas
                      .map((e) => Stack(
                            children: [
                              Image.file(
                                File(e.path),
                                width: responsive.wp(40),
                                height: responsive.hp(15),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: SafeArea(
                                  child: CupertinoButton(
                                    color: Colors.black38,
                                    padding: EdgeInsets.all(1),
                                    borderRadius: BorderRadius.circular(30),
                                    child: Icon(
                                      FontAwesomeIcons.times,
                                      size: responsive.dp(2.5),
                                    ),
                                    onPressed: () {
                                      _.cedulas.remove(e);
                                      _.update(['adjuntos']);
                                    },
                                  ),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
                SizedBox(height: responsive.hp(1)),
                Container(
                  margin: EdgeInsets.only(bottom: responsive.hp(0.3)),
                  child: Center(
                      child: Text(
                    '* Adjunte 2 (dos) imagenes',
                    style: TextStyle(color: Colors.green.shade700),
                  )),
                ),
                MaterialButton(
                  elevation: 5.0,
                  color: Colors.blueGrey.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () async {
                    final origen = await _.dialogSelectOrigen();
                    print(origen);
                    if (origen != null && origen > 0) {
                      _.adjuntarCI(origen);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: responsive.hp(6),
                    color: Colors.transparent,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.addressCard,
                            color: Colors.white,
                          ),
                          Text(
                            '   ADJUNTAR CI',
                            style: AppFonts.secondaryFont.copyWith(
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontSize: responsive.dp(1.5),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(2)),
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceAround,
                  children: _.inforconf
                      .map((e) => Stack(
                            children: [
                              Image.file(
                                File(e.path),
                                width: responsive.wp(25),
                                height: responsive.hp(12),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: CupertinoButton(
                                  color: Colors.black38,
                                  padding: EdgeInsets.zero,
                                  borderRadius: BorderRadius.circular(30),
                                  child: Icon(
                                    FontAwesomeIcons.times,
                                    size: responsive.dp(2.5),
                                  ),
                                  onPressed: () {
                                    _.inforconf.remove(e);
                                    _.update(['adjuntos']);
                                  },
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
                SizedBox(height: responsive.hp(1)),
                Container(
                  margin: EdgeInsets.only(bottom: responsive.hp(0.3)),
                  child: Center(
                      child: Text(
                    '* Adjunte al menos una imagen',
                    style: TextStyle(color: Colors.green.shade700),
                  )),
                ),
                MaterialButton(
                  elevation: 5.0,
                  color: Colors.blueGrey.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () async {
                    final origen = await _.dialogSelectOrigen();
                    if (origen != null && origen > 0) {
                      _.adjuntarInforconf(origen);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: responsive.hp(6),
                    color: Colors.transparent,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.fileInvoice,
                            color: Colors.white,
                          ),
                          Text(
                            '  ADJUNTAR AUTOR. INFORCONF',
                            style: AppFonts.secondaryFont.copyWith(
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontSize: responsive.dp(1.5),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(2)),
                _.fotoCliente != null
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.file(
                            _.fotoCliente,
                            width: responsive.wp(50),
                            height: responsive.hp(15),
                          ),
                          Positioned(
                            right: responsive.wp(20),
                            top: 0,
                            child: CupertinoButton(
                              color: Colors.black38,
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(30),
                              child: Icon(
                                FontAwesomeIcons.times,
                                size: responsive.dp(2.5),
                              ),
                              onPressed: () {
                                _.fotoCliente = null;
                                _.update(['adjuntos']);
                              },
                            ),
                          )
                        ],
                      )
                    : Container(),
                SizedBox(height: responsive.hp(1)),
                Container(
                  margin: EdgeInsets.only(bottom: responsive.hp(0.3)),
                  child: Center(
                      child: Text(
                    '* Adjunte una imagen',
                    style: TextStyle(color: Colors.green.shade700),
                  )),
                ),
                MaterialButton(
                  elevation: 5.0,
                  color: Colors.blueGrey.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () async {
                    final origen = await _.dialogSelectOrigen();
                    print(origen);
                    if (origen != null && origen > 0) {
                      _.adjuntarFotoCliente(origen);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: responsive.hp(6),
                    color: Colors.transparent,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.camera,
                            color: Colors.white,
                          ),
                          Text(
                            '  ADJUNTAR FOTO CLIENTE',
                            style: AppFonts.secondaryFont.copyWith(
                                letterSpacing: 1.5,
                                color: Colors.white,
                                fontSize: responsive.dp(1.5),
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(5)),
              ],
            )));
  }
}
