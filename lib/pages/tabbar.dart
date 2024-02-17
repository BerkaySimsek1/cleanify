import 'package:cleanify/pages/post.dart';
import 'package:cleanify/pages/tabs/account.dart';
import 'package:cleanify/pages/tabs/map.dart';
import 'package:flutter/material.dart';
import 'package:cleanify/elements/project_elements.dart';
import 'package:cleanify/pages/tabs/home.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({Key? key}) : super(key: key);

  @override
  State<MainTabBar> createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> with TickerProviderStateMixin {
  late final TabController tabController;
  late int currentTabIndex;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    currentTabIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: const CommonAppbar(preference: "menu"),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: const [MyHomePage(), MapPage(), AccountPage()]),
            bottomNavigationBar: BottomAppBar(
                notchMargin: 10,
                child: TabBar(
                    labelColor: ProjectColors.optionalTextColor2,
                    unselectedLabelColor:
                        ProjectColors.projectSecondaryWidgetColor,
                    onTap: (int index) {
                      setState(() {
                        currentTabIndex = index;
                      });
                      switch (currentTabIndex) {
                        case 0:
                          debugPrint("Currently in Home tab");
                          break;
                        case 1:
                          debugPrint("Currently in Map tab");
                          break;
                        case 2:
                          debugPrint("Currently in Account tab");
                          break;
                        default:
                          debugPrint("Unknown tab");
                      }
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    isScrollable: false,
                    indicatorColor: ProjectColors.projectDefaultColor,
                    controller: tabController,
                    tabs: const [
                      Tab(
                          text: "Home",
                          icon: Icon(Icons.house_outlined, size: 22)),
                      Tab(
                          text: "Map",
                          icon: Icon(Icons.location_pin, size: 22)),
                      Tab(
                          text: "Account",
                          icon: Icon(Icons.account_circle_outlined, size: 22))
                    ]))));
  }
}

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String preference;

  const CommonAppbar({Key? key, required this.preference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        backgroundColor: ProjectColors.projectPrimaryWidgetColor,
        leading: IconButton(
            onPressed: () {
              if (preference == "back") {
                Navigator.of(context).pop(null);
              }
            },
            icon: preference == "back"
                ? const Icon(Icons.arrow_back)
                : const Icon(Icons.menu)),
        title: const Center(child: Text("Cleanify")),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
