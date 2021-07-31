part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User? user;
  FToast? fToast;
  bool isLoading = false;
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController noWaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    getUser();
  }

  void getUser() async {
    UserLocalTable userLocalTable = UserLocalTable();
    User? data = await userLocalTable.getUser();
    setState(() {
      user = data;
      namaController.text = (data != null) ? data.namaKurir : "";
      emailController.text = (data != null) ? data.emailKurir : "";
      alamatController.text = (data != null) ? data.alamat! : "";
      noTelpController.text = (data != null) ? data.noTelp : "";
      noWaController.text = (data != null) ? data.noWa : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(
                              () => ProfilePage(),
                            );
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
                          'Edit Profile',
                          style: blackFontStyle3.copyWith(
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Text(
                        'Perbaharui Profile',
                        style: blackFontStyle1.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                      width: 280,
                      child: Text(
                        'Silahkan perbaharui data diri anda disini',
                        style: blackFontStyle3.copyWith(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: CustomInput(
                        title: 'Nama Lengkap',
                        hint: "Inputkan nama lengkap anda",
                        controller: namaController,
                        isPassword: false,
                        isShow: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: CustomInput(
                        title: 'Email',
                        hint: "Inputkan email anda",
                        controller: emailController,
                        isPassword: false,
                        isShow: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: CustomInput(
                        title: 'No Telp',
                        hint: "Inputkan nomor telp anda",
                        controller: noTelpController,
                        isPassword: false,
                        isNumber: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: CustomInput(
                        title: 'No Whatsapp',
                        hint: "Inputkan nomor whatsapp anda",
                        controller: noWaController,
                        isPassword: false,
                        isNumber: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                      child: CustomInput(
                        title: 'Alamat',
                        hint: "Inputkan alamat anda",
                        controller: alamatController,
                        isPassword: false,
                        isNumber: false,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      child: (isLoading)
                          ? Center(
                              child: loadingIndicator,
                            )
                          : CustomButton(
                              width: double.infinity,
                              buttonTitle: "Perbaharui Data",
                              onPress: () {
                                setState(() {
                                  isLoading = true;
                                });
                                updateProfile();
                              },
                              typeButton: 1,
                            ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateProfile() async {
    User values = User(
      id: user!.id,
      namaKurir: namaController.text,
      emailKurir: emailController.text,
      noTelp: noTelpController.text,
      alamat: alamatController.text,
      noWa: noWaController.text,
      fotoKurir: user!.fotoKurir,
      token: user!.token,
    );

    await context.read<UserCubit>().updateProfile(values);
    UserState state = context.read<UserCubit>().state;

    if (state is UserActionSuccess) {
      showToast(fToast!, state.message, isError: false);
      Get.offAll(() => ProfilePage());
    } else {
      setState(() {
        isLoading = false;
      });
      showToast(fToast!, (state as UserActionFailed).message, isError: true);
    }
  }
}
