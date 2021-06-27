library fast_progress_hub;

import 'package:flutter/material.dart';

class FastProgressHub extends StatefulWidget {
  final Widget child;
  final bool loading;
  final double? opacity;
  final Color? color;
  final Widget? progressIndicator;
  final bool? dismissible;

  FastProgressHub(
      {required this.child,
      required this.loading,
      this.color,
      this.opacity,
      this.progressIndicator,
      this.dismissible});

  @override
  State createState() => _FastProgressHubState();

  static _FastProgressHubState? of(BuildContext context) {
    final fastProgressHudState =
        context.findAncestorStateOfType<_FastProgressHubState>();

    assert(() {
      if (fastProgressHudState == null) {
        throw FlutterError(
            'FastProgressHub operation requested with a context that does not include a FastProgressHub.\n'
            'The context used to show FastProgressHub must be that of a widget '
            'that is a descendant of a FastProgressHub widget.');
      }
      return true;
    }());

    return fastProgressHudState;
  }
}

class _FastProgressHubState extends State<FastProgressHub> {
  late LoadingNotifier loadingNotifier;

  @override
  void initState() {
    super.initState();
    loadingNotifier = LoadingNotifier(widget.loading);
  }

  @override
  void didUpdateWidget(FastProgressHub oldWidget) {
    if (oldWidget.loading != widget.loading) {
      loadingNotifier.value = widget.loading;
    }
    super.didUpdateWidget(oldWidget);
  }

  void startLoading() {
    loadingNotifier.value = true;
  }

  void stopLoading() {
    loadingNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        widget.child,
        ValueListenableBuilder<bool>(
          valueListenable: loadingNotifier,
          builder: (context, value, _) {
            return value
                ? GestureDetector(
                    onTap: () {
                      if (widget.dismissible ?? false) {
                        loadingNotifier.value = false;
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                        color: Colors.grey.withOpacity(0.3),
                        alignment: Alignment.center,
                        constraints: BoxConstraints.expand(),
                        child: widget.progressIndicator ??
                            CircularProgressIndicator()),
                  )
                : SizedBox.shrink();
          },
        )
      ],
    );
  }

  set loading(bool loading) {
    loadingNotifier.value = loading;
  }

  @override
  void dispose() {
    loadingNotifier.dispose();
    super.dispose();
  }
}

class LoadingNotifier extends ValueNotifier<bool> {
  LoadingNotifier(bool value) : super(value);
}
