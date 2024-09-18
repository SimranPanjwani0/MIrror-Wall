import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirror_wall_app/controller/app_controller.dart';
import 'package:mirror_wall_app/utils/global_var.dart';
import 'package:mirror_wall_app/views/screens/componets/noInternet_data.dart';
import 'package:mirror_wall_app/views/screens/componets/popop_menyu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("My Browser")),
        actions: const [
          PopUpofAppBar(),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, snapshot) {
              if (snapshot.data!.contains(ConnectivityResult.mobile) ||
                  snapshot.data!.contains(ConnectivityResult.wifi)) {
                return Stack(
                  children: [
                    InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri('https://www.google.com/'),
                      ),
                      onWebViewCreated: (controller) {
                        inAppWebViewController = controller;
                      },
                      onProgressChanged: (controller, progress) {
                        Provider.of<HomeProvider>(context, listen: false)
                            .onchange_progress(progress);
                      },

                      // for the add to fav site
                      onLoadStop: (controller, url) async {
                        Provider.of<HomeProvider>(context, listen: false)
                            .addtoHistory();
                        await Provider.of<HomeProvider>(context, listen: false)
                            .setcurrentUrl();
                        await Provider.of<HomeProvider>(context, listen: false)
                            .checkIfShouldGoBack();
                        await Provider.of<HomeProvider>(context, listen: false)
                            .canGoForward();
                        await pullToRefreshController.endRefreshing();
                      },
                      pullToRefreshController: pullToRefreshController,
                    ),
                    (Provider.of<HomeProvider>(context, listen: true).progress <
                            1)
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: LinearProgressIndicator(
                              color: Colors.blueAccent,
                              value: Provider.of<HomeProvider>(context,
                                      listen: true)
                                  .progress,
                            ),
                          )
                        : Container(),
                  ],
                );
              } else {
                return const Center(
                  child: noInternet(),
                );
              }
            },
          ),
          Align(
            alignment: const Alignment(0, 0.95),
            child: TextFormField(
              controller: txtsearch,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.link_sharp),
                suffixIcon: IconButton(
                  onPressed: () {
                    txtsearch.clear();
                  },
                  icon: const Icon(Icons.cancel_outlined),
                ),
                hintText: 'Search or type URL',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onFieldSubmitted: (value) {
                Provider.of<HomeProvider>(context, listen: false)
                    .updateSearchedText(value);

                Provider.of<HomeProvider>(context, listen: false)
                    .searchEngines();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        fixedColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            activeIcon: IconButton(
              onPressed: () {
                inAppWebViewController.loadUrl(
                    urlRequest: URLRequest(
                  url: WebUri('https://www.google.com/'),
                ));
              },
              icon: const Icon(Icons.home),
            ),
            icon: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            activeIcon: IconButton(
              onPressed: () {
                Provider.of<HomeProvider>(context, listen: false)
                    .addtoBookMark();
              },
              icon: const Icon(Icons.bookmark_add_outlined),
            ),
            icon: const Icon(
              Icons.bookmark_add_outlined,
              color: Colors.black,
            ),
            label: 'bookmark',
          ),
          BottomNavigationBarItem(
            activeIcon: IconButton(
                onPressed: Provider.of<HomeProvider>(context, listen: true)
                        .isButtonEnabled
                    ? () {
                        (Provider.of<HomeProvider>(context, listen: false)
                            .goBack());
                      }
                    : null,
                icon: const Icon(
                  Icons.chevron_left,
                ),
                iconSize: 30),
            backgroundColor: Colors.black,
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            label: 'chevron_left',
          ),
          BottomNavigationBarItem(
            activeIcon: IconButton(
              onPressed: () {
                inAppWebViewController.reload();
              },
              icon: const Icon(Icons.refresh),
              iconSize: 25,
            ),
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            label: 'refresh',
          ),
          BottomNavigationBarItem(
            activeIcon: IconButton(
              onPressed: Provider.of<HomeProvider>(context, listen: true)
                      .isButtonForward
                  ? () {
                      (Provider.of<HomeProvider>(context, listen: false)
                          .goForward());
                    }
                  : null,
              icon: const Icon(Icons.chevron_right),
              iconSize: 30,
            ),
            icon: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            label: 'chevron_right',
          ),
        ],
      ),
    );
  }
}
