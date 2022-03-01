import 'package:flutter/material.dart';
import 'package:projeto_integrador_app/app/common/assets.dart';
import 'package:projeto_integrador_app/app/common/styles/constants.dart';
import 'package:projeto_integrador_app/app/common/utility/utility.dart';
import 'package:projeto_integrador_app/app/view/components/my_divider.dart';

class Tile extends StatelessWidget {
  const Tile(
      {Key key,
      this.title,
      this.subtitle,
      this.image,
      this.infoRigth,
      this.infoLeft})
      : super(key: key);

  final String title;
  final String subtitle;
  final String image;
  final Widget infoRigth;
  final Widget infoLeft;

  dynamic _imageBook(String uri) {
    if (uri != null) {
      return Utility.imageFromBase64String(uri);
    }
    return Image.asset(
      ConstantAssets.imgDefault,
      fit: BoxFit.fill,
      height: 160,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          isThreeLine: true,
          // contentPadding:
          //     const EdgeInsets.only(bottom: 0, left: 15, right: 15, top: 10),
          leading: _imageBook(image),
          title: Text(
            title,
            // style: Constants.sdListTitle,
          ),
          subtitle: Column(
            children: [
              Container(
                // margin: const EdgeInsets.symmetric(vertical: 4),
                alignment: Alignment.centerLeft,
                child: Text(
                  subtitle,
                  // style: Constants.sdListSubTitle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: infoLeft ?? Expanded(flex: 1, child: infoLeft),
                  ),
                  Expanded(
                    flex: 2,
                    child: infoRigth ?? Expanded(flex: 2, child: infoRigth),
                  ),
                ],
              ),
            ],
          ),
        ),
        const MyDivider(),
      ],
    );
  }
}
