part of 'widget.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final String? buttonTitle;
  final Function() onPress;
  final int? typeButton;
  final bool isRed;

  CustomButton(
      {this.width,
      this.buttonTitle,
      required this.onPress,
      this.typeButton,
      this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      child: RaisedButton(
        onPressed: onPress,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: (typeButton == 2)
            ? Colors.white
            : (isRed)
                ? Colors.redAccent
                : mainColor,
        child: Text(
          '$buttonTitle',
          style: blackFontStyle3.copyWith(
            fontSize: 16,
            color: (isRed) ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
