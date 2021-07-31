part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // late User? user;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    getPengiriman();
    getUser();
  }

  void getPengiriman() async {
    await context.read<PesananCubit>().getPesanan();
  }

  void getUser() async {
    // UserLocalTable userLocalTable = UserLocalTable();
    // User? data = await userLocalTable.getUser();
    // setState(() {
    //   user = data;
    // });
    await context.read<UserCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: mainColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 5),
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 270,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            margin: EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/ic-search.png'),
                              ),
                            ),
                          ),
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(
                                'Cari Nomor Pesanan Disini',
                                textStyle: blackFontStyle3.copyWith(
                                    color: Colors.white),
                              )
                            ],
                            repeatForever: true,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(() => ProfilePage());
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: BlocBuilder<UserCubit, UserState>(
                          builder: (context, state) {
                            if (state is UserLoadedSuccess) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: (state.user.fotoKurir != imageUrl)
                                      ? state.user.fotoKurir!
                                      : 'https://picsum.photos/id/5/400/400',
                                  placeholder: (context, url) =>
                                      loadingIndicator,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://picsum.photos/id/5/400/400',
                                  placeholder: (context, url) =>
                                      loadingIndicator,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<PesananCubit, PesananState>(builder: (_, state) {
              if (state is PesananLoadedSuccess) {
                return Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      CustomTabbar(
                        selectedIndex: selectedIndex,
                        titles: ['Dikirim', 'Terkirim'],
                        onTap: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Builder(builder: (_) {
                        List<Pesanan> listPesanan = (selectedIndex == 0)
                            ? state.pesanan
                                .where((item) => item.status == 4)
                                .toList()
                            : state.pesanan
                                .where((item) => item.status == 5)
                                .toList();
                        if (listPesanan.length > 0) {
                          return SingleChildScrollView(
                            child: Column(
                              children: listPesanan
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            () => DetailOrderPage(pesanan: e));
                                      },
                                      child: ItemOrder(
                                        pesanan: e,
                                        tglPemesanan: DateFormat(
                                                'yMMMMEEEEd', 'id')
                                            .format(
                                                DateTime.parse(e.tglPemesanan)),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        } else {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            child: Column(
                              children: [
                                Lottie.asset(
                                  'assets/empty-box.json',
                                  width: 200,
                                  height: 200,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Data Pengiriman Kosong',
                                  style: blackFontStyle3,
                                )
                              ],
                            ),
                          );
                        }
                      })
                    ],
                  ),
                );
              } else {
                return Center(
                  child: loadingIndicator,
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
