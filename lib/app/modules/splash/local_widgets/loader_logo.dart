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
                    SlideInLeft(
                        child: Center(
                      child: Text(
                        'Aliados',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: responsive.dp(5)),
                      ),
                    )),
                    SizedBox(
                      height: responsive.hp(2),
                    ),
                    BounceInDown(
                        delay: Duration(milliseconds: 1000),
                        child: Image(
                          height: responsive.hp(10),
                          image: AssetImage(
                            'assets/images/logo_fp_blanco.png',
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
                    )
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
