import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/theme/colors.dart';

class LoaderLogo extends StatelessWidget {
  const LoaderLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.darkColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 0.7],
          )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    ZoomIn(
                        delay: Duration(milliseconds: 800),
                        child: Hero(
                          tag: 'login',
                          child: Image(
                            height: responsive.hp(15),
                            image: AssetImage(
                              'assets/images/logo_blanco.png',
                            ),
                          ),
                        )),
                    SizedBox(
                      height: responsive.hp(2),
                    ),
                    ZoomIn(
                        delay: Duration(milliseconds: 800),
                        child: Center(
                          child: Text(
                            'Aliados',
                            style: TextStyle(
                                fontFamily: "Candara",
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: responsive.dp(5)),
                          ),
                        )),
                    Spacer(
                      flex: 1,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 5,
                    ),
                    Spacer(
                      flex: 4,
                    ),
                    BounceInUp(
                        delay: Duration(milliseconds: 1000),
                        child: Container(
                          margin: EdgeInsets.only(bottom: responsive.hp(1)),
                          child: Image(
                            height: responsive.hp(7),
                            image: AssetImage(
                              'assets/images/logo_fp_blanco.png',
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
