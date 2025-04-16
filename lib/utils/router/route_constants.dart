part of 'router_imports.dart';

class RouteConstants {
  static const String home = 'Home';
  static const String settings = 'Settings';

  // These are the navigation screens on the home screen
  static const List<NavigationDestination> navigationItems = [
    NavigationDestination(
      icon: Icon(Icons.person_2_outlined),
      selectedIcon: Icon(Icons.person_2),
      label: 'Bride',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_4_outlined),
      selectedIcon: Icon(Icons.person_4_rounded),
      label: 'Groom',
    ),
    NavigationDestination(
      icon: Icon(Icons.location_on_outlined),
      selectedIcon: Icon(Icons.location_on),
      label: 'Location',
    ),
    NavigationDestination(
      icon: Icon(Icons.insert_invitation_outlined),
      selectedIcon: Icon(Icons.insert_invitation),
      label: 'Invitation',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_applications_outlined),
      selectedIcon: Icon(Icons.settings_applications_rounded),
      label: 'Settings',
    ),
  ];

  static List<NavigationRailDestination> getRailItems(
      ThemeData navRailStyle, int selectedNav) {
    return RouteConstants.navigationItems
        .map(
          (NavigationDestination destination) => NavigationRailDestination(
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
            label: Container(
              width: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: navigationItems.indexWhere(
                            (element) => element.label == destination.label) ==
                        selectedNav
                    ? navRailStyle.hoverColor
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      destination.label,
                      style: navRailStyle.textTheme.bodyLarge,
                    ),
                    Text(
                        style: navRailStyle.textTheme.bodyLarge!.copyWith(
                          color: navRailStyle.colorScheme.onPrimary,
                        ),
                        navigationItems.indexWhere((element) =>
                                    element.label == destination.label) ==
                                selectedNav
                            ? '●'
                            : ''),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  static Builder navigationWindow({
    required List<NavigationRailDestination> destinations,
    double width = 72,
    int? selectedIndex,
    Widget? leading,
    Widget? trailing,
    void Function(int)? onDestinationSelected,
    required ThemeData theme,
  }) {
    return Builder(builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(color: theme.canvasColor),
        width: width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: leading ?? const SizedBox(),
                        ),
                        for (final dest in destinations)
                          InkWell(
                            onTap: () => onDestinationSelected,
                            child: SizedBox(
                              child: dest.label,
                            ),
                          ),
                        trailing ?? const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  /// returns the widget for the body part
  static Widget getScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const BridePage();
      case 1:
        return const GroomPage();
      case 2:
        return const LocationPage();
      case 3:
        return const InvitationPage();
      case 4:
        return const SettingsPage();
      default:
        return const Text('Something went wrong');
    }
  }
}
