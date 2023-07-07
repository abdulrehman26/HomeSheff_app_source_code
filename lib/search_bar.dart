// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class searchbar extends StatefulWidget {
//   @override
//   _searchbarState createState() => _searchbarState();
// }
//
// class _HomeScreenState extends State<searchbar> {
//   TextEditingController _searchController = TextEditingController();
//   bool _isSearchBarActive = false;
//
//   void _searchPressed() {
//     setState(() {
//       _isSearchBarActive = !_isSearchBarActive;
//       if (!_isSearchBarActive) {
//         _searchController.clear();
//       }
//     });
//   }
//
//   void _onSearchTextChanged(String value) {
//     // Handle search query changes
//   }
//
//   void _onSearchSubmitted(String value) {
//     // Handle search submission
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: AppBar(
//           title: _isSearchBarActive
//               ? TextField(
//             controller: _searchController,
//             style: TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               hintText: 'Search',
//               hintStyle: TextStyle(color: Colors.white70),
//             ),
//             onChanged: _onSearchTextChanged,
//             onSubmitted: _onSearchSubmitted,
//           )
//               : Text('My App'),
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(_isSearchBarActive ? Icons.close : Icons.search),
//               onPressed: _searchPressed,
//             ),
//           ],
//         ),
//       ),
//       // AppBar(
//       //   backgroundColor: Color(0xff9161AB),
//       //   centerTitle: true,
//       //   actions: [
//       //     IconButton(
//       //       icon: Icon(Icons.search),
//       //       onPressed: () {
//       //       },
//       //     ),
//       //     IconButton(
//       //       icon: Icon(Icons.notifications),
//       //       onPressed: () {
//       //         showNoNotificationsAlert();
//       //       },
//       //     ),
//       //
//       //   ],
//       //   leading: IconButton(
//       //     icon: Icon(Icons.menu),
//       //     onPressed: () {
//       //       _scaffoldKey.currentState?.openDrawer();
//       //     },
//       //   ),
//       //
//       //
//       //   title: Text(
//       //     '${widget.getemail}',
//       //     style: GoogleFonts.montserrat(
//       //       color: Colors.white,
//       //       fontSize: 16.0,
//       //     ),
//       //   ),
//       // ),
//       body: Center(
//         child: Text('Content goes here'),
//       ),
//     );
//   }
// }
