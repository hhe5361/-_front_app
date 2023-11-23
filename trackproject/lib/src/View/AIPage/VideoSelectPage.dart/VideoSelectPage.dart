import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AIPage/VideoSelectPage.dart/SelectLocalVideoPage.dart';
import 'package:trackproject/src/View/AIPage/VideoSelectPage.dart/SelectYoutube.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class SelectVideoPage extends StatefulWidget {
  const SelectVideoPage({super.key});

  @override
  State<SelectVideoPage> createState() => _SelectVideoPageState();
}

class _SelectVideoPageState extends State<SelectVideoPage>
    with SingleTickerProviderStateMixin {
  List<dynamic> pages = [
    YoutubeLinkPage(),
    const SelectLocalVideo(),
  ];
  int _currentapge = 0;

  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,

    /// 탭 변경 애니메이션 시간
    animationDuration: const Duration(milliseconds: 800),
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _tabBar() {
    return TabBar(
      controller: tabController,
      onTap: (index) {
        setState(() {
          _currentapge = index;
        });
      },
      labelColor: Colors.black,
      //unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(
        fontSize: 13,
      ),

      /// 탭바 클릭할 때 나오는 splash effect의 radius
      splashBorderRadius: BorderRadius.circular(10),

      /// 기본 인디캐이터의 컬러
      indicatorColor: Colors.greenAccent,

      indicatorWeight: 3.5,

      indicatorSize: TabBarIndicatorSize.label,

      /// 탭바의 상하좌우에 적용하는 패딩
      padding: const EdgeInsets.fromLTRB(5, 1.5, 5, 3),

      /// 라벨에 주는 패딩
      labelPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),

      /// 인디캐이터의 패딩
      indicatorPadding: const EdgeInsets.symmetric(vertical: 10),

      tabs: const [
        Tab(
          text: "유튜브 링크",
        ),
        Tab(
          text: "Local video",
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: myappbar2("동영상 선택"),
        body:
            Column(children: [_tabBar(), Expanded(child: pages[_currentapge])])
        //     SingleChildScrollView(
        //   physics: const ClampingScrollPhysics(),
        //   child: Column(children: [
        //     _tabBar(),
        //      Expanded(child: pages[_currentapge])

        //   ]),
        // )
        );
  }
}
