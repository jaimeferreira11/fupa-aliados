import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/theme/colors.dart';

class LoaderLogo extends StatelessWidget {
  const LoaderLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BounceInDown(
                        delay: Duration(milliseconds: 1000),
                        child: Image(
                          height: 200,
                          image: AssetImage(
                            'assets/images/ic_launcher.png',
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 5,
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
