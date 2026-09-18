import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:bachaoo/common_widgets/app_text.dart';
import 'package:bachaoo/core/constants/bachaoo_colors.dart';
import 'package:bachaoo/core/constants/bachaoo_dimensions.dart';

class PaymentProofUpload extends StatelessWidget {
  final PlatformFile? selectedFile;
  final ValueChanged<PlatformFile?> onFileSelected;

  const PaymentProofUpload({
    super.key,
    required this.selectedFile,
    required this.onFileSelected,
  });

  Future<void> _pickFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
    );
    if (result.isNotEmpty) {
      onFileSelected(result.first);
    }
  }

  IconData get _fileIcon {
    final ext = selectedFile?.extension?.toLowerCase();
    if (ext == 'pdf') return Icons.picture_as_pdf_rounded;
    return Icons.image_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.titleSmall('Upload payment proof'),
        AppDimensions.verticalSpace12,
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              border: Border.all(
                color: selectedFile != null
                    ? AppColors.primaryColor
                    : AppColors.borderColor,
                style: BorderStyle.solid,
                width: selectedFile != null ? 1.5 : 1,
              ),
            ),
            child: selectedFile == null
                ? Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.warningLight,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.cloud_upload_outlined,
                          color: AppColors.warningDark,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingSmall),
                      AppText.bodyMedium(
                        'Tap to choose a screenshot or file',
                        color: AppColors.textSecondary,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.successLight,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusMedium,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          _fileIcon,
                          color: AppColors.successDark,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingMedium),
                      Expanded(
                        child: AppText.bodyMedium(
                          selectedFile!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onFileSelected(null),
                        child: const Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 6),
        AppText.bodySmall(
          'Supported formats: PNG, JPG, JPEG, PDF',
          color: AppColors.textHint,
        ),
      ],
    );
  }
}
