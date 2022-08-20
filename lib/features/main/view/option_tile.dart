import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:truck/features/main/models/option.dart';

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
              const DocumentIcon(),
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
                        progress: DateTime.now()
                            .difference(option.dateCreated!)
                            .inDays,
                        total: option.deadline!
                            .difference(option.dateCreated!)
                            .inDays,
                      )
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
  const _DeadlineProgress({
    Key? key,
    required this.progress,
    required this.total,
  }) : super(key: key);
  final int progress;
  final int total;

  bool get overdue => progress > total;

  int get days => (total - progress).toInt();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ProgressBar(
          progress: progress / total,
        ),
        const SizedBox(width: 16),
        overdue
            ? Text(
                "${1 - days} days overdue",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              )
            : Text("$days days left",
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
  bool get overdue => progress > 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressWidth = width * progress;
    return Stack(
      children: [
        Container(
          height: 8,
          decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(.08),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          width: width,
        ),
        Container(
          height: 8,
          width: progressWidth > width ? width : progressWidth,
          decoration: BoxDecoration(
              color: overdue ? theme.colorScheme.secondary : theme.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ],
    );
  }
}

class DocumentIcon extends StatelessWidget {
  const DocumentIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: theme.primaryColor.withOpacity(.08),
        ),
        child:
            SvgPicture.asset('assets/icons/document_outline.svg', height: 56));
  }
}
