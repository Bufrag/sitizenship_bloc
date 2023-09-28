import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sitizenship_bloc/blocs/country_bloc.dart';
import 'package:sitizenship_bloc/providers/favourite_country.dart';
import 'package:sitizenship_bloc/screen/detail_clone.dart';
import 'package:sitizenship_bloc/screen/detail_country_page.dart';

import '../model/country_model.dart';

class FavouriteCountry extends ConsumerStatefulWidget {
  const FavouriteCountry({super.key});

  @override
  ConsumerState<FavouriteCountry> createState() => _FavouriteCountryState();
}

class _FavouriteCountryState extends ConsumerState<FavouriteCountry> {
  @override
  Widget build(BuildContext context) {
    final List<Countries> favorite = ref.watch(favoriteCountriesProvider);
    if (favorite.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Favorite",
            style: GoogleFonts.openSans(),
          ),
        ),
        body: const Center(
          child: Text(
            "Empty",
            style: TextStyle(fontSize: 40),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Favorite",
            style: GoogleFonts.openSans(),
          ),
        ),
        body: ListView.builder(
          itemCount: favorite.length,
          // Countries.getFavouritesCountry.length,
          itemBuilder: (context, index) => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                foregroundDecoration: BoxDecoration(
                    border: Border.all(color: Colors.amber, width: 0.9)),
                height: 70,
                color: Colors.black.withOpacity(0.2),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: SvgPicture.network(
                          favorite[index].imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            favorite[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                          Text(favorite[index].taxRate,
                              style: const TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => DetailClone(
                              countries: favorite[index],
                              selectedIndex: index,
                            ),
                          ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}
