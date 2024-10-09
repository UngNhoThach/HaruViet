import 'package:haruviet/helper/colors.dart';
import 'package:haruviet/helper/context.dart';
import 'package:haruviet/helper/spaces.dart';
import 'package:haruviet/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowContentOneColumn extends StatefulWidget {
  const RowContentOneColumn({
    super.key,
    this.title,
    this.styleTitle,
    this.data,
    this.widget,
    this.widgetBottom,
    // required this.maxLines,
    this.sectionItem,
    this.isDisplayExpanded = true,
    this.initiallyExpanded = true,
    this.onExpansionChanged,
    this.padding,
    this.paddingContent,
    this.widgetTile,
    this.isCustomerWight = false,
    this.sizeWidght,
    this.isPaddingTop = false,
    this.isBorderRadius = true,
    this.iconMore,
    this.customTitleBar = false,
    this.isRowTitle = false,
    this.checkIspaddingTile = false,
  });
  final dynamic sectionItem;

  final String? title;
  final TextStyle? styleTitle;
  final Map<String, dynamic>? data;
  final Widget? widget;
  final Widget? widgetTile;
  final bool checkIspaddingTile;
  // final bool isSeeMore;
  final Widget? widgetBottom;
  final bool isRowTitle;
  // final int maxLines;
  final bool isDisplayExpanded;
  final bool initiallyExpanded;
  final void Function(bool value)? onExpansionChanged;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingContent;
  final bool isCustomerWight;
  final double? sizeWidght;
  final bool isPaddingTop;
  final bool isBorderRadius;
  final Widget? iconMore;
  final bool customTitleBar;
  @override
  State<RowContentOneColumn> createState() => _RowContentOneColumnState();
}

class _RowContentOneColumnState extends State<RowContentOneColumn>
    with TickerProviderStateMixin {
  late final AnimationController expandController;
  late final Animation<double> animation;
  var isSeeMore = false;
  bool isExpanded = false;
  List<bool> checkItemExpanded = [];

  @override
  void initState() {
    expandController = AnimationController(
      vsync: this,
      duration: widget.isDisplayExpanded
          ? const Duration(milliseconds: 300)
          : const Duration(milliseconds: 0),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
    setup();
  }

  void setup() {
    isExpanded = widget.initiallyExpanded;
    if (!isExpanded) {
      expandController.animateTo(0);
    } else {
      expandController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant RowContentOneColumn oldWidget) {
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      setup();
    }
    super.didUpdateWidget(oldWidget);
  }

  void onClick() {
    if (!isExpanded) {
      expandController.forward();
    } else {
      expandController.animateTo(0);
    }
    setState(() {
      isExpanded = !isExpanded;
    });

    widget.onExpansionChanged?.call(isExpanded);
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  int measureTextLines(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.computeLineMetrics().length;
  }

  bool shouldShowSeeMoreButton(double maxWidth) {
    if (widget.data == null) {
      return false;
    }
    for (final entry in widget.data!.entries) {
      final lines =
          measureTextLines(entry.value, textTheme.bodySmall!, maxWidth);
      if (lines > 5) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final showSeeMoreButton = shouldShowSeeMoreButton(300);

    return Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius:
            widget.isBorderRadius ? BorderRadius.circular(12.r) : null,
      ),
      child: Padding(
        padding: widget.padding ??
            EdgeInsets.only(
              left: widget.isPaddingTop ? 4 : 16,
              right: widget.isPaddingTop ? 4 : 16,
              top: widget.isPaddingTop ? 8 : 0,
              bottom: 16,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null) ...[
              Column(
                children: [
                  GestureDetector(
                    onTap: widget.isDisplayExpanded
                        ? () {
                            onClick();
                          }
                        : null,
                    child: Container(
                      padding: widget.checkIspaddingTile
                          ? const EdgeInsets.symmetric(vertical: 16)
                          : null,
                      color: widget.checkIspaddingTile ? colorGray02 : null,
                      child: Row(
                        // /Users/ungnhothach/Desktop/developer/code/app/flutter/eco/eco_basic/haruviet/build/app/outputs/flutter-apk
                        children: [
                          Expanded(
                            child: widget.isRowTitle
                                ? widget.widgetTile!
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      widget.title!,
                                      style: widget.styleTitle ??
                                          textTheme.titleMedium?.copyWith(
                                            color: context.appColorScheme
                                                .colorExtendedTextTitleMedium,
                                            fontSize: 16,
                                          ),
                                    ),
                                  ),
                          ),
                          if (widget.iconMore != null) ...[
                            spaceW8,
                            widget.iconMore!,
                          ],
                          widget.isDisplayExpanded
                              ? (isExpanded
                                  ? const Icon(CupertinoIcons.chevron_up,
                                      size: 16)
                                  : const Icon(CupertinoIcons.chevron_down,
                                      size: 16))
                              : space0,
                          spaceW16,
                        ],
                      ),
                    ),
                  ),
                  isExpanded && widget.isDisplayExpanded ? space0 : space0,
                ],
              ),
            ],
            SizeTransition(
              sizeFactor: animation,
              child: Container(
                padding: widget.paddingContent ??
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    if (widget.data != null) ...[
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.data!.length,
                        itemBuilder: (context, index) {
                          final entry = widget.data!.entries.elementAt(index);
                          for (var i = 0; i < widget.data!.length; i++) {
                            checkItemExpanded.add(false);
                          }
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      (entry.value ?? '').isNotEmpty
                                          ? entry.value
                                          : '',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: context.appColorScheme
                                            .colorExtendedTextBodySmall,
                                        height: 1.4,
                                      ),
                                      maxLines: checkItemExpanded[index]
                                          ? null
                                          : (showSeeMoreButton ? 5 : null),
                                      overflow: checkItemExpanded[index]
                                          ? null
                                          : (showSeeMoreButton
                                              ? TextOverflow.ellipsis
                                              : null),
                                    ),
                                  ),
                                ],
                              ),
                              checkItemExpanded[index]
                                  ? spaceH12
                                  : (showSeeMoreButton ? spaceH12 : space0),
                              checkItemExpanded[index]
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              checkItemExpanded[index] = false;
                                            });
                                          },
                                          child: const Text(
                                            'Thu gọn',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: colorPrimary,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : showSeeMoreButton
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  checkItemExpanded[index] =
                                                      true;
                                                });
                                              },
                                              child: Text(
                                                'Xem tất cả',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : space0
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => spaceH12,
                      ),
                    ],
                    if (widget.data != null && widget.widget != null) ...[
                      spaceH12,
                    ],
                    if (widget.widget != null) ...[
                      widget.widget!,
                    ],
                    if (widget.widgetBottom != null) ...[
                      widget.widgetBottom!,
                    ],
                    if (widget.sectionItem != null) ...[
                      ...widget.sectionItem,
                    ],
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
