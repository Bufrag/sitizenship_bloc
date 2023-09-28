import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sitizenship_bloc/blocs/country_bloc.dart';

import 'package:sitizenship_bloc/screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        // HomeWidget(),
      ),
    );
  }
}

// class FirebaseList extends StatefulWidget {
//   const FirebaseList({super.key});

//   @override
//   State<FirebaseList> createState() => _FirebaseListState();
// }

// class _FirebaseListState extends State<FirebaseList> {
//   final ref = FirebaseDatabase.instance.ref("countries");
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//               child: FirebaseAnimatedList(
//                   padding: EdgeInsets.all(30),
//                   query: ref,
//                   itemBuilder: (context, snapshot, animation, index) {
//                     return ListTile(
//                       title: Text(snapshot.child("Name").value.toString()),
//                     );
//                   }))
//         ],
//       ),
//     );
//   }
// }
