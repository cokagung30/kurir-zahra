part of 'pages.dart';

class DetailOrderPage extends StatefulWidget {
  final Pesanan pesanan;

  DetailOrderPage({required this.pesanan});

  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  bool isExpand = true;
  bool isLoading = false;
  FToast? fToast;
  List<DetailPesanan> listDetail = <DetailPesanan>[];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    getDetailOrder();
  }

  void getDetailOrder() async {
    DetailPesananLocalTable detailPesananLocalTable = DetailPesananLocalTable();
    List<DetailPesanan> details =
        await detailPesananLocalTable.select(widget.pesanan.id);

    setState(() {
      listDetail = details;
    });
  }

  launchWhatsapp() async {
    final link = WhatsAppUnilink(
        phoneNumber: widget.pesanan.noTelpPelanggan,
        text:
            'Hai ${widget.pesanan.namaPelanggan} pesananmu dengan nomor pesanan ${widget.pesanan.noPesanan} sudah sampai, terima kasih');

    await launch('$link');
  }

  launchPhoneTelp() async {
    await launch('tel://${widget.pesanan.noTelpPelanggan}');
  }

  launchMaps() async {
    MapsLauncher.launchQuery('${widget.pesanan.alamatPengiriman}');
  }

  void takePictures() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (xFile != null) {
      File pictureFile = File(xFile.path);
      await context
          .read<PesananCubit>()
          .uploadProofSend(pictureFile, widget.pesanan.id);

      PesananState state = context.read<PesananCubit>().state;

      if (state is PesananActionSuccess) {
        showToast(fToast!, state.message, isError: false);
        Get.offAll(() => MainPage());
      } else {
        setState(() {
          isLoading = false;
        });
        showToast(fToast!, (state as PesananActionFailed).message,
            isError: true);
      }
    }
  }

  Widget statusOrderElement(int type) {
    if (widget.pesanan.status == 5 && type == 1) {
      return Container(
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.only(
            top: 10,
          ),
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Row(
            children: [
              Icon(
                Icons.date_range_sharp,
                size: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, bottom: 12, top: 16),
                    child: Text(
                      'Tanggal Pengiriman',
                      style: blackFontStyle3.copyWith(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Text(
                      DateFormat('yMMMMEEEEd', 'id').format(
                          DateTime.parse(widget.pesanan.tglPengiriman!)),
                      style: blackFontStyle3.copyWith(
                          color: "414B5A".toColor(), fontSize: 12),
                    ),
                  )
                ],
              ),
            ],
          ));
    } else if (widget.pesanan.status == 4 && type == 2) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Center(
          child: CustomButton(
            onPress: () {
              setState(() {
                isLoading = true;
              });
              takePictures();
            },
            buttonTitle: 'Pesanan Terkirim',
            width: double.infinity,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width - 85 - 30 - 45;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 25,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.offAll(() => MainPage());
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/ic-arrow.png'),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Detail Pesanan',
                              style: blackFontStyle3.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchWhatsapp();
                              },
                              child: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchPhoneTelp();
                              },
                              child: FaIcon(
                                FontAwesomeIcons.phone,
                                size: 14,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchMaps();
                              },
                              child: FaIcon(
                                FontAwesomeIcons.map,
                                size: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      (widget.pesanan.status == 4)
                          ? 'Pesanan Akan Dikirim'
                          : 'Pesanan Berhasil Dikirim',
                      style: blackFontStyle3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: (widget.pesanan.status == 4)
                          ? "4361ee".toColor()
                          : "1abc9c".toColor(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'No. Pesanan #${widget.pesanan.noPesanan}',
                        style: blackFontStyle3.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        print(isExpanded);
                        setState(() {
                          if (isExpanded) {
                            isExpand = false;
                          } else {
                            isExpand = true;
                          }
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                'Daftar Pesanan',
                                style: blackFontStyle3.copyWith(
                                    color: "282828".toColor(), fontSize: 14),
                              ),
                            );
                          },
                          body: Column(
                            children: listDetail
                                .map((detail) => OrderItem(
                                    detail: detail, itemWidth: itemWidth))
                                .toList(),
                          ),
                          isExpanded: isExpand,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 5, top: 16),
                                child: Text(
                                  'Alamat Penerima',
                                  style: blackFontStyle3.copyWith(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: Text(
                                  widget.pesanan.alamatPengiriman,
                                  style: blackFontStyle3.copyWith(
                                      color: "414B5A".toColor(), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 5, top: 16),
                                child: Text(
                                  'Tanggal Pemesanan',
                                  style: blackFontStyle3.copyWith(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: Text(
                                  DateFormat('yMMMMEEEEd', 'id').format(
                                      DateTime.parse(
                                          widget.pesanan.tglPemesanan)),
                                  style: blackFontStyle3.copyWith(
                                      color: "414B5A".toColor(), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    statusOrderElement(1),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 5, top: 16),
                                child: Text(
                                  'Pelanggan',
                                  style: blackFontStyle3.copyWith(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: Text(
                                  widget.pesanan.namaPelanggan,
                                  style: blackFontStyle3.copyWith(
                                      color: "414B5A".toColor(), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.money,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 5, top: 16),
                                child: Text(
                                  'Biaya Antar',
                                  style: blackFontStyle3.copyWith(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(widget.pesanan.biayaAntar),
                                  style: blackFontStyle3.copyWith(
                                      color: "414B5A".toColor(), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.payment,
                            size: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 5, top: 16),
                                child: Text(
                                  'Total Bayar',
                                  style: blackFontStyle3.copyWith(fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                                child: Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp. ',
                                          decimalDigits: 0)
                                      .format(widget.pesanan.totalBayar),
                                  style: blackFontStyle3.copyWith(
                                      color: "414B5A".toColor(), fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (isLoading) ? loadingIndicator : statusOrderElement(2),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
