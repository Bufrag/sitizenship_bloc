import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sitizenship_bloc/blocs/country_bloc.dart';
import 'package:sitizenship_bloc/model/country_model.dart';
import 'package:sitizenship_bloc/providers/button_provider.dart';

import '../screen/detail_country_page.dart';

class ListViewHome extends ConsumerStatefulWidget {
  const ListViewHome({super.key});

  @override
  ConsumerState<ListViewHome> createState() => _ListTileForHomeState();
}

class _ListTileForHomeState extends ConsumerState<ListViewHome> {
  final UserBloc _userBloc = UserBloc();

  @override
  void initState() {
    try {
      _userBloc.add(GetUserList());
    } catch (e) {
      print(
          'Error adding event to UserBloc: $e'); //  это для отслеживания исключений
    }
    ref.read(isEuropeProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: _buildCountries(),
    );
  }

  Container _buildCountries() {
    return Container(
      height: 450,
      width: double.infinity,
      child: BlocProvider(
        create: (context) => _userBloc,
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
                return _buildListView(context, state.countries);
              } else if (state is UserError) {
                return Container();
              }
              throw Exception("Ошибка");
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildListView(BuildContext context, List<Countries> countries) {
    final europeanContry = ref.watch(isEuropeProvider);
    final popularContry = ref.watch(isPopularProvider);
    final fastPassportContry = ref.watch(isFastPassportProvider);
    List<Countries> filtredCountry = countries;
    if (europeanContry == true) {
      filtredCountry = countries.where((country) => country.isEuropen).toList();
    }
    if (popularContry == true) {
      filtredCountry = countries.where((country) => country.isPopular).toList();
    }
    if (fastPassportContry == true) {
      filtredCountry =
          countries.where((country) => country.isFastPassport).toList();
    }

    return AnimationLimiter(
      child: ListView.separated(
          padding: const EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  // key: ValueKey<int>(index),
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    curve: Curves.bounceIn,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage(filtredCountry[index].imageUrl),
                              fit: BoxFit.fill),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.9), // Цвет тени
                              spreadRadius: 2, // Распространение тени
                              blurRadius: 7, // Размытие тени
                              offset: const Offset(0,
                                  0), // Смещение тени по горизонтали и вертикали
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      width: 320,
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3)),
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          filtredCountry[index].name.length <=
                                                  10
                                              ? filtredCountry[index].name
                                              : '${filtredCountry[index].name.substring(0, 10)}...',
                                          style: const TextStyle(
                                              fontSize: 40,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 65,
                                          height: 65,
                                          child: SvgPicture.network(
                                              filtredCountry[index].imagePath),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailCountryPage(
                                                userBloc: _userBloc,
                                                countries:
                                                    filtredCountry[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Viev more ->",
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 45, bottom: 30),
                          //   child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         Text(
                          //           filtredCountry[index].name.length <= 10
                          //               ? filtredCountry[index].name
                          //               : '${filtredCountry[index].name.substring(0, 10)}...',
                          //           style: const TextStyle(
                          //               fontSize: 30,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //         Text(
                          //           countries[index].taxRate,
                          //           style: const TextStyle(
                          //               fontSize: 30,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ]),
                          // ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width / 1,
                          //   height: MediaQuery.of(context).size.height / 7,
                          //   child: SvgPicture.network(
                          //       filtredCountry[index].imagePath),
                          // ),
                          // const SizedBox(
                          //   height: 30,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.all(16.0),
                          //       child: InkWell(
                          //         onTap: () {
                          //           Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //               builder: (context) => DetailCountryPage(
                          //                 userBloc: _userBloc,
                          //                 countries: filtredCountry[index],
                          //               ),
                          //             ),
                          //           );
                          //         },
                          //         child: Container(
                          //           height: 60,
                          //           width: 150,
                          //           decoration: BoxDecoration(
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Colors.grey.shade400,
                          //                 blurRadius: 2.0, // Soften the shaodw
                          //                 spreadRadius: 1.0,
                          //                 offset: const Offset(0.0, 0.0),
                          //               )
                          //             ],
                          //             borderRadius: BorderRadius.circular(50),
                          //             color: Colors.white,
                          //           ),
                          //           child: const Center(
                          //             child: Text(
                          //               "View country",
                          //               style: TextStyle(
                          //                   color: Colors.black,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 14),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: filtredCountry.length),
    );
  }
}
