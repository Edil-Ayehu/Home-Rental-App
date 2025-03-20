import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String cardType;
  final String lastDigits;

  const DeleteConfirmationDialog({
    super.key,
    required this.cardType,
    required this.lastDigits,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Remove Card'),
      content: Text('Are you sure you want to remove $cardType •••• $lastDigits?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text(
            'Remove',
            style: TextStyle(
              color: AppColors.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> showDeleteConfirmation({
  required BuildContext context,
  required String cardType,
  required String lastDigits,
}) async {
  final bool? shouldDelete = await showDialog<bool>(
    context: context,
    builder: (context) => DeleteConfirmationDialog(
      cardType: cardType,
      lastDigits: lastDigits,
    ),
  );

  if (shouldDelete == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$cardType •••• $lastDigits has been removed'),
        backgroundColor: AppColors.error,
      ),
    );
  }
}
