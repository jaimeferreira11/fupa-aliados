import 'package:flutter/material.dart';
import 'package:fupa_aliados/app/data/providers/local/cache.dart';
import 'package:fupa_aliados/app/globlas_widgets/line_separator_widget.dart';
import 'package:fupa_aliados/app/helpers/responsive.dart';
import 'package:fupa_aliados/app/modules/home/home_controller.dart';
import 'package:fupa_aliados/app/theme/colors.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class DrawerView extends GetView<HomeController> {
  const DrawerView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    List<Widget> drawerOptions = [];
    for (var i = 0; i < controller.drawerItems.length; i++) {
      var d = controller.drawerItems[i];
      var selected = i == controller.selectedDrawerIndex;
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon,
            size: responsive.dp(2.5),
            color: selected ? AppColors.primaryColor : Colors.black54),
        title: new Text(
          d.title,
          style: TextStyle(
              fontSize: responsive.dp(2.2),
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              color: selected ? AppColors.primaryColor : Colors.black54),
        ),
        selected: selected,
        onTap: () => controller.onSelectItem(i),
      ));
    }

    return Container(
      color: Colors.white,
      width: responsive.wp(70),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            //  decoration: BoxDecoration(color: AppColors.accentColor),
            accountName: new Text(
              Cache.instance.user.username,
              style: TextStyle(
                  fontSize: responsive.dp(2), fontStyle: FontStyle.italic),
            ),
            accountEmail: new Text(
              Cache.instance.user.sanatorio?.descripcion,
              style: TextStyle(
                fontSize: responsive.dp(1.7),
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? AppColors.accentColor
                  : Colors.white,
              child: Text(
                Cache.instance.user.username.substring(0, 1).toUpperCase(),
                style: TextStyle(
                    fontSize: responsive.hp(7),
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor),
              ),
            ),
          ),
          Column(children: drawerOptions),
        ],
      ),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
