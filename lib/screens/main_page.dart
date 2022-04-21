import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodart/screens/cart_page.dart';
import 'package:foodart/screens/home_screen.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   late PersistentTabController _controller;


@override
  void initState() {
_controller = PersistentTabController(initialIndex: 0);
   
    super.initState();
  }

  
    List<Widget> _buildScreens() {
        return [
         HomeScreen(),
    Container(
      child: Center(
        child: Text("No page Yet"),
      ),
    ),
    CartPage(),
    Container(
      child: Center(
        child: Text("No page Yet"),
      ),)
        ];
    }



    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(Icons.home),
                title: ("Home"),
                activeColorPrimary: AppColors.mainColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(Icons.archive),
                title: ("archive"),
                activeColorPrimary: AppColors.mainColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ), PersistentBottomNavBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                title: ("cart"),
                activeColorPrimary: AppColors.mainColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.person),
                title: ("me"),
                activeColorPrimary: AppColors.mainColor,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        ];
    }
@override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
  // int _selectedIndex = 0;
  // List pages = [
  //   HomeScreen(),
  //   Container(
  //     child: Center(
  //       child: Text("No page Yet"),
  //     ),
  //   ),
  //   CartPage(),
  //   Container(
  //     child: Center(
  //       child: Text("No page Yet"),
  //     ),
  //   ),
  // ];
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //         onTap: (value) {
  //           setState(() {
  //             _selectedIndex = value;
  //           });
  //         },
  //         selectedItemColor: AppColors.mainColor,
  //         unselectedItemColor: Colors.amberAccent,
  //         showSelectedLabels: false,
  //         showUnselectedLabels: false,
  //         currentIndex: _selectedIndex,
  //         items: [
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.home), label: "I dont care"),
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.archive), label: "I dont care"),
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.shopping_cart_outlined), label: "I dont care"),
  //           BottomNavigationBarItem(
  //               icon: Icon(Icons.person), label: "I dont care"),
  //         ]),
  //   );
  // }
}
