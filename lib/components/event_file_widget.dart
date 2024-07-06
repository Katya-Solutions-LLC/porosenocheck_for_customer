import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/colors.dart';

import 'app_primary_widget.dart';
import 'cached_image_widget.dart';
import 'common_file_placeholders.dart';

class AddFilesWidget extends StatelessWidget {
  final String? eId;
  final RxList<FileElement>? eFiles;
  final RxList<PlatformFile> fileList;
  final VoidCallback onFilePick;
  final Function(int)? onFileRemove;
  final Function(int) onFilePathRemove;

  const AddFilesWidget({
    Key? key,
    this.eId,
    this.eFiles,
    required this.fileList,
    required this.onFilePick,
    this.onFileRemove,
    required this.onFilePathRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(locale.value.otherMedicalReport, style: boldTextStyle(size: 16)).paddingSymmetric(horizontal: 16),
        8.height,
        if (eId != null)
          SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AppPrimaryWidget(
                  width: 80,
                  constraints: const BoxConstraints(minHeight: 80),
                  padding: const EdgeInsets.all(8),
                  border: Border.all(color: primaryColor),
                  onTap: () {
                    onFilePick;
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_circle_outline_rounded, color: primaryColor, size: 24),
                      8.height,
                      Text(
                        locale.value.addFiles,
                        style: boldTextStyle(color: primaryColor, size: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 16),
                ...List.generate(eFiles.validate().length, (index) {
                  log('EVENTFILES[INDEX].URL: ${eFiles.validate()[index].url}');
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Loader(),
                        ),
                        eFiles.validate()[index].url.isImage
                            ? CachedImageWidget(
                                url: eFiles.validate()[index].url,
                                height: 80,
                                width: 80,
                              )
                            : CommonPdfPlaceHolder(text: eFiles.validate()[index].url.split("/").last),
                        Positioned(
                          right: -8,
                          top: -8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 18),
                          ).onTap(() {
                            if (onFileRemove != null) {
                              onFileRemove!.call(index);
                            }
                          }),
                        ),
                      ],
                    ),
                  );
                }),
                ...List.generate(fileList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Loader(),
                        ),
                        fileList[index].path.isImage
                            ? Image.file(
                                File(fileList[index].path.validate()),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const SizedBox(
                                  width: 80,
                                  height: 80,
                                ),
                              ).cornerRadiusWithClipRRect(defaultRadius)
                            : CommonPdfPlaceHolder(text: fileList[index].name),
                        Positioned(
                          right: -8,
                          top: -8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 18),
                          ).onTap(() => onFilePathRemove.call(index)),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          )
        else
          SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            child: Obx(
              () => Row(children: [
                AppPrimaryWidget(
                  width: 80,
                  constraints: const BoxConstraints(minHeight: 80),
                  padding: const EdgeInsets.all(8),
                  border: Border.all(color: primaryColor),
                  borderRadius: defaultRadius,
                  onTap: onFilePick,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_circle_outline_rounded, color: primaryColor, size: 24),
                      8.height,
                      Text(
                        locale.value.addFiles,
                        style: boldTextStyle(color: primaryColor, size: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ).paddingSymmetric(horizontal: 16),
                ...List.generate(fileList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Loader(),
                        ),
                        fileList[index].path.isImage
                            ? Image.file(
                                File(fileList[index].path.validate()),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const SizedBox(
                                  width: 80,
                                  height: 80,
                                ),
                              ).cornerRadiusWithClipRRect(defaultRadius)
                            : CommonPdfPlaceHolder(text: fileList[index].name),
                        Positioned(
                          right: -8,
                          top: -8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: const Icon(Icons.close, color: Colors.white, size: 18),
                          ).onTap(() => onFilePathRemove.call(index)),
                        ),
                      ],
                    ),
                  );
                }),
              ]),
            ),
          ),
      ],
    );
  }
}

class FileElement {
  FileElement({
    this.id = -1,
    this.url = "",
  });

  int id;
  String url;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"] is int
            ? json["id"]
            : json["id"] is String
                ? json["id"].toString().toInt(defaultValue: -1)
                : -1,
        url: json['url'] is String ? json['url'] : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
