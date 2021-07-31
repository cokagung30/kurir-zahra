part of 'widget.dart';

class OrderItem extends StatelessWidget {
  final DetailPesanan detail;
  final double itemWidth;

  OrderItem({required this.detail, required this.itemWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: 5,
        top: 5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 15,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            margin: EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: detail.fotoProduk,
                placeholder: (context, url) => loadingIndicator,
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: itemWidth,
                margin: EdgeInsets.only(bottom: 6),
                child: Text(
                  detail.namaProduk,
                  style: blackFontStyle3.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                NumberFormat.currency(
                            locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                        .format(detail.hargaJual) +
                    ' x ' +
                    detail.quantity.toString(),
                style: blackFontStyle3.copyWith(fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subtotal: ',
                    style: blackFontStyle2.copyWith(fontSize: 14),
                  ),
                  Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                        .format(detail.hargaJual * detail.quantity),
                    style: blackFontStyle2.copyWith(
                      fontSize: 14,
                      color: "FA6400".toColor(),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
