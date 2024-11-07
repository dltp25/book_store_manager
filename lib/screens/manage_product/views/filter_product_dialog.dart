import 'package:book_store_manager/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilterProductDialog extends StatefulWidget {
  final List<String> selectedBookTypes;
  final bool? inStockDescending;

  const FilterProductDialog({
    super.key,
    required this.selectedBookTypes,
    this.inStockDescending,
  });

  @override
  State<FilterProductDialog> createState() => _FilterProductDialogState();
}

class _FilterProductDialogState extends State<FilterProductDialog> {
  late bool sgk, vh, khkt, tt, te, k;

  late bool? inStockDescending;

  @override
  void initState() {
    sgk = widget.selectedBookTypes.contains('bt001');
    vh = widget.selectedBookTypes.contains('bt002');
    tt = widget.selectedBookTypes.contains('bt003');
    te = widget.selectedBookTypes.contains('bt004');
    khkt = widget.selectedBookTypes.contains('bt005');
    k = widget.selectedBookTypes.contains('bt006');
    inStockDescending = widget.inStockDescending;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(top: 22, left: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thể loại',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Gap(12),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Sách giáo khoa'),
                selected: sgk,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                checkmarkColor: Colors.white,
                selectedColor: Colors.amber[300],
                labelStyle: TextStyle(
                  color: sgk ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: sgk ? Colors.transparent : Colors.grey[350]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onSelected: (value) {
                  setState(() {
                    sgk = !sgk;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Văn học'),
                selected: vh,
                checkmarkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selectedColor: Colors.purple[300],
                labelStyle: TextStyle(
                  color: vh ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: vh ? Colors.transparent : Colors.grey[350]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onSelected: (value) {
                  setState(() {
                    vh = !vh;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Trẻ em'),
                selected: te,
                checkmarkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selectedColor: Colors.pink[300],
                labelStyle: TextStyle(
                  color: te ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: te ? Colors.transparent : Colors.grey[350]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onSelected: (value) {
                  setState(() {
                    te = !te;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Truyện tranh'),
                selected: tt,
                checkmarkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selectedColor: Colors.green[300],
                labelStyle: TextStyle(
                  color: tt ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: tt ? Colors.transparent : Colors.grey[350]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onSelected: (value) {
                  setState(() {
                    tt = !tt;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Khoa học - Kỹ thuật'),
                selected: khkt,
                checkmarkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selectedColor: Colors.orange[300],
                labelStyle: TextStyle(
                  color: khkt ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: khkt ? Colors.transparent : Colors.grey[350]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onSelected: (value) {
                  setState(() {
                    khkt = !khkt;
                  });
                },
              ),
              ChoiceChip(
                label: const Text('Khác'),
                selected: k,
                checkmarkColor: Colors.white,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                selectedColor: Colors.blue[300],
                labelStyle: TextStyle(
                  color: k ? Colors.white : Colors.grey,
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: k ? Colors.transparent : Colors.grey[350]!,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                onSelected: (value) {
                  setState(() {
                    k = !k;
                  });
                },
              ),
            ],
          ),
          const Gap(12),
          const Text(
            'Sắp xếp',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Gap(0),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hàng trong kho:',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const Gap(4),
              Row(
                children: [
                  ChoiceChip(
                    label: const Text(
                      'Giảm dần',
                      style: TextStyle(fontSize: 12),
                    ),
                    padding: EdgeInsets.zero,
                    selected: inStockDescending == true,
                    showCheckmark: false,
                    selectedColor: Colors.blue[300],
                    labelStyle: TextStyle(
                      color: inStockDescending == true
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color: inStockDescending == true
                          ? Colors.transparent
                          : Colors.grey[350]!,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onSelected: (value) {
                      if (inStockDescending == true) {
                        setState(() {
                          inStockDescending = null;
                        });
                      } else {
                        setState(() {
                          inStockDescending = true;
                        });
                      }
                    },
                  ),
                  const Gap(4),
                  ChoiceChip(
                    label: const Text(
                      'Tăng dần',
                      style: TextStyle(fontSize: 12),
                    ),
                    padding: EdgeInsets.zero,
                    selected: inStockDescending == false,
                    showCheckmark: false,
                    selectedColor: Colors.blue[300],
                    labelStyle: TextStyle(
                      color: inStockDescending == false
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color: inStockDescending == false
                          ? Colors.transparent
                          : Colors.grey[350]!,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    onSelected: (value) {
                      if (inStockDescending == false) {
                        setState(() {
                          inStockDescending = null;
                        });
                      } else {
                        setState(() {
                          inStockDescending = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'sgk': sgk,
                    'vh': vh,
                    'te': te,
                    'tt': tt,
                    'khkt': khkt,
                    'k': k,
                    'inStockDescending': inStockDescending,
                  });
                },
                child: Text(
                  'Xác nhận',
                  style: TextStyle(color: AppColors.themeColor),
                ),
              ),
            ],
          ),
          const Gap(4),
        ],
      ),
    );
  }
}
