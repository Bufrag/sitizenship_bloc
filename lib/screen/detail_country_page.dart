// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sitizenship_bloc/blocs/country_bloc.dart';
import 'package:sitizenship_bloc/model/country_model.dart';

class DetailCountryPage extends StatefulWidget {
  final UserBloc? userBloc;
  final Countries countries;
  DetailCountryPage({
    Key? key,
    this.userBloc,
    required this.countries,
  }) : super(key: key);

  @override
  State<DetailCountryPage> createState() => _DetailCountryPageState();
}

class _DetailCountryPageState extends State<DetailCountryPage> {
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
                    widget.countries.name,
                    style: const TextStyle(
                      fontSize: 45,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton.outlined(
                      iconSize: 37,
                      highlightColor: Colors.black,
                      color: (Countries.getFavouritesCountry
                              .contains(widget.countries)
                          ? Colors.red
                          : Colors.grey),
                      onPressed: () {
                        setState(() {
                          if (Countries.getFavouritesCountry
                              .contains(widget.countries)) {
                            Countries.removeFavouritesCountries(
                                widget.countries);
                          } else {
                            Countries.addToFavouritesCountries(
                                widget.countries);
                          }
                        });
                      },
                      icon: Icon(Countries.getFavouritesCountry
                              .contains(widget.countries)
                          ? Icons.favorite
                          : Icons.favorite_outlined))
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
        // Positioned(
        //   top: 20,
        //   left: 10,
        //   right: 300,
        //   bottom: 700,
        //   child: IconButton(
        //       iconSize: 30,
        //       highlightColor: Colors.white,
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       icon: const Icon(
        //         Icons.arrow_back_ios_rounded,
        //         color: Colors.white,
        //       )),
        // ),
      ],
    ));
  }

  // Widget _buildDetailPage(BuildContext context, List<Countries> countries) {
  //   return Scaffold(
  //   body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
  // Container(
  //   decoration: const BoxDecoration(
  //     image: DecorationImage(
  //       fit: BoxFit.cover,
  //       image: NetworkImage(
  //         'https://cdn.pixabay.com/photo/2019/10/21/15/05/rio-de-janeiro-4566312_1280.jpg',
  //       ),
  //     ),
  //   ),
  //   height: 350,
  //   child: Padding(
  //     padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         IconButton.filledTonal(
  //             iconSize: 30,
  //             highlightColor: Colors.black,
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             icon: const Icon(Icons.arrow_back_ios_rounded)),
  //       ],
  //     ),
  //   ),
  // ),
  // Expanded(
  //   child: Container(
  //     width: double.infinity,
  //     height: 500,
  //     color: Colors.white,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Text(
  //           widget.countries.name,
  //             style: const TextStyle(
  //               fontSize: 34,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ),
  // Padding(
  //   padding: const EdgeInsets.only(left: 20),
  //   child: Text(
  //     "Population  ${countries[widget.index].population}",
  //     style: const TextStyle(
  //         fontSize: 17, fontWeight: FontWeight.bold),
  //   ),
  // ),
  // Padding(
  //   padding: const EdgeInsets.only(left: 20),
  //   child: Text(
  //     countries[widget.index].taxRate,
  //     style: const TextStyle(fontSize: 15, color: Colors.grey),
  //   ),
  // ),
  // const SizedBox(
  //   height: 5,
  // ),
  // Text("Passport : ${countries[widget.index].years}"),
  // const SizedBox(
  //   height: 5,
  // ),
  // SizedBox(
  //   width: double.infinity,
  //   height: 100,
  //   child: Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: ListView.separated(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: 10,
  //       itemBuilder: (context, index) => Container(
  //         decoration: BoxDecoration(
  //             color: Colors.grey.shade300.withOpacity(0.9),
  //             borderRadius: BorderRadius.circular(40)),
  //         width: 150,
  //         height: 15,
  //         child: const Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(Icons.bathroom),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             Text(
  //               "Bathroom",
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //           ],
  //         ),
  //       ),
  //       separatorBuilder: (context, index) => const SizedBox(
  //         width: 10,
  //       ),
  //     ),
  //   ),
  // ),
  // const SizedBox(
  //   height: 20,
  // ),
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Text(
  //         "This is Europe:${countries[widget.index].europe} ",
  //         style: const TextStyle(
  //             fontSize: 23, fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //                 ElevatedButton(
  //                   onPressed: () {},
  //                   style: ButtonStyle(
  //                       shadowColor:
  //                           const MaterialStatePropertyAll(Colors.grey),
  //                       elevation: const MaterialStatePropertyAll(20),
  //                       shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
  //                           RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(40))),
  //                       backgroundColor:
  //                           const MaterialStatePropertyAll(Colors.black),
  //                       minimumSize:
  //                           const MaterialStatePropertyAll(Size(45, 65))),
  //                   child: const Padding(
  //                     padding: EdgeInsets.all(8.0),
  //                     child: Text(
  //                       "Buy Now",
  //                       style: TextStyle(color: Colors.white, fontSize: 16),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           // ],
  //         ),
  //       ),
  //     // ),
  //   ]));
  // }

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );
}
