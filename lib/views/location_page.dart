import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neopop/neopop.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_project/utils/utils.dart';
import 'package:wedding_project/widgets/custom_widgets.dart';
import '../controllers/settings_controller.dart';

class LocationPage extends StatefulHookConsumerWidget {
  const LocationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationPageState();
}

class _LocationPageState extends ConsumerState<LocationPage> {
  openMaps() async {
    final Uri googleMapsUri =
        Uri.parse(LangTextConstants.url_wedding_invite_maps);

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      Future.microtask(
        () => GlobalMessenger.showSnackBarMessage(
            context: context, error: 'Not able to open Maps'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langNow = ref.watch(currentLangProvider);
    final settingsController = ref.watch(settingsControllerProvider.notifier);
    return Responsive(
      mobile: Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          title: LangTextConstants.lbl_address.tr,
          actions: [
            Text(langNow.name),
            LanguageChangeButton(
              handleLanguageSelect: settingsController.setLanguage,
              localeSelected: langNow.languageCode,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.location_city_outlined,
                size: 60,
              ),
            ),
            Center(
              child: Card(
                // color: theme.canvasColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LangTextConstants.val_address.tr,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: NeoPopTiltedButton(
                  onTapUp: () => openMaps(),
                  isFloating: true,
                  enabled: true,
                  decoration: NeoPopTiltedButtonDecoration(
                    color: theme.colorScheme.primary,
                    plunkColor: theme.colorScheme.primary,
                    shadowColor: const Color.fromRGBO(36, 36, 36, 1),
                    showShimmer: true,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70.0,
                      vertical: 15,
                    ),
                    child: Center(
                      child: Text(
                        LangTextConstants.lbl_maps_location.tr,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
