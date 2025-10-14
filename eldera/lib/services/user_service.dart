import 'dart:typed_data';
import '../models/user.dart';
import '../utils/secure_logger.dart';
import 'api_service.dart';

/// User service for the Eldera app
class UserService {
  /// Get the current user profile
  static Future<User?> getCurrentUser() async {
    try {
      // Fetch user from localhost API using the correct senior/profile endpoint
      final response = await ApiService.get('senior/profile');

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];

        // Map Laravel API response to Flutter User model structure
        final mappedData = {
          'id': data['id']?.toString() ?? '',
          'name': data['name'] ?? '',
          'age': data['age'] ?? 0,
          'phone_number': data['contact_number'] ?? '',
          'profile_image_url': data['photo_path'],
          'id_status': 'Senior Citizen', // Default for senior users
          'is_dswd_pension_beneficiary': data['has_pension'] ?? false,
          'birth_date': data['date_of_birth'],
          'address': _buildAddressString(data['address']),
          'guardian_name': null, // Not provided by Laravel API
          'created_at': null, // Not provided by Laravel API
          'updated_at': null, // Not provided by Laravel API
        };

        return User.fromJson(mappedData);
      }
      return null;
    } catch (e) {
      SecureLogger.error('Error fetching user profile: $e');
      return null;
    }
  }

  /// Helper method to build address string from Laravel address object
  static String? _buildAddressString(Map<String, dynamic>? address) {
    if (address == null) return null;

    final parts = <String>[];
    if (address['street'] != null) parts.add(address['street']);
    if (address['barangay'] != null) parts.add(address['barangay']);
    if (address['city'] != null) parts.add(address['city']);
    if (address['province'] != null) parts.add(address['province']);
    if (address['region'] != null) parts.add(address['region']);

    return parts.isNotEmpty ? parts.join(', ') : null;
  }

  /// Update user profile
  static Future<Map<String, dynamic>> updateUserProfile(
      {required String userId,
      bool? isDswdPensionBeneficiary,
      String? name,
      String? phoneNumber,
      String? address}) async {
    try {
      // Update user profile via localhost API
      final data = {
        'user_id': userId,
        if (isDswdPensionBeneficiary != null)
          'is_dswd_pension_beneficiary': isDswdPensionBeneficiary,
        if (name != null) 'name': name,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (address != null) 'address': address,
      };

      return await ApiService.put('user/profile', data);
    } catch (e) {
      SecureLogger.error('Error updating user profile: $e');
      return {
        'success': false,
        'message': 'Failed to update profile',
      };
    }
  }

  /// Update profile image
  static Future<Map<String, dynamic>> updateProfileImage(
      {required String userId,
      required Uint8List imageBytes,
      required String fileName}) async {
    try {
      // Simulate successful image update
      return {
        'success': true,
        'imageUrl': 'https://example.com/profile.jpg',
      };
    } catch (e) {
      SecureLogger.error('Error updating profile image: $e');
      return {
        'success': false,
        'message': 'Failed to update profile image',
      };
    }
  }

  /// Download profile image
  static Future<Map<String, dynamic>> downloadProfileImage(
      {required String userId, required String imageUrl}) async {
    try {
      // Return mock image data
      return {
        'success': true,
        'imageData': null, // Would contain actual image data
      };
    } catch (e) {
      SecureLogger.error('Error downloading profile image: $e');
      return {
        'success': false,
        'message': 'Failed to download profile image',
      };
    }
  }
}