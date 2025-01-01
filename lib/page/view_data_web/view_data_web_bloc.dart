// import 'package:flutter/material.dart';
// import 'package:haruviet/base/base_bloc.dart';
// import 'package:haruviet/page/view_data_web/view_data_web_state.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // ViewDataWebBloc
// class ViewDataWebBloc extends BaseBloc<ViewDataWebState> {
//   ViewDataWebBloc() : super(const ViewDataWebState());
//   late final WebViewController controller;

//   getData() async {
//     emit(state.copyWith(
//       isLoading: true,
//     ));
//     try {
//       controller = WebViewController()
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {
//               // Update loading bar (optional).
//             },
//             onPageStarted: (String url) {
//               debugPrint('Page started loading: $url');
//             },
//             onPageFinished: (String url) async {
//               debugPrint('Page finished loading: $url');

//               await controller.runJavaScript('''
//             const headerElement = document.querySelector('header');
//             const headerElementFooter = document.querySelector('footer');
//             if (headerElement) {
//               headerElement.style.display = "none";
//             }
//             if (headerElementFooter){
//               headerElementFooter.style.display = "none";
//             }
//              else {
//               console.log("Header element not found.");
//             }
//           ''');
//               emit(state.copyWith(isLoading: false, controller: controller));
//             },
//             onHttpError: (HttpResponseError error) {
//               debugPrint('HTTP error: ');
//             },
//             onWebResourceError: (WebResourceError error) {
//               debugPrint('WebResource error: ${error.description}');
//             },
//             onNavigationRequest: (NavigationRequest request) {
//               if (request.url.startsWith('https://www.youtube.com/')) {
//                 return NavigationDecision.prevent;
//               }
//               return NavigationDecision.navigate;
//             },
//           ),
//         )
//         ..loadRequest(
//             Uri.parse('https://hotro.hasaki.vn/gioi-thieu-hasaki.html'));
//     } catch (e) {}
//   }
// }

import 'package:flutter/material.dart';
import 'package:haruviet/base/base_bloc.dart';
import 'package:haruviet/page/view_data_web/view_data_web_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewDataWebBloc extends BaseBloc<ViewDataWebState> {
  ViewDataWebBloc() : super(const ViewDataWebState());

  late final WebViewController controller;

  /// Hàm để ẩn header và footer trên trang web.
  Future<void> _hideHeaderAndFooter() async {
    const script = '''
      const header = document.querySelector('header');
      const footer = document.querySelector('footer');
      if (header) header.style.display = "none";
      if (footer) footer.style.display = "none";
    ''';

    try {
      await controller.runJavaScript(script);
    } catch (e) {
      debugPrint('Error hiding header/footer: $e');
    }
  }

  /// Hàm lấy dữ liệu và khởi tạo WebViewController.
  Future<void> getData({
    required String initialUrl,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(_navigationDelegate())
        ..loadRequest(Uri.parse(initialUrl));
    } catch (e) {
      debugPrint('Error initializing WebViewController: $e');
    }
  }

  /// Tạo NavigationDelegate với các sự kiện cần xử lý.
  NavigationDelegate _navigationDelegate() {
    return NavigationDelegate(
      onProgress: (int progress) {
        debugPrint('Loading progress: $progress%');
      },
      onPageStarted: (String url) {
        debugPrint('Page started loading: $url');
      },
      onPageFinished: (String url) async {
        debugPrint('Page finished loading: $url');
        await _hideHeaderAndFooter();
        emit(state.copyWith(isLoading: false, controller: controller));
      },
      onHttpError: (HttpResponseError error) {
        debugPrint('HTTP error: ${error.response?.uri}');
      },
      onWebResourceError: (WebResourceError error) {
        debugPrint('WebResource error: ${error.description}');
      },
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          debugPrint('Blocked navigation to: ${request.url}');
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
