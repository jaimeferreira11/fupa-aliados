import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:fupa_aliados/app/theme/fonts.dart';
import 'package:get/get.dart';

class MenuButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String route;
  final bool vertical;
  final String descripcion;

  const MenuButtonWidget(
      {Key key,
      @required this.icon,
      this.color = AppColors.primaryColor,
      this.vertical = true,
      this.descripcion = "",
      @required this.text,
      @required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return _CardBackground(
        route: route,
        child: this.vertical ? _column(responsive) : _row(responsive));
  }

  Widget _column(Responsive responsive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: this.color,
          child: Icon(
            this.icon,
            size: responsive.dp(3),
            color: Colors.white,
          ),
          radius: responsive.dp(4),
        ),
        SizedBox(height: responsive.hp(1.5)),
        FittedBox(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: responsive.wp(1.5)),
            child: Text(
              this.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: this.color,
                  fontWeight: FontWeight.w500,
                  fontSize: responsive.dp(1.8)),
            ),
          ),
        )
      ],
    );
  }

  Widget _row(Responsive responsive) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: this.color,
            child: Icon(
              this.icon,
              size: responsive.dp(3),
              color: Colors.white,
            ),
            radius: responsive.dp(4),
          ),
          SizedBox(width: responsive.wp(2)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: responsive.wp(1.5)),
                    child: Text(
                      this.text,
                      style: TextStyle(
                          color: this.color,
                          fontWeight: FontWeight.w600,
                          fontSize: responsive.dp(2.1)),
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(1)),
                Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: responsive.wp(1.5)),
                    child: Text(
                      descripcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.secondaryFont.copyWith(
                          color: Colors.black54, fontSize: responsive.dp(1.8)),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;
  final String route;

  const _CardBackground({Key key, @required this.route, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Container(
        margin: EdgeInsets.only(
            left: responsive.wp(3),
            right: responsive.wp(3),
            top: responsive.hp(1),
            bottom: responsive.hp(1)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 1.0), //(x,y)

              blurRadius: 6.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: responsive.hp(2)),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: this.child,
            ),
          ),
        ),
      ),
    );
  }
}
