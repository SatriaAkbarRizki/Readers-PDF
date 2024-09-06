import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/model/pdfmodel.dart';
import 'package:simplereader/widget/scaffold_messeger.dart';

class DialogDoc extends StatelessWidget {
  Pdfmodel pdf;
  DialogDoc({super.key, required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Dialog(
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(144),
                    child: Image.asset(
                      'assets/image/sample-book.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final bytes = await rootBundle.load('assets/example.pdf');
                    final list = bytes.buffer.asUint8List();
                    Share.shareXFiles(
                      [XFile(pdf.path)],
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    width: 290,
                    decoration: BoxDecoration(
                        color: const Color(0xff1b5ed1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Share',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/icons/Share.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  // TODO: ADDING RENAME FILE PDF
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    width: 290,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Rename',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/icons/Rename.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    final dir = Directory(pdf.path);

                    context.read<PdfBloc>().add(OnPdfDeleted(filePdf: dir));
                    ShowSnackBar().showSnackBar(context, 'Deleted Succes');
                    context.pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    width: 290,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Delete',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/icons/Delete.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
