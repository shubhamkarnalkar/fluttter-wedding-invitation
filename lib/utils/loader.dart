import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wedding_project/utils/utils.dart';
import 'package:wedding_project/widgets/custom_widgets.dart';
import 'package:lottie/lottie.dart';

final loadingMessageProvider = StateProvider.autoDispose<String>((ref) {
  return 'Processing....';
});

class Loader extends ConsumerStatefulWidget {
  const Loader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoaderState();
}

class _LoaderState extends ConsumerState<Loader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sizedBoxH20(),
              Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  shape: BoxShape.rectangle,
                ),
                child: Lottie.asset(
                  LottieConsts.spaceMan,
                  decoder: (bytes) => CustomConvert.customDecoder(bytes),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                ref.watch(loadingMessageProvider),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
