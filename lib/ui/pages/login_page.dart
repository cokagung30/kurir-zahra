part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
          child: Container(
            margin: EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Silahkan Login',
                          style: blackFontStyle1.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 25),
                          width: 280,
                          child: Text(
                            'Silahkan masukkan email & password yang sudah didaftarkan',
                            style: blackFontStyle3.copyWith(fontSize: 14),
                          ),
                        ),
                        CustomInput(
                          title: 'Email',
                          hint: "Inputkan email anda",
                          controller: emailController,
                          isPassword: false,
                          isShow: false,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer<PasswordVisibility>(
                          builder: (context, passwordVisibility, _) =>
                              CustomInput(
                            title: 'Password',
                            hint: "Inputkan password anda",
                            controller: passwordController,
                            isPassword: true,
                            isShow: passwordVisibility.isHidden,
                            onChange: (show) {
                              passwordVisibility.isHidden = show;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Consumer<LoadingShowing>(
                          builder: (context, loading, _) => (loading.isShowing)
                              ? loadingIndicator
                              : CustomButton(
                                  width: double.infinity,
                                  buttonTitle: "Login Sekarang",
                                  onPress: () async {
                                    loading.isShowing = true;
                                    await context.read<UserCubit>().signIn(
                                        emailController.text,
                                        passwordController.text);

                                    UserState state =
                                        context.read<UserCubit>().state;

                                    if (state is UserActionSuccess) {
                                      loading.isShowing = false;
                                      Get.offAll(() => MainPage());
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
                                      loading.isShowing = false;
                                    }
                                  },
                                  typeButton: 1,
                                ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
