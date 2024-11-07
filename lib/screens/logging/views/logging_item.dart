import 'package:book_store_manager/models/logging_model.dart';
import 'package:book_store_manager/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoggingItem extends StatelessWidget {
  final LoggingModel model;

  const LoggingItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.function,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                DateTimeUtils.loggingTime(model.time),
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Colors.orangeAccent[700],
                ),
              ),
            ],
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Uid: ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                model.uid,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Gap(4),
          for (var ele in model.metaData.entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Text(
                    '${ele.key}: ',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    ele.value,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
