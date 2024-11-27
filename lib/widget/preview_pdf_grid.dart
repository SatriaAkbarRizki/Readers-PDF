
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:simplereader/cubit/click_delete.dart';
import 'package:simplereader/model/thememodel.dart';

class PreviewPDFGrid extends StatelessWidget {
  final Thememodel themes;
  final String? title, path;
  const PreviewPDFGrid(this.themes, this.title, this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return path == null
        ? Container(
            height: 250,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/add.svg',
                height: 62,
                colorFilter: ColorFilter.mode(themes.text, BlendMode.srcIn),
              ),
            ),
          )
        : PdfDocumentViewBuilder.file(
            path!,
            builder: (context, document) =>
                BlocBuilder<ClickOrderDelete, List?>(
              builder: (context, state) {
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: document?.pages.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => context.read<ClickOrderDelete>().click(index),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: PdfPageView(
                            document: document,
                            pageNumber: index + 1,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: state?.contains(index) == true
                                  ? Colors.red.withOpacity(0.2)
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0),
                );
              },
            ),
          );
  }
}
