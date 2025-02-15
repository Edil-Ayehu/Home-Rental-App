import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_rental_app/controllers/property_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/property_model.dart';
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
  final _propertyController = PropertyController();
  bool _isLoading = false;
  File? _thumbnailImage;
  List<File> _additionalImages = [];
  final _picker = ImagePicker();
  
  // Add controllers
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  List<String> _existingImages = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing property data if editing
    if (widget.property != null) {
      _titleController.text = widget.property!.title;
      _locationController.text = widget.property!.location;
      _priceController.text = widget.property!.price.toString();
      _existingImages = widget.property!.images;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

Future<void> _pickImage(bool isThumbnail) async {
  try {
    if (isThumbnail) {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      
      if (image != null) {
        setState(() {
          _thumbnailImage = File(image.path);
        });
      }
    } else {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1000,
        maxHeight: 1000,
      );
      
      if (images.isNotEmpty) {
        setState(() {
          _additionalImages.addAll(
            images.map((image) => File(image.path)),
          );
        });
      }
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
    debugPrint('Error picking image: $e');
  }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thumbnail Image',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              _buildThumbnailUpload(),
              SizedBox(height: 24.h),
              Text(
                'Additional Images',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              _buildAdditionalImagesUpload(),
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

  Widget _buildThumbnailUpload() {
    return GestureDetector(
      onTap: () => _pickImage(true),
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
        child: _thumbnailImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.file(
                  _thumbnailImage!,
                  fit: BoxFit.cover,
                ),
              )
            : widget.property != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: widget.property!.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error_outline,
                        size: 48.sp,
                        color: AppColors.error,
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 48.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Add Thumbnail Image',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildAdditionalImagesUpload() {
    return Container(
      height: 120.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...List.generate(
            _additionalImages.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      _additionalImages[index],
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _additionalImages.removeAt(index);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...List.generate(
            _existingImages.length,
            (index) => Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: CachedNetworkImage(
                      imageUrl: _existingImages[index],
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error_outline,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          _existingImages.removeAt(index);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _pickImage(false),
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 32.sp,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Add Image',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Future<void> _handleSubmit() async {
  if (_formKey.currentState!.validate()) {
    if (_thumbnailImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a thumbnail image')),
      );
      return;
    }
    if (_additionalImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one additional image')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _propertyController.addProperty(
        title: _titleController.text,
        location: _locationController.text,
        price: double.parse(_priceController.text),
        thumbnailImage: _thumbnailImage!,
        additionalImages: _additionalImages,
        ownerId: '2', // Using Jane Smith's ID for demo
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

}
