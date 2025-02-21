import 'package:flutter/widgets.dart';

class LifecycleExampleWidget extends StatefulWidget {
  const LifecycleExampleWidget({
    super.key,
    this.onResumed,
    this.onInactive,
    this.onHide,
    this.onShow,
    this.onPause,
    this.onRestart,
    this.onDetach,
    this.onExitRequested,
  });

  final VoidCallback? onResumed;
  final VoidCallback? onInactive;
  final VoidCallback? onHide;
  final VoidCallback? onShow;
  final VoidCallback? onPause;
  final VoidCallback? onRestart;
  final VoidCallback? onDetach;
  final AppExitRequestCallback? onExitRequested;

  @override
  State<LifecycleExampleWidget> createState() => _MyLifecycleWidgetState();
}

class _MyLifecycleWidgetState extends State<LifecycleExampleWidget> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();
    _listener = AppLifecycleListener(
      onResume: widget.onResumed,
      onInactive: widget.onInactive,
      onHide: widget.onHide,
      onShow: widget.onShow,
      onPause: widget.onPause,
      onRestart: widget.onRestart,
      onDetach: widget.onDetach,
      onExitRequested: widget.onExitRequested,
      onStateChange: (state) {
        debugPrint('AppLifecycleState: $state');
        // The following is redundant and for explanatory purposes only.
        switch (state) {
          case AppLifecycleState.detached:
            widget.onDetach?.call();
          case AppLifecycleState.resumed:
            widget.onResumed?.call();
          case AppLifecycleState.inactive:
            widget.onInactive?.call();
          case AppLifecycleState.hidden:
            widget.onHide?.call();
          case AppLifecycleState.paused:
            widget.onPause?.call();
        }
      },
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
