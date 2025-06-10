import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class WalletItem extends StatelessWidget {
  const WalletItem({
    super.key,
    required this.patientName,
    required this.price,
    required this.time,
    required this.status,
  });

  final String patientName;
  final String price;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == 'success' ? AppColors.mainColor : Colors.red;
    Color bgColor = status == 'success' ? AppColors.lighterBlue : Colors.red.withOpacity(0.1);
    IconData iconData = status == 'success' ? Icons.north_east : Icons.error_outline;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Icon(
                    iconData,
                    color: statusColor,
                  ),
                ),
              ),
              horizontalSpace(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patientName,
                    style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
                  ),
                  verticalSpace(2),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: status == 'success' 
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: AppTextStyles.poppinsBlack(10, FontWeight.w600).copyWith(
                        color: status == 'success' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
              ),
              verticalSpace(8),
              Text(
                price,
                style: AppTextStyles.poppinsMainColor(16, FontWeight.w600).copyWith(
                  color: status == 'success' ? AppColors.mainColor : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
