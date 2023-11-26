import 'package:flutter/material.dart';
import 'package:trackproject/src/View/AIPage/RecordSelectPage/LiveRecordPage.dart';
import 'package:trackproject/src/View/AIPage/RecordSelectPage/SelectLocalRecordPage.dart';
import 'package:trackproject/src/utilities/MyTheme.dart';

class RecordSelectPage extends StatefulWidget {
  const RecordSelectPage({super.key});

  @override
  State<RecordSelectPage> createState() => _RecordSelectPageState();
}

class _RecordSelectPageState extends State<RecordSelectPage>
    with SingleTickerProviderStateMixin {
  List<dynamic> pages = [const LiveRecordPage(), const SelectLocalAudio()];

  int _currentapge = 0;

  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
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
        Tab(text: "실시간 녹음"),
        Tab(text: "내 파일"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: myappbar2("음성 선택"),
        body: Column(children: [_tabBar(), pages[_currentapge]]));
  }
}
