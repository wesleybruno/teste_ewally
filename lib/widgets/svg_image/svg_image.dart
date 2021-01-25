import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String icone;
  final Color cor;

  const SvgImage({
    Key key,
    @required this.icone,
    this.cor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icone,
      color: cor,
      matchTextDirection: true,
    );
  }
}
