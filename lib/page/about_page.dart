import 'package:clover/services/auth_services.dart';
import 'package:clover/shared/theme.dart';
import 'package:clover/widget/custom_about_tile.dart';
import 'package:clover/widget/custom_button.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    handleLogout() async {
      bool? logout = await AuthServices().removeToken();
      if (logout ?? true) {
        Navigator.pushNamed(context, '/login');
        // print(authProvider.token?.token);
      }
    }

    Widget content() {
      return Column(
        children: [
          CustomAboutTile(
            iconUrl: 'assets/User.png',
            title: 'Profil',
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          CustomAboutTile(
            iconUrl: 'assets/Location.png',
            title: 'Alamat',
            onPressed: () {},
          ),
          CustomAboutTile(
            iconUrl: 'assets/card.png',
            title: 'Pembayaran',
            onPressed: () {},
          ),
          CustomAboutTile(
            icon: Icons.settings_outlined,
            title: 'Pengaturan',
            onPressed: () {},
          ),
        ],
      );
    }

    Widget logoutButton() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: CustomeButton(
          text: 'Logout',
          onPressed: handleLogout,
          color: kRedColor,
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Akun',
          style: blackTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              height: 1,
              color: borderColor,
            ),
            preferredSize: const Size.fromHeight(5)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          content(),
          const Spacer(),
          logoutButton(),
        ],
      ),
    );
  }
}
