import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wedding_project/controllers/settings_controller.dart';
import 'package:wedding_project/utils/utils.dart';
import 'package:wedding_project/views/home_page.dart';
import 'package:wedding_project/widgets/custom_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neopop/neopop.dart';
import '../controllers/auth/auth_controller.dart';

class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final usridContr = useTextEditingController();
    final pwdContr = useTextEditingController();
    final theme = Theme.of(context);
    final langNow = ref.watch(currentLangProvider);
    final ispwdVisible = useState(false);
    final inst = ref.watch(authControllerProvider);
    // Navigate to HomePage if the user is logged in

    if (ref.watch(settingsControllerProvider).isLoggedIn) {
      Future.microtask(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      });
    }

    return Scaffold(
      body: Responsive(
        mobile: _LoginMob(
            theme: theme,
            usridContr: usridContr,
            ispwdVisible: ispwdVisible,
            pwdContr: pwdContr,
            inst: inst,
            langNow: langNow,
            ref: ref),
        tablet: _LoginTablet(
            theme: theme,
            usridContr: usridContr,
            ispwdVisible: ispwdVisible,
            pwdContr: pwdContr,
            inst: inst,
            langNow: langNow,
            ref: ref),
      ),
    );
  }
}

class _LoginTablet extends StatelessWidget {
  const _LoginTablet({
    required this.theme,
    required this.usridContr,
    required this.ispwdVisible,
    required this.pwdContr,
    required this.inst,
    required this.langNow,
    required this.ref,
  });

  final ThemeData theme;
  final TextEditingController usridContr;
  final ValueNotifier<bool> ispwdVisible;
  final TextEditingController pwdContr;
  final AsyncValue<AuthState> inst;
  final Language langNow;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    // Handle login logic
    void handleLogin() async {
      // Replace this with your actual login logic (e.g., an API call)
      if (usridContr.text.isEmpty || pwdContr.text.isEmpty) {
        // Show an error message if login fails
        GlobalMessenger.showSnackBarMessage(
            context: context, error: 'Invalid Password or username');
      } else {
        // On successful login, set the provider to true
        await ref
            .read(authControllerProvider.notifier)
            .login(usridContr.text.trim(), pwdContr.text.trim());
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SizedBox(
          height: 650,
          width: 350,
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Text(
                        LangTextConstants.lbl_welcome_back.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 50,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: FaIcon(
                        Icons.person_outline,
                        size: 30,
                      ),
                      hintText: 'ID',
                    ),
                    controller: usridContr,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    // obscuringCharacter: '●',
                    decoration: InputDecoration(
                      hintText: LangTextConstants.lbl_password.tr,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          ispwdVisible.value = !ispwdVisible.value;
                        },
                        child: ispwdVisible.value
                            ? const FaIcon(
                                Icons.remove_red_eye,
                                size: 30,
                              )
                            : const FaIcon(
                                Icons.remove_red_eye_outlined,
                                size: 30,
                              ),
                      ),
                    ),
                    // obscureText: !ispwdVisible,
                    obscureText: !ispwdVisible.value,
                    controller: pwdContr,
                  ),
                  const SizedBox(height: 10),
                  switch (inst) {
                    AsyncData(value: final _) => const Text(''),
                    AsyncError(:final error) => Text(
                        GlobalMessenger.messageFormatter(error, true)[1],
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.red),
                        maxLines: 1,
                      ),
                    _ => const Text(''),
                  },
                  const SizedBox(height: 10),
                  SizedBox(
                    child: NeoPopTiltedButton(
                      isFloating: true,
                      enabled: inst.isLoading ? false : true,
                      onTapUp: () {
                        inst.isLoading ? null : handleLogin();
                      },
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
                          child: inst.isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : Text(
                                  LangTextConstants.lbl_login.tr,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${langNow.flag} ${langNow.name}'),
                      LanguageChangeButton(
                        handleLanguageSelect: ref
                            .watch(settingsControllerProvider.notifier)
                            .setLanguage,
                        localeSelected:
                            ref.watch(currentLangProvider).languageCode,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginMob extends StatelessWidget {
  const _LoginMob({
    required this.theme,
    required this.usridContr,
    required this.ispwdVisible,
    required this.pwdContr,
    required this.inst,
    required this.langNow,
    required this.ref,
  });

  final ThemeData theme;
  final TextEditingController usridContr;
  final ValueNotifier<bool> ispwdVisible;
  final TextEditingController pwdContr;
  final AsyncValue<AuthState> inst;
  final Language langNow;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    // Handle login logic
    void handleLogin() async {
      // Replace this with your actual login logic (e.g., an API call)
      if (usridContr.text.isEmpty || pwdContr.text.isEmpty) {
        // Show an error message if login fails
        GlobalMessenger.showSnackBarMessage(
            context: context, error: 'Invalid Password');
      } else {
        // On successful login, set the provider to true
        await ref
            .read(authControllerProvider.notifier)
            .login(usridContr.text.trim(), pwdContr.text.trim());
      }
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset(
                ImageConstant.manLoginPageSVG,
                height: 200,
                width: 240,
                alignment: Alignment.centerLeft,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Text(
                        LangTextConstants.lbl_welcome_back.tr,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 50,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      suffixIcon: FaIcon(
                        Icons.person_outline,
                        size: 30,
                      ),
                    ),
                    controller: usridContr,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    // obscuringCharacter: '●',
                    decoration: InputDecoration(
                      hintText: LangTextConstants.lbl_password.tr,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          ispwdVisible.value = !ispwdVisible.value;
                        },
                        child: ispwdVisible.value
                            ? const FaIcon(
                                Icons.remove_red_eye,
                                size: 30,
                              )
                            : const FaIcon(
                                Icons.remove_red_eye_outlined,
                                size: 30,
                              ),
                      ),
                    ),
                    // obscureText: !ispwdVisible,
                    obscureText: !ispwdVisible.value,
                    controller: pwdContr,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: NeoPopTiltedButton(
                      isFloating: true,
                      enabled: inst.isLoading ? false : true,
                      onTapUp: () {
                        inst.isLoading ? null : handleLogin();
                      },
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
                          child: inst.isLoading
                              ? const CircularProgressIndicator.adaptive()
                              : Text(
                                  LangTextConstants.lbl_login.tr,
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${langNow.flag} ${langNow.name}'),
                      LanguageChangeButton(
                        handleLanguageSelect: ref
                            .watch(settingsControllerProvider.notifier)
                            .setLanguage,
                        localeSelected:
                            ref.watch(currentLangProvider).languageCode,
                      ),
                    ],
                  ),
                  switch (inst) {
                    AsyncData(value: final _) => const Text(''),
                    AsyncError(:final error) => Text(
                        GlobalMessenger.messageFormatter(error, true)[1],
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: Colors.red),
                        maxLines: 1,
                      ),
                    _ => const Text(''),
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
