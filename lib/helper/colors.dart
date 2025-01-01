import 'package:flutter/material.dart';

// RADIO

const Color colorRadioSelectedBlueBr = Color(0xFF64FFDA);
const Color colorRadioSelected = Color.fromRGBO(29, 233, 182, 1);

// ERROR

// TEXT
const Color colorText = Color.fromARGB(255, 36, 48, 86);
const Color colorWhite = Color(0xFFFFFFFF);
const Color colorBackgroundWhite = Color(0xFFECECEE);
const Color colorBlack = Color(0xFF000000);

// PRIMARY
const Color colorPrimary = Colors.blue;
const Color colorPrimary01 = Color.fromRGBO(100, 181, 246, 1);

const Color colorBackgroundPrimary = Color(0xFFf3f8fc);

// MAIN
const Color colorMain = Color(0xFFed1941); // Color.fromARGB(255, 16, 158, 40);
const Color colorTransparent = Colors.transparent;
const Color colorMainCover = Color.fromARGB(222, 255, 86, 34);
const Color colorFlashDeals = Color.fromARGB(222, 242, 117, 72);

const Color colorMainCover1 = Color.fromARGB(222, 241, 92, 47);
const Color colorItemCover = Color.fromRGBO(158, 158, 158, 1);
const Color colorBlackTileItem = Color.fromARGB(255, 13, 13, 13);

// const Color colorBackgroundPrimary = Color(0xFFf3f8fc);

// SECONDARY
const Color colorSecondary01 = Color(0xFFD3EFFD);
const Color colorSecondary02 = Color(0xFFF4F9FF);
const Color colorSecondary03 = Color(0xFF53B5F8);
const Color colorSecondary04 = Color(0xFF377EAE);
const Color colorSecondary05 = Color(0xFF1D4862);

// RATTING
const Color colorRatting = Colors.amber;

// THIRD
const Color colorThird01 = Color(0xFFD8F9FA);
const Color colorThird02 = Color(0xFF85EAF0);
const Color colorThird03 = Color(0xFF5DC6CE);
const Color colorThird04 = Color(0xFF3D878D);
const Color colorThird05 = Color(0xFF1D4446);

// FOURTH
const Color colorFourth01 = Color(0xFFFFFED6);
const Color colorFourth02 = Color(0xFFFFFD99);
const Color colorFourth03 = Color(0xFFFFFC31);
const Color colorFourth04 = Color(0xFFCCC900);
const Color colorFourth05 = Color(0xFF8F8C00);

// SUCCESS
const Color colorSuccess01 = Color(0xFFBCF5E1);
const Color colorSuccess02 = Color(0xFF4BDBA9);
const Color colorSuccess03 = Color(0xFF009963);
const Color colorSuccess04 = Color(0xFF006642);
const Color colorSuccess05 = Color(0xFF004D32);
const Color colorSuccess06 = Color(0xffDDEADA);

// ERROR
const Color colorError01 = Color(0xFFFDEDEF);
const Color colorError02 = Color(0xFFF7B6BD);
const Color colorError03 = Color(0xFFE81737);
const Color colorError04 = Color(0xFFB20E27);
const Color colorError05 = Color(0xFF6F0B1A);

// WARNING
const Color colorWarning01 = Color(0xFFFFE5BF);
const Color colorWarning02 = Color(0xFFFFC670);
const Color colorWarning03 = Color(0xFFFF9D0A);
const Color colorWarning04 = Color(0xFFB86E00);
const Color colorWarning05 = Color(0xFF7A4900);

// GRAY
const Color colorGray01 = Color(0xFFF2F4F5);
const Color colorGray02 = Color(0xFFD3D8DE);
const Color colorGray03 = Color(0xFFA3A8AD);
const Color colorGray04 = Color(0xFF606366);
const Color colorGray05 = Color(0xFF2F3133);
const Color colorGray06 = Color(0xFF18191A);

// BLUE GRAY
const Color colorBlueGray01 = Color(0xFFEBF0F5);
const Color colorBlueGray02 = Color(0xFFA2ADB8);
const Color colorBlueGray03 = Color(0xFF5C6F82);
const Color colorBlueGray04 = Color(0xFF2B4259);
const Color colorBlueGray05 = Color(0xFF152D45);

// LIGHT BLUE
const Color colorLightBlue01 = Color(0xFFF5F9FC);
const Color colorLightBlue02 = Color(0xFFF2F7FC);
const Color colorLightBlue03 = Color(0xFFEDF5FC);
const Color colorLightBlue04 = Color(0xFFEDF5FC);
const Color colorLightBlue05 = Color(0xFFF2F4F7);

const List<Color> gradientRadial01 = [
  Color(0xFF05B7FE),
  Color(0xFF0D54D9),
];

// App color
const Color colorPink = Colors.pink;
const Color colorOrange = Colors.orange;
const Color colorGrey = Colors.grey;
const Color colorRed = Colors.red;
const Color colorGreen = Colors.green;
const Color colorBlue = Colors.blue;
const Color textInput = const Color.fromRGBO(227, 242, 253, 1);

const List<Color> gradientRadialBlack01 = [
  Color(0xFF32312A),
  Color(0xFF181B24),
];

Color convertHexToColor(String hexString) {
  if (hexString == null || hexString.isEmpty) {
    return Colors.orange;
  }
  if (hexString[0] == '#') {
    hexString = hexString.substring(1);
  }

  if (hexString.length == 6) {
    hexString = 'FF' + hexString;
  }

  int colorValue = int.parse(hexString, radix: 16);

  return Color(colorValue);
}
