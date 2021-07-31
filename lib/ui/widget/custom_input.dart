part of 'widget.dart';

class CustomInput extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  final bool isShow;
  final Function(bool show)? onChange;
  final bool isNumber;

  CustomInput(
      {required this.title,
      required this.hint,
      required this.controller,
      this.isPassword = true,
      this.isShow = true,
      this.onChange,
      this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            '$title',
            style: blackFontStyle3.copyWith(
                fontSize: 14, fontWeight: FontWeight.normal, color: greyColor),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: greyColor2)),
          child: (isPassword)
              ? TextField(
                  controller: controller,
                  obscureText: isShow,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: greyFontStyle,
                      hintText: hint,
                      suffixIcon: IconButton(
                        icon: Icon(
                            isShow ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          if (isShow) {
                            onChange!(false);
                          } else {
                            onChange!(true);
                          }
                        },
                      )),
                )
              : (isNumber)
                  ? TextField(
                      controller: controller,
                      obscureText: isPassword,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: greyFontStyle,
                        hintText: hint,
                      ),
                    )
                  : TextField(
                      controller: controller,
                      obscureText: isPassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: greyFontStyle,
                        hintText: hint,
                      ),
                    ),
        )
      ],
    );
  }
}
