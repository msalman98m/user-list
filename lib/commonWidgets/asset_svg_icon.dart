import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetSvgIcon extends StatelessWidget {
  final String iconName;
  final Color? color;
  final double? height;
  final double? width;
  final Function? onTap;
  final Gradient? gradient;

  const AssetSvgIcon(
    this.iconName, {
    super.key,
    this.color,
    this.height,
    this.width,
    this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon = SvgPicture.asset(
      'assets/svgIcons/$iconName.svg',
      color: gradient == null ? color : null, // Don't apply color if gradient
      height: height,
      width: width,
    );

    if (gradient != null) {
      icon = ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return gradient!.createShader(bounds);
        },
        child: icon,
      );
    }

    return GestureDetector(
      onTap: onTap == null ? null : () => onTap!(),
      child: icon,
    );
  }
}
