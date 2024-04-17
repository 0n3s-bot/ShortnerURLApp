import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:urlshortener/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:urlshortener/bloc/home_bloc/bloc/home_event.dart';
import 'package:urlshortener/bloc/home_bloc/bloc/home_state.dart';
import 'package:urlshortener/utills/flutter_toast.dart';

class MyHomePageScreen extends StatefulWidget {
  const MyHomePageScreen({super.key});

  @override
  State<MyHomePageScreen> createState() => _MyHomePageScreenState();
}

class _MyHomePageScreenState extends State<MyHomePageScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showQr = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Shortener'),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeErrortate) {
            Toast.showMessage(state.message ?? "Unknown Error Occured",
                isError: true);
          }
          if (state is HomeSuccesState) {
            Toast.showMessage(state.message ?? "Success");
          }
        },
        builder: (context, state) {
          switch (state) {
            case HomeInitialState():
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text("Long Url"),
                      TextFormField(
                        controller: _controller,
                        onTapOutside: (event) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        decoration: const InputDecoration(
                            label: Text("Long URL"),
                            hintText: "Your Long Url ",
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: state.creating
                            ? const CircularProgressIndicator()
                            : _builButton(onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //
                                  context
                                      .read<HomeBloc>()
                                      .add(HomeCreateShortUrlEvent(
                                        longUrl: _controller.text.trim(),
                                      ));
                                }
                              }),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (state.responseModal != null)
                        Column(
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Generated Short URL",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                state.responseModal?.shortUrl ??
                                                    "",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          )
                                          // Text(state.responseModal!.toJson().toString())
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          Clipboard.setData(ClipboardData(
                                              text: state.responseModal
                                                      ?.shortUrl ??
                                                  ""));

                                          Toast.showMessage(
                                            'Link copied',
                                            txtcolor: Colors.black,
                                            color: Colors.white,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.copy,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _showQr = true;
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  child: Text(
                                    "Generate QR Code",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            AnimatedContainer(
                              height: _showQr ? 200 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: QrImageView(
                                data: state.responseModal?.shortUrl ?? "",
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ),
                            // Text("Scan Qr code")
                          ],
                        )
                    ],
                  ),
                ),
              );

            default:
              return SizedBox(
                child: Text('$state'),
              );
          }
        },
      ),
    );
  }

  _builButton({required void Function()? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(),
      onPressed: onPressed,
      child: const Text('Convert to Short Url'),
    );
  }
}
