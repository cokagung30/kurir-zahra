part of 'widget.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onTap;

  ProfileOption({required this.icon, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 24,
        margin: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  style: blackFontStyle3.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
