import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:trackproject/src/View/AIPage/GetAiFilePage/ShowAiFile.dart';
import 'package:trackproject/src/View/LoginPage/LoginPage.dart';
import 'package:trackproject/src/provider/GetMakeVideoProvider.dart';
import 'package:trackproject/src/provider/UserProvider.dart';
import 'package:trackproject/src/utilities/Font_const.dart';
import 'package:trackproject/src/utilities/HexColor.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';
import 'package:trackproject/src/utilities/mediasize.dart';
import 'package:trackproject/src/utilities/time_convert.dart';

class MainUserPage extends StatelessWidget {
  const MainUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider _provider = Provider.of<UserProvider>(context, listen: true);
    return _provider.status != LoginStatus.islogin
        ? const LoginPage()
        : myPage(context);
  }

  Widget showMyinfo(BuildContext context) {
    String myname = Provider.of<UserProvider>(context, listen: false).name;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icon/welcomeuser.svg",
          height: mediawidth * 0.5,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("오늘부터 아이돌이 될"), Text("$myname님!")],
        )
      ],
    );
  }

  Widget _recentvideo(BuildContext context, MyFileDetailProvider provider) {
    return ListView.builder(
      itemCount: provider.length,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 13),
            width: mediawidth * 0.6,
            height: mediaheight * 0.13,
            decoration: defaultDecobox(color: ColorGrey),
            child: detailvideo(context, provider.name[index],
                provider.date[index], provider.file[index].path));
      },
    );
  }

  Widget detailvideo(
      BuildContext context, String filename, dynamic date, String path) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowAiFilePage(filepath: path),
            ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filename : $filename",
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(),
          Text(
            "Filedate : $date",
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget myPage(BuildContext context) {
    MyFileDetailProvider provider =
        Provider.of<MyFileDetailProvider>(context, listen: false);
    provider.getAllFiles();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: showMyinfo(context))),
          const Divider(
            color: Colors.black,
          ),
          const Text(
            "최근 제작 영상",
          ),
          Text(
            "최대 15개의 영상만 저장합니다.",
            style: fontDetails(11),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            flex: 9,
            child: Consumer<MyFileDetailProvider>(
              builder: (context, value, child) {
                debugPrint("debug");
                return _recentvideo(context, value);
              },
            ),
          )
        ],
      ),
    );
  }
}
