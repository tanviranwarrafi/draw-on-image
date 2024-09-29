const _APP_ICONS = 'assets/app_icons';
const _BACKGROUNDS = 'assets/backgrounds';
const _PNG_IMAGES = 'assets/png_images';
const _SVG_ICONS = 'assets/svg_icons';
const _SVG_IMAGES = 'assets/svg_images';

class Assets {
  Assets._();
  static _PngImages png_image = _PngImages();
  static _SvgIcons svg = _SvgIcons();
}

class _PngImages {
  _PngImages();
  String no_camera = '$_PNG_IMAGES/no_camera.png';
}

class _SvgIcons {
  _SvgIcons();
  String arrow_elbow_up_left = '$_SVG_ICONS/arrow_elbow_up_left.svg';
  String arrow_elbow_up_right = '$_SVG_ICONS/arrow_elbow_up_right.svg';
  String arrow_left = '$_SVG_ICONS/arrow_left.svg';
  String camera = '$_SVG_ICONS/camera.svg';
  String check = '$_SVG_ICONS/check.svg';
  String close = '$_SVG_ICONS/close.svg';
  String crop = '$_SVG_ICONS/crop.svg';
  String image_square = '$_SVG_ICONS/image_square.svg';
  String info = '$_SVG_ICONS/info.svg';
  String lightning_1 = '$_SVG_ICONS/lightning_1.svg';
  String lightning_2 = '$_SVG_ICONS/lightning_2.svg';
  String pencil = '$_SVG_ICONS/pencil.svg';
}
