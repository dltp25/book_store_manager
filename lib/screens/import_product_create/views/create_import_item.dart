import 'package:book_store_manager/models/product_model.dart';
import '../bloc/create_import_product_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';

class CreateImportItem extends StatefulWidget {
  final ProductLiteModel productLiteModel;
  final int number;

  const CreateImportItem({
    super.key,
    required this.productLiteModel,
    required this.number,
  });

  @override
  State<CreateImportItem> createState() => _CreateImportItemState();
}

class _CreateImportItemState extends State<CreateImportItem> {
  late TextEditingController controller;

  @override
  void initState() {
    if (widget.number > 1) {
      controller =
          TextEditingController(text: widget.number.toStringAsFixed(0));
    } else {
      controller = TextEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.2,
        children: [
          CustomSlidableAction(
            onPressed: (context) {
              context.read<CreateImportProductBloc>().add(
                    RemoveProductEvent(
                      product: widget.productLiteModel,
                    ),
                  );
            },
            backgroundColor: const Color(0xFFFE4A49),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: Colors.white),
                Gap(4),
                Text(
                  'Xóa',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: CachedNetworkImageProvider(
                          widget.productLiteModel.mainUrl,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.productLiteModel.productName}\n\n",
                      style: const TextStyle(fontSize: 12),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Số lượng:',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Gap(2),
                SizedBox(
                  width: 96,
                  height: 36,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13),
                    maxLines: 1,
                    maxLength: 5,
                    cursorColor: Colors.black,
                    onChanged: ((p0) {
                      if (p0.isEmpty) {
                        context.read<CreateImportProductBloc>().add(
                              UpdateProductQuantityEvent(
                                product: widget.productLiteModel,
                                quantity: 1,
                              ),
                            );
                      } else {
                        context.read<CreateImportProductBloc>().add(
                              UpdateProductQuantityEvent(
                                product: widget.productLiteModel,
                                quantity: int.parse(p0),
                              ),
                            );
                      }
                    }),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^[1-9]\d*$')),
                    ],
                    decoration: InputDecoration(
                      hintText: '1',
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[350]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[350]!),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
