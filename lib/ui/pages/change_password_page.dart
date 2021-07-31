part of 'pages.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  User? data;
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserExisting();
  }

  void getUserExisting() async {
    UserLocalTable userLocalTable = UserLocalTable();
    User? user = await userLocalTable.getUser();
    setState(() {
      emailController.text = (user != null) ? user.emailKurir : "";
      data = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PasswordVisibility>(
          create: (context) => PasswordVisibility(),
        ),
        ChangeNotifierProvider<LoadingShowing>(
          create: (context) => LoadingShowing(),
        )
      ],
      child: Scaffold(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 25),
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
                            'Perbaharui Password',
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
                          'Perbaharui Password',
                          style: blackFontStyle1.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 25, right: 25, bottom: 25),
                        width: 280,
                        child: Text(
                          'Silahkan perbaharui password anda disini',
                          style: blackFontStyle3.copyWith(fontSize: 14),
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
                        child: Consumer<PasswordVisibility>(
                          builder: (context, passwordVisibility, _) =>
                              CustomInput(
                            title: 'Password Lama',
                            hint: "Password lama anda",
                            controller: oldPasswordController,
                            isPassword: true,
                            isShow: passwordVisibility.isHidden,
                            onChange: (show) {
                              passwordVisibility.isHidden = show;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25, top: 15),
                        child: Consumer<PasswordVisibility>(
                          builder: (context, passwordVisibility, _) =>
                              CustomInput(
                            title: 'Password Baru',
                            hint: "Password baru anda",
                            controller: newPasswordController,
                            isPassword: true,
                            isShow: passwordVisibility.isHidden,
                            onChange: (show) {
                              passwordVisibility.isHidden = show;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        child: Consumer<LoadingShowing>(
                          builder: (context, loading, _) => (loading.isShowing)
                              ? loadingIndicator
                              : CustomButton(
                                  width: double.infinity,
                                  buttonTitle: "Perbaharui Password",
                                  onPress: () async {
                                    loading.isShowing = true;
                                    await context
                                        .read<UserCubit>()
                                        .updatePassword(
                                          emailController.text,
                                          newPasswordController.text,
                                          oldPasswordController.text,
                                        );

                                    UserState state =
                                        context.read<UserCubit>().state;

                                    if (state is UserActionSuccess) {
                                      loading.isShowing = false;
                                      Get.offAll(() => LoginPage());
                                    } else {
                                      Get.snackbar(
                                        "",
                                        "",
                                        backgroundColor: "D9435E".toColor(),
                                        titleText: Text(
                                          (state as UserActionFailed).message,
                                          style: blackFontStyle3.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  typeButton: 1,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
