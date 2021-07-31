part of 'shared.dart';

Color greyColor = "8D92A3".toColor();
Color greyColor2 = "DCDCDC".toColor();
Color mainColor = "FFC700".toColor();
Color dangerColor = "D9435E".toColor();
Color successColor = "1ABC9C".toColor();
Color infoColor = "0063C6".toColor();

Widget loadingIndicator = SpinKitCircle(
  size: 45,
  color: mainColor,
);

TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle blackFontStyle1 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);

const double defaultMargin = 24;

showToast(FToast fToast, String message, {bool isError = false}) {
  fToast.showToast(
      child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: (isError) ? Colors.redAccent : Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon((isError) ? Icons.error_outline : Icons.check),
        SizedBox(
          width: 12.0,
        ),
        Text("$message"),
      ],
    ),
  ));
}
