# Model-View-ViewModel (MVVM) with the provider package
First, use [riverpod](https://pub.dev/packages/riverpod) or [flutter_bloc](https://pub.dev/packages/flutter_bloc) instead of [provider](https://pub.dev/packages/provider) if I have decision rights.

&nbsp;|Depends on Flutter libraries?|Throws exception?|Catch exceptions?||Note
--|--|--|--|--|--
Model|No|Yes|No|typically contains methods that invoke HTTP communication.
ViewModel (extends [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html))|Yes (except widgets)|No|Yes|You must call [notifyListeners](https://api.flutter.dev/flutter/foundation/ChangeNotifier/notifyListeners.html) each time a model changes.
View|Yes|No|No|uses [ChangeNotifierProvider](https://pub.dev/documentation/provider/latest/provider/ChangeNotifierProvider-class.html) and instantiates a ViewModel within it.

## References
- https://docs.flutter.dev/get-started/fwe/state-management#using-mvvm-for-your-applications-architecture
- https://docs.flutter.dev/data-and-backend/state-mgmt/simple
