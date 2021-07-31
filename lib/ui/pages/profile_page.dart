part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FToast? fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
    getUserExisting();
  }

  void getUserExisting() async {
    await context.read<UserCubit>().getUserExisting();
  }

  void logout() async {
    await context.read<UserCubit>().logoutUser();
    UserState state = context.read<UserCubit>().state;

    if (state is UserActionSuccess) {
      Get.offAll(() => LoginPage());
    } else {
      showToast(fToast!, (state as UserActionFailed).message, isError: true);
    }
  }

  void uploadPhoto(User user) async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      File pictureFile = File(xFile.path);
      await context.read<UserCubit>().updatePhotoProfile(pictureFile, user);

      UserState state = context.read<UserCubit>().state;

      if (state is UserActionSuccess) {
        showToast(fToast!, state.message, isError: false);
        Get.offAll(() => MainPage());
      } else {
        showToast(fToast!, (state as PesananActionFailed).message,
            isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhotoProfileProvider>(
      create: (context) => PhotoProfileProvider(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (_, state) {
          if (state is UserLoadedSuccess) {
            User user = state.user;
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Align(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 60,
                            padding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 25),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.offAll(
                                      () => MainPage(),
                                    );
                                  },
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/ic-arrow.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'Profile Kurir',
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
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250,
                              color: mainColor.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Consumer<PhotoProfileProvider>(
                                    builder:
                                        (context, photoProfileProvider, _) =>
                                            Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.only(bottom: 15),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: (photoProfileProvider
                                                      .photoProfile !=
                                                  "")
                                              ? photoProfileProvider
                                                  .photoProfile
                                              : (user.fotoKurir != null &&
                                                      user.fotoKurir !=
                                                          imageUrl)
                                                  ? user.fotoKurir!
                                                  : 'https://picsum.photos/id/5/400/400',
                                          placeholder: (context, url) =>
                                              loadingIndicator,
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error_outline),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${user.namaKurir}',
                                    style: blackFontStyle3.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    '${user.emailKurir}',
                                    style: blackFontStyle3.copyWith(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: mainColor.withOpacity(0.6),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      ProfileOption(
                                        onTap: () {
                                          Get.off(() => EditProfilePage());
                                        },
                                        icon: Icons.person_outline,
                                        title: 'Edit Profile',
                                      ),
                                      ProfileOption(
                                        onTap: () {
                                          Get.offAll(
                                              () => ChangePasswordPage());
                                        },
                                        icon: Icons.change_circle_outlined,
                                        title: 'Perbaharui Password',
                                      ),
                                      Consumer<PhotoProfileProvider>(
                                        builder: (context, photoProfileProvider,
                                                _) =>
                                            ProfileOption(
                                          icon:
                                              Icons.photo_camera_front_rounded,
                                          title: 'Perbaharui Photo Profile',
                                          onTap: () {
                                            uploadPhoto(state.user);
                                          },
                                        ),
                                      ),
                                      ProfileOption(
                                        icon: Icons.logout,
                                        title: 'Logout',
                                        onTap: () {
                                          logout();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: loadingIndicator,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
