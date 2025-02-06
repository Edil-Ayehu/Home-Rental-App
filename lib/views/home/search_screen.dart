import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/models/property_model.dart';
import '../../core/constants/color_constants.dart';
import '../../widgets/property/property_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'House', 'Apartment', 'Villa', 'Office'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.surface,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: AppColors.textPrimary,
                      onPressed: () => context.pop(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search properties...',
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(filter),
                      onSelected: (selected) {
                        setState(() => _selectedFilter = filter);
                      },
                      backgroundColor: AppColors.surface,
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: isSelected ? AppColors.surface : AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  childAspectRatio: 0.7,
                ),
                itemCount: Property.dummyProperties.length,
                itemBuilder: (context, index) {
                  final property = Property.dummyProperties[index];
                  return PropertyCard(
                    onTap: () => context.push(
                      '/property/${property.id}',
                      extra: property,
                    ),
                    property: property,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
