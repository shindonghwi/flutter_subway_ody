import 'package:flutter/material.dart';


extension StyleColor on ColorScheme{

  Color get colorPrimary => brightness == Brightness.light ? const Color(0xFFFC4F00) : const Color(0xFFFC4F00);

  Color get black => brightness == Brightness.light ? const Color(0xFF000000) : const Color(0xFF000000);
  Color get white => brightness == Brightness.light ? const Color(0xFFFFFFFF) : const Color(0xFFFFFFFF);
  Color get light => brightness == Brightness.light ? const Color(0xFFFDFDFD) : const Color(0xFFFDFDFD);

  Color get colorLine1 => brightness == Brightness.light ? const Color(0xFF0052A4) : const Color(0xFF0052A4);
  Color get colorLine2 => brightness == Brightness.light ? const Color(0xFF00A84D) : const Color(0xFF00A84D);
  Color get colorLine3 => brightness == Brightness.light ? const Color(0xFFEF7C1C) : const Color(0xFFEF7C1C);
  Color get colorLine4 => brightness == Brightness.light ? const Color(0xFF00A5DE) : const Color(0xFF00A5DE);
  Color get colorLine5 => brightness == Brightness.light ? const Color(0xFF996CAC) : const Color(0xFF996CAC);
  Color get colorLine6 => brightness == Brightness.light ? const Color(0xFFCD7C2F) : const Color(0xFFCD7C2F);
  Color get colorLine7 => brightness == Brightness.light ? const Color(0xFF747F00) : const Color(0xFF747F00);
  Color get colorLine8 => brightness == Brightness.light ? const Color(0xFFE6186C) : const Color(0xFFE6186C);
  Color get colorLine9 => brightness == Brightness.light ? const Color(0xFFBDB092) : const Color(0xFFBDB092);
  Color get colorLineGyeonguiCentral => brightness == Brightness.light ? const Color(0xFF77C4A3) : const Color(0xFF77C4A3);
  Color get colorLineSuinBundang => brightness == Brightness.light ? const Color(0xFFF5A200) : const Color(0xFFF5A200);
  Color get colorLineGyeongchun => brightness == Brightness.light ? const Color(0xFF0C8E72) : const Color(0xFF0C8E72);
  Color get colorLineNewParty => brightness == Brightness.light ? const Color(0xFFD4003B) : const Color(0xFFD4003B);
  Color get colorLineAirportRailroad => brightness == Brightness.light ? const Color(0xFF0090D2) : const Color(0xFF0090D2);
  Color get colorLineNewUisun => brightness == Brightness.light ? const Color(0xFFB0CE18) : const Color(0xFFB0CE18);

}