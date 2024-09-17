import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    required this.url,
    required this.onBackPressed,
    super.key,
    this.cookie,
  });

  final String url;
  final VoidCallback onBackPressed;
  final WebViewCookie? cookie;

  @override
  State<StatefulWidget> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  final cookieManager = WebViewCookieManager();
  String title = '';
  int loadingPercentage = 0;
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  void initState() {
    super.initState();
    if (widget.cookie != null) {
      Future<void>.delayed(
        Duration.zero,
        () async => cookieManager.setCookie(widget.cookie!),
      );
    }

    controller = WebViewController();

    Future<void>.delayed(
      Duration.zero,
      () async {
        await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
        // Avoid a black screen before the first page loads, even in Dark Mode.
        await controller.setBackgroundColor(Colors.transparent);
        await controller.setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) => setState(
              () => loadingPercentage = 0,
            ),
            onProgress: (progress) => setState(
              () => loadingPercentage = progress,
            ),
            onPageFinished: (_) async {
              final title = await controller.getTitle() ?? '';
              setState(
                () => this.title = title,
              );
              loadingPercentage = 100;
            },
          ),
        );
        try {
          await controller.loadRequest(Uri.parse(widget.url));
        } on FormatException catch (e, s) {
          stderr.writeln(e);
          debugPrintStack(stackTrace: s);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(
      Duration.zero,
      () async {
        canGoBack = await controller.canGoBack();
        canGoForward = await controller.canGoForward();
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => TextButton(
            onPressed: widget.onBackPressed,
            child: const FittedBox(
              child: Text(
                'Back',
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leadingWidth: 70,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebViewWidget(controller: controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: canGoBack ? controller.goBack : null,
                    icon: const Icon(Icons.navigate_before),
                  ),
                  IconButton(
                    onPressed: canGoForward ? controller.goForward : null,
                    icon: const Icon(Icons.navigate_next),
                  ),
                  IconButton(
                    onPressed: controller.reload,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
