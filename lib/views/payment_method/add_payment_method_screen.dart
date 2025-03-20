import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_constants.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  final bool isEditing;
  final String cardType;
  final String lastDigits;

  const AddPaymentMethodScreen({
    super.key,
    this.isEditing = false,
    this.cardType = '',
    this.lastDigits = '',
  });

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _cardNumberController;
  late final TextEditingController _expiryDateController;
  late final TextEditingController _cvvController;
  late final TextEditingController _nameController;
  
  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
    _nameController = TextEditingController();
    
    // Pre-fill data if editing
    if (widget.isEditing) {
      // For security, we don't pre-fill the actual card number
      // Just show the last 4 digits
      _cardNumberController.text = widget.lastDigits.isNotEmpty 
          ? '•••• •••• •••• ${widget.lastDigits}'
          : '';
    }
  }
  
  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              size: 16.sp,
              color: AppColors.textPrimary,
            ),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(widget.isEditing ? 'Edit Payment Method' : 'Add Payment Method'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  label: 'Card Number',
                  prefixIcon: Icons.credit_card,
                  keyboardType: TextInputType.number,
                  controller: _cardNumberController,
                  readOnly: widget.isEditing, // Make read-only if editing
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        label: 'Expiry Date',
                        prefixIcon: Icons.calendar_today,
                        keyboardType: TextInputType.datetime,
                        controller: _expiryDateController,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildTextField(
                        label: 'CVV',
                        prefixIcon: Icons.lock_outline,
                        keyboardType: TextInputType.number,
                        controller: _cvvController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildTextField(
                  label: 'Cardholder Name',
                  prefixIcon: Icons.person_outline,
                  controller: _nameController,
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save card logic here
                      
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(widget.isEditing 
                            ? 'Card updated successfully' 
                            : 'Card added successfully'),
                          backgroundColor: AppColors.primary,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      
                      context.pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: Size(double.infinity, 56.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 2,
                    shadowColor: AppColors.primary.withOpacity(0.3),
                  ),
                  child: Text(
                    widget.isEditing ? 'Update Card' : 'Add Card',
                    style: TextStyle(
                      color: AppColors.surface,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      style: TextStyle(
        fontSize: 16.sp,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14.sp,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.primary,
          size: 20.sp,
        ),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
