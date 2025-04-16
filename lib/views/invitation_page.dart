import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wedding_project/utils/utils.dart';
import 'package:wedding_project/widgets/custom_widgets.dart';
import '../controllers/settings_controller.dart';

class InvitationPage extends HookConsumerWidget {
  const InvitationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final langNow = ref.watch(currentLangProvider);
    final settingsController = ref.watch(settingsControllerProvider.notifier);
    return Responsive(
      mobile: Scaffold(
        appBar: CustomAppBar(
          centerTitle: true,
          // title: LangTextConstants.lbl_address.tr,
          actions: [
            Text(langNow.name),
            LanguageChangeButton(
              handleLanguageSelect: settingsController.setLanguage,
              localeSelected: langNow.languageCode,
            ),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 400,
                width: 400,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    ImageConstant.invitation,
                    fit: BoxFit.contain,
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
