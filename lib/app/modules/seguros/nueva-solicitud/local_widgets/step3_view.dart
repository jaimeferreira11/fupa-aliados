import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';

import '../nueva_solicitud_seguros_controller.dart';

class Step3View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(Get.context);
    return GetBuilder<NuevaSolicitudSegurosController>(
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
                      .map((e) => Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Stack(
                              children: [
                                Image.file(
                                  File(e.path),
                                  width: responsive.wp(80),
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
                            ),
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
              ],
            )));
  }
}
