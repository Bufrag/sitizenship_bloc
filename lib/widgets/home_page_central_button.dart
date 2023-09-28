import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sitizenship_bloc/constant/constant.dart';
import 'package:sitizenship_bloc/providers/button_provider.dart';

class CentralButton extends ConsumerStatefulWidget {
  const CentralButton({super.key});

  @override
  ConsumerState<CentralButton> createState() => _CentralButtonState();
}

class _CentralButtonState extends ConsumerState<CentralButton> {
  @override
  void initState() {
    super.initState();
    ref.read(isEuropeProvider);
    ref.read(isPopularProvider);
    ref.read(isFastPassportProvider);
  }

  bool isButtonActiveLeft = false;
  bool isButtonActiveMidle = true;
  bool isButtonActiveRight = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        // final isEuropen = ref.read(isEuropeProvider);
        // final isPopular = ref.read(isPopularProvider);
        // final isFastPassport = ref.read(isFastPassportProvider);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                isButtonActiveLeft = true;
                isButtonActiveMidle = false;
                isButtonActiveRight = false;

                setState(() {
                  ref.read(isEuropeProvider.notifier).state = true;
                  ref.read(isPopularProvider.notifier).state = false;
                  ref.read(isFastPassportProvider.notifier).state = false;
                });
              },
              style: isButtonActiveLeft
                  ? ButtonCentralStyle.elevatedButtonStyleActive
                  : ButtonCentralStyle.elevatedButtinStyleInactive,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "European",
                  style: TextStyle(
                      color: isButtonActiveLeft ? Colors.white : Colors.black,
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 14 : 16),
                ),
              ),
            ),
            const VerticalDivider(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isButtonActiveLeft = false;
                  isButtonActiveMidle = true;
                  isButtonActiveRight = false;
                  ref.read(isFastPassportProvider.notifier).state = false;
                  ref.read(isEuropeProvider.notifier).state = false;
                  ref.read(isPopularProvider.notifier).state = true;
                });
              },
              style: isButtonActiveMidle
                  ? ButtonCentralStyle.elevatedButtonStyleActive
                  : ButtonCentralStyle.elevatedButtinStyleInactive,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Popular",
                  style: TextStyle(
                      color: isButtonActiveMidle ? Colors.white : Colors.black,
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 14 : 16),
                ),
              ),
            ),
            const VerticalDivider(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isButtonActiveLeft = false;
                  isButtonActiveMidle = false;
                  isButtonActiveRight = true;
                  ref.read(isFastPassportProvider.notifier).state = true;
                  ref.read(isEuropeProvider.notifier).state = false;
                  ref.read(isPopularProvider.notifier).state = false;
                });
              },
              style: isButtonActiveRight
                  ? ButtonCentralStyle.elevatedButtonStyleActive
                  : ButtonCentralStyle.elevatedButtinStyleInactive,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  "Fast Passport",
                  style: TextStyle(
                      color: isButtonActiveRight ? Colors.white : Colors.black,
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 14 : 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
