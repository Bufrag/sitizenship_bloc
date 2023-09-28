// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sitizenship_bloc/blocs/country_bloc.dart';
import 'package:sitizenship_bloc/model/country_model.dart';
import 'package:sitizenship_bloc/providers/favourite_country.dart';

class DetailCountryPage extends ConsumerStatefulWidget {
  final UserBloc? userBloc;
  final Countries countries;
  final int? selectedIndex;
  const DetailCountryPage({
    Key? key,
    this.userBloc,
    required this.countries,
    this.selectedIndex,
  }) : super(key: key);

  @override
  ConsumerState<DetailCountryPage> createState() => _DetailCountryPageState();
}

class _DetailCountryPageState extends ConsumerState<DetailCountryPage> {
  @override
  // void initState() {
  //   try {
  //     // widget.userBloc.add(GetUserList());
  //   } catch (e) {
  //     print("Ошибка которую я искал");
  //   }
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   widget.userBloc.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.userBloc!,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserInitial) {
              return _buildLoading();
            } else if (state is UserLoading) {
              return _buildLoading();
            } else if (state is UserLoaded) {
              return _buildDetailPage(context, state.countries);
            } else if (state is UserError) {
              return const Center(
                child: Text("Произошла ошибка"),
              );
            }
            return const Center(
              child: Text("Неизвестное состояние"),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailPage(BuildContext context, List<Countries> countries) {
    final List<Countries> favoriteCountry =
        ref.watch(favoriteCountriesProvider);
    final selectedIndex = ref
        .read(favoriteCountriesProvider.notifier)
        .getIndexOfCountry(widget.countries);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SvgPicture.asset(
                "assets/images/country.svg",
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 350,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    favoriteCountry.contains(widget.countries)
                        ? favoriteCountry[selectedIndex!].name
                        : widget.countries.name,
                    style: const TextStyle(
                      fontSize: 45,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton.outlined(
                      iconSize: 37,
                      highlightColor: Colors.black,
                      onPressed: () {
                        if (favoriteCountry.contains(widget.countries)) {
                          ref
                              .read(favoriteCountriesProvider.notifier)
                              .removeFrotFavorites(widget.countries);
                        } else {
                          ref
                              .read(favoriteCountriesProvider.notifier)
                              .addToFavorites(widget.countries);
                        }
                      },
                      color: (favoriteCountry.contains(widget.countries)
                          ? Colors.red
                          : Colors.grey),
                      // color: (Countries.getFavouritesCountry
                      //         .contains(widget.countries)
                      //     ? Colors.red
                      //     : Colors.grey),
                      // onPressed: () {
                      //   setState(() {
                      //     if (Countries.getFavouritesCountry
                      //         .contains(widget.countries)) {
                      //       Countries.removeFavouritesCountries(widget.countries);
                      //     } else {
                      //       Countries.addToFavouritesCountries(widget.countries);
                      //     }
                      //   });
                      // },
                      icon: Icon(Icons.save)
                      // Icon(Countries.getFavouritesCountry
                      //         .contains(widget.countries)
                      //     ? Icons.favorite
                      //     : Icons.favorite_outlined),
                      )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.people_outline_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text(
                      ": ${widget.countries.population}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              Text(
                "Tax Rate:  ${widget.countries.taxRate}%",
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              const Divider(
                height: 1,
              ),
              Text(
                "Passport : ${widget.countries.years}",
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              const Divider(
                height: 1,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  "Description",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text(
                "Full Description",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
              shadowColor: const MaterialStatePropertyAll(Colors.black),
              elevation: const MaterialStatePropertyAll(3),
              minimumSize: const MaterialStatePropertyAll<Size>(Size(350, 60)),
              shape: MaterialStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              backgroundColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(236, 181, 28, 1))),
          child: const Text(
            "Discovery more",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ));
  }

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );
}
