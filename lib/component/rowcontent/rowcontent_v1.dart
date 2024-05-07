import 'package:eco_app/helper/context.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:eco_app/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowContent extends StatefulWidget {
  const RowContent({
    super.key,
    this.title,
    this.styleTitle,
    this.data,
    this.widget,
    this.widgetBottom,
    this.sectionItem,
    this.isDisplayExpanded = true,
    this.initiallyExpanded = true,
    this.onExpansionChanged,
    this.padding,
    this.paddingContent,
    this.isCustomerWight = false,
    this.sizeWidght,
    this.isPaddingTop = false,
    this.isBorderRadius = true,
    this.iconMore,
    this.customTitleBar = false,
  });
  final dynamic sectionItem;

  final String? title;
  final TextStyle? styleTitle;
  final Map<String, dynamic>? data;
  final Widget? widget;
  final Widget? widgetBottom;

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
  State<RowContent> createState() => _RowContentState();
}

class _RowContentState extends State<RowContent> with TickerProviderStateMixin {
  late final AnimationController expandController;
  late final Animation<double> animation;
  bool isExpanded = false;

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
  void didUpdateWidget(covariant RowContent oldWidget) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColor.colorWhite,
        borderRadius:
            widget.isBorderRadius ? BorderRadius.circular(12.r) : null,
      ),
      child: Padding(
        padding: widget.padding ??
            EdgeInsets.only(
              left: widget.isPaddingTop ? 4 : 16,
              right: widget.isPaddingTop ? 4 : 16,
              top: widget.isPaddingTop ? 8 : 16,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                ? const Icon(CupertinoIcons.chevron_down,
                                    size: 16)
                                : const Icon(CupertinoIcons.chevron_down,
                                    size: 16))
                            : space0,
                        spaceW16,
                      ],
                    ),
                  ),
                  isExpanded && widget.isDisplayExpanded ? spaceH6 : space0,
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
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: widget.isCustomerWight
                                    ? widget.sizeWidght
                                    : 1.sw / 5.0,
                                child: Text(
                                  '${entry.key}:',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: context.appColorScheme
                                        .colorExtendedTextBodySmall,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              spaceW20,
                              Expanded(
                                child: Text(
                                  (entry.value ?? '').isNotEmpty
                                      ? entry.value
                                      : '',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: context.appColorScheme
                                        .colorExtendedTextBodyMedium,
                                    fontSize: 12,
                                    height: 1.4,
                                    wordSpacing: 1.2,
                                  ),
                                ),
                              )
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
