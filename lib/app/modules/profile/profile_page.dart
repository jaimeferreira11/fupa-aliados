import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/globlas_widgets/custom_painter_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/profile/profile_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'local_widgets/card_profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      child: GetBuilder<ProfileController>(
          builder: (_) => SafeArea(
                child: Container(
                  color: Colors.grey[200],
                  child: Stack(fit: StackFit.expand, children: [
                    CustomPainterWidget3(),
                    Positioned.fill(
                      top: responsive.hp(11),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black26,
                                offset: Offset(.5, .5),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: responsive.dp(5),
                            backgroundColor: Colors.white,
                            child: Text(
                              Cache.instance.user.username
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: responsive.hp(7),
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                        top: responsive.hp(2),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(children: [
                              Text(Cache.instance.user.username,
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      fontStyle: FontStyle.italic,
                                      fontSize: responsive.hp(3),
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: responsive.hp(.5),
                              ),
                              Text(Cache.instance.user.sanatorio.descripcion,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.hp(2.5),
                                      fontWeight: FontWeight.w300))
                            ]))),
                    Positioned(
                        top: responsive.hp(25),
                        child: Container(child: CardProfileWidget()))
                  ]),
                ),
              )),
    );
  }
}
