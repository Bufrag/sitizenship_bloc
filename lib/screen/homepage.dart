import 'package:flutter/material.dart';
import 'package:sitizenship_bloc/screen/favourite_country_page.dart';

import '../widgets/home_list_view.dart';
import '../widgets/home_page_central_button.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: ListView(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FavouriteCountry(),
                    ));
                  },
                  icon: Icon(Icons.favorite)),
            ],
            padding: EdgeInsets.zero,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              " Find The \n Perfect Country",
              style: TextStyle(fontSize: 39, fontWeight: FontWeight.w900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Discovery the best country for you",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const CentralButton(),
          const ListViewHome(),
        ],
      ),
      // bottomNavigationBar: gnav,
    );
  }
}
