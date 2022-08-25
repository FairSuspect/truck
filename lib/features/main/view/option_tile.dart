import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/main/models/option.dart';
import 'package:truck/features/main/provider/option_provider.dart';
import 'package:truck/services/theme/light_theme.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.option,
    required this.onTap,
  });
  final GestureTapCallback onTap;
  final Option option;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: theme.cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Consumer<OptionProvider>(builder: (context, controller, child) {
                final progress = controller.progresses[option.key];
                return DocumentIcon(progress: progress);
              }),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.name,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    if (option.dateCreated != null)
                      Text(
                        DateFormat.yMd().format(option.deadline!),
                        style: theme.textTheme.bodySmall,
                      ),
                    const SizedBox(height: 4),
                    if (option.deadline != null && option.dateCreated != null)
                      _DeadlineProgress(
                          remainingTime:
                              option.deadline!.difference(DateTime.now()))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeadlineProgress extends StatelessWidget {
  const _DeadlineProgress({required this.remainingTime});
  final Duration remainingTime;
  RemainingTimeIndicator get remainingTimeIndicator =>
      RemainingTimeIndicator.fromDuration(remainingTime);

  int get days => remainingTime.inDays;
  bool get overdue => remainingTime.isNegative;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const aLotOfDays = 30;
    final double barProgress = days >= aLotOfDays ? 1 : days / aLotOfDays;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ProgressBar(
          progress: barProgress,
        ),
        const SizedBox(width: 16),
        overdue
            ? Text(
                "${1 - days} days overdue",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              )
            : Text("$days day${days != 1 ? 's' : ''} left",
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.primaryColor))
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  final double progress;
  static const double width = 96;
  bool get overdue => progress < 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double safeProgress = progress.isNegative ? 0 : progress;
    final double progressWidth = width * safeProgress;
    final color =
        colorByProgress(theme.extension<TimeIndicatorColors>()!, safeProgress);

    return Stack(
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
              color: progress.isNegative
                  ? theme.errorColor.withOpacity(.08)
                  : color.withOpacity(.08),
              border: progress.isNegative
                  ? Border.all(color: theme.errorColor)
                  : null,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          width: width,
        ),
        Container(
          height: 8,
          width: progressWidth > width ? width : progressWidth,
          decoration: BoxDecoration(
              color: overdue ? theme.colorScheme.secondary : color,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
        ),
      ],
    );
  }
}

class DocumentIcon extends StatelessWidget {
  const DocumentIcon({Key? key, this.progress}) : super(key: key);
  final double? progress;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: theme.primaryColor.withOpacity(.08),
        ),
        child: progress != null
            ? CircularProgressIndicator(value: progress)
            : SvgPicture.asset('assets/icons/document_outline.svg',
                height: 56));
  }
}

enum RemainingTimeIndicator {
  moreThanMonth(1000),
  aboutMonth(29),
  lessTwoWeeks(14),
  lessThreeDays(3);

  final int remainingDays;
  const RemainingTimeIndicator(this.remainingDays);
  factory RemainingTimeIndicator.fromDuration(Duration duration) {
    final int days = duration.inDays;
    if (days > aboutMonth.remainingDays) {
      return RemainingTimeIndicator.moreThanMonth;
    }
    if (days > lessTwoWeeks.remainingDays) {
      return RemainingTimeIndicator.aboutMonth;
    }
    if (days > lessThreeDays.remainingDays) {
      return RemainingTimeIndicator.lessTwoWeeks;
    }
    return RemainingTimeIndicator.lessThreeDays;
  }
}

Color colorByProgress(TimeIndicatorColors colors, double progress) {
  if (progress >= 1) {
    return colors.moreThanMonth;
  } else if (progress >= 0.75) {
    return colors.threeQuarters;
  } else if (progress >= .5) {
    return colors.half;
  } else if (progress >= .25) {
    return colors.quarter;
  }
  return colors.zero;
}
