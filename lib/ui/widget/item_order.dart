part of 'widget.dart';

class ItemOrder extends StatelessWidget {
  final Pesanan pesanan;
  final String tglPemesanan;

  ItemOrder({required this.pesanan, required this.tglPemesanan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 10,
        top: 10,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pesanan.noPesanan}',
                style: blackFontStyle2.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${pesanan.qty} items • " +
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                        .format(pesanan.totalBayar),
                style: blackFontStyle3.copyWith(
                    fontSize: 13, color: "000000".toColor().withOpacity(0.25)),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tglPemesanan,
                style: blackFontStyle3.copyWith(fontSize: 12),
              ),
              (pesanan.status == 5)
                  ? Text(
                      'Dikirim',
                      style: blackFontStyle3.copyWith(
                        color: "1ABC9C".toColor(),
                        fontSize: 12,
                      ),
                    )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
