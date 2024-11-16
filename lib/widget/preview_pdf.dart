import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:simplereader/model/thememodel.dart';

class PreviewPDF extends StatelessWidget {
  final Thememodel themes;
  String? title, path;
  PreviewPDF(this.themes, this.title, this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                color: themes.widget, borderRadius: BorderRadius.circular(12)),
            child: path == null
                ? Center(
                    child: SvgPicture.asset(
                      'assets/icons/add.svg',
                      height: 62,
                      colorFilter:
                          ColorFilter.mode(themes.text, BlendMode.srcIn),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: PdfDocumentViewBuilder.file(
                      path!,
                      builder: (context, document) => ListView.builder(
                        itemCount: 1,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return PdfPageView(
                            document: document,
                            pageNumber: index + 1,
                            alignment: Alignment.center,
                          );
                        },
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 50,
              child: Text(
                title ?? '...',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: themes.text),
              ),
            ),
          )
        ],
      ),
    );
  }
}
