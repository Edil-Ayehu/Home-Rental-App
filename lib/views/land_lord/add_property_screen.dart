import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_rental_app/models/property_model.dart';
import '../../core/constants/color_constants.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_textfield.dart';

class AddPropertyScreen extends StatefulWidget {
  final Property? property; // For editing existing property


  const AddPropertyScreen({super.key, this.property});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  // Add controllers
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing property data if editing
    if (widget.property != null) {
      _titleController.text = widget.property!.title;
      _locationController.text = widget.property!.location;
      _priceController.text = widget.property!.price.toString();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property == null ? 'Add Property' : 'Edit Property'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildImageUpload(),
              SizedBox(height: 24.h),
              CustomTextField(
                label: 'Title',
                prefixIcon: Icons.home_outlined,
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Location',
                prefixIcon: Icons.location_on_outlined,
                controller: _locationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: 'Price per night',
                prefixIcon: Icons.attach_money_outlined,
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: widget.property == null ? 'Add Property' : 'Save Changes',
                onPressed: _handleSubmit,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUpload() {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Center(
        child: Icon(
          Icons.add_photo_alternate_outlined,
          size: 48.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // Add property logic
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) Navigator.pop(context);
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }
}
