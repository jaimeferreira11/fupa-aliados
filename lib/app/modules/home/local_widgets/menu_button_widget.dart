import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';

class MenuButtonWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final String route;

  const MenuButtonWidget(
      {Key key,
      @required this.icon,
      this.color = AppColors.primaryColor,
      @required this.text,
      @required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return _CardBackground(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: this.color,
          child: Icon(
            this.icon,
            size: responsive.dp(5),
            color: Colors.white,
          ),
          radius: responsive.dp(5.5),
        ),
        SizedBox(height: responsive.hp(1.7)),
        Text(
          this.text,
          style: TextStyle(
              color: this.color,
              fontWeight: FontWeight.w500,
              fontSize: responsive.dp(2.3)),
        )
      ],
    ));
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Container(
      margin: EdgeInsets.all(responsive.dp(1.5)),
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
            padding: EdgeInsets.symmetric(vertical: responsive.hp(3.3)),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: this.child,
          ),
        ),
      ),
    );
  }
}
