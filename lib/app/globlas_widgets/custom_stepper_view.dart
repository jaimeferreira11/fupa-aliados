import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';

class CustomStepperView extends StatelessWidget {
  final CoolStep step;
  final VoidCallback onStepNext;
  final VoidCallback onStepBack;

  const CustomStepperView({
    Key key,
    @required this.step,
    this.onStepNext,
    this.onStepBack,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final title = Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                step.title.toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                maxLines: 2,
              ),
            ),
          ]),
          SizedBox(height: 5.0),
          Text(
            step.subtitle,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );

    final content = Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: step.content,
      ),
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title, content],
      ),
    );
  }
}
