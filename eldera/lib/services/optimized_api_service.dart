import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/memory_optimizer.dart';
import '../utils/secure_logger.dart';
import '../config/environment_config.dart';

/// Optimized API service for low-end devices with better timeout handling
class OptimizedApiService {
  static final OptimizedApiService _instance = OptimizedApiService._internal();
  factory OptimizedApiService() => _instance;
  OptimizedApiService._internal();

  // Base configuration derived from environment
  static String get baseUrl => '${EnvironmentConfig.apiBaseUrl}/api';
  static String get webBaseUrl => '${EnvironmentConfig.apiBaseUrl}/api';

  // Timeout configurations based on device capability
  static Duration get _connectTimeout {
    return MemoryOptimizer.isBudgetDevice()
        ? const Duration(seconds: 15) // Longer timeout for budget devices
        : const Duration(seconds: 10);
  }

  static Duration get _receiveTimeout {
    return MemoryOptimizer.isBudgetDevice()
        ? const Duration(seconds: 30) // Longer timeout for budget devices
        : const Duration(seconds: 20);
  }

  // Retry configuration
  static int get _maxRetries {
    return MemoryOptimizer.isBudgetDevice() ? 2 : 3;
  }

  static Duration get _retryDelay {
    return MemoryOptimizer.isBudgetDevice()
        ? const Duration(seconds: 2)
        : const Duration(seconds: 1);
  }

  String? _authToken;
  late http.Client _httpClient;

  /// Initialize the service
  void initialize() {
    _httpClient = http.Client();
    SecureLogger.info(
        'OptimizedApiService initialized for ${MemoryOptimizer.isBudgetDevice() ? "budget" : "standard"} device');
  }

  /// Set authorization token
  void setAuthToken(String token) {
    _authToken = token;
    SecureLogger.info('Auth token updated');
  }

  /// Clear authorization token
  void clearAuthToken() {
    _authToken = null;
    SecureLogger.info('Auth token cleared');
  }

  /// Get headers with optimizations
  Map<String, String> _getHeaders({Map<String, String>? additionalHeaders}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent':
          'ELDERA-Mobile/${MemoryOptimizer.isBudgetDevice() ? "Budget" : "Standard"}',
    };

    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  /// Execute HTTP request with retry logic and optimizations
  Future<http.Response> _executeRequest(
    Future<http.Response> Function() requestFunction,
    String method,
    String endpoint,
  ) async {
    int attempts = 0;
    Exception? lastException;

    while (attempts < _maxRetries) {
      attempts++;

      try {
        SecureLogger.info('API Request: $method $endpoint (Attempt $attempts)');

        final response = await requestFunction().timeout(
          _receiveTimeout,
          onTimeout: () {
            throw TimeoutException(
                'Request timeout after ${_receiveTimeout.inSeconds}s',
                _receiveTimeout);
          },
        );

        SecureLogger.info(
            'API Response: ${response.statusCode} for $method $endpoint');

        // Success or client error (don't retry client errors)
        if (response.statusCode < 500) {
          return response;
        }

        // Server error - retry if not last attempt
        if (attempts < _maxRetries) {
          SecureLogger.warning(
              'Server error ${response.statusCode}, retrying in ${_retryDelay.inSeconds}s...');
          await Future.delayed(_retryDelay);
          continue;
        }

        return response;
      } on SocketException catch (e) {
        lastException = e;
        SecureLogger.error('Network error on attempt $attempts: $e');

        if (attempts < _maxRetries) {
          await Future.delayed(_retryDelay);
          continue;
        }
      } on TimeoutException catch (e) {
        lastException = e;
        SecureLogger.error('Timeout on attempt $attempts: $e');

        if (attempts < _maxRetries) {
          await Future.delayed(_retryDelay);
          continue;
        }
      } on Exception catch (e) {
        lastException = e;
        SecureLogger.error('Request error on attempt $attempts: $e');

        // Don't retry for non-network errors
        break;
      }
    }

    // All attempts failed
    throw lastException ?? Exception('Request failed after $attempts attempts');
  }

  /// Optimized GET request
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      String url = '$baseUrl$endpoint';

      if (queryParams != null && queryParams.isNotEmpty) {
        final queryString = queryParams.entries
            .map((e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
            .join('&');
        url += '?$queryString';
      }

      final response = await _executeRequest(
        () => _httpClient.get(
          Uri.parse(url),
          headers: _getHeaders(additionalHeaders: headers),
        ),
        'GET',
        endpoint,
      );

      return _handleResponse(response);
    } catch (e) {
      SecureLogger.error('GET request failed for $endpoint: $e');
      rethrow;
    }
  }

  /// Optimized POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _executeRequest(
        () => _httpClient.post(
          Uri.parse('$baseUrl$endpoint'),
          headers: _getHeaders(additionalHeaders: headers),
          body: data != null ? jsonEncode(data) : null,
        ),
        'POST',
        endpoint,
      );

      return _handleResponse(response);
    } catch (e) {
      SecureLogger.error('POST request failed for $endpoint: $e');
      rethrow;
    }
  }

  /// Optimized PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _executeRequest(
        () => _httpClient.put(
          Uri.parse('$baseUrl$endpoint'),
          headers: _getHeaders(additionalHeaders: headers),
          body: data != null ? jsonEncode(data) : null,
        ),
        'PUT',
        endpoint,
      );

      return _handleResponse(response);
    } catch (e) {
      SecureLogger.error('PUT request failed for $endpoint: $e');
      rethrow;
    }
  }

  /// Optimized DELETE request
  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _executeRequest(
        () => _httpClient.delete(
          Uri.parse('$baseUrl$endpoint'),
          headers: _getHeaders(additionalHeaders: headers),
        ),
        'DELETE',
        endpoint,
      );

      return _handleResponse(response);
    } catch (e) {
      SecureLogger.error('DELETE request failed for $endpoint: $e');
      rethrow;
    }
  }

  /// Handle API response with memory optimization
  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      if (response.body.isEmpty) {
        return {
          'success': response.statusCode >= 200 && response.statusCode < 300
        };
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      // Add status code to response for better error handling
      data['_statusCode'] = response.statusCode;

      return data;
    } catch (e) {
      SecureLogger.error('Failed to parse response: $e');
      throw Exception('Invalid response format: ${e.toString()}');
    }
  }

  /// Check network connectivity (simplified for budget devices)
  Future<bool> checkConnectivity() async {
    try {
      final response = await _httpClient
          .get(Uri.parse('$baseUrl/health'))
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      SecureLogger.warning('Connectivity check failed: $e');
      return false;
    }
  }

  /// Get optimized request configuration info
  Map<String, dynamic> getConfigInfo() {
    return {
      'isBudgetDevice': MemoryOptimizer.isBudgetDevice(),
      'connectTimeout': _connectTimeout.inSeconds,
      'receiveTimeout': _receiveTimeout.inSeconds,
      'maxRetries': _maxRetries,
      'retryDelay': _retryDelay.inSeconds,
      'baseUrl': baseUrl,
    };
  }

  /// Dispose resources
  void dispose() {
    _httpClient.close();
    SecureLogger.info('OptimizedApiService disposed');
  }

  /// Enable aggressive timeouts for low-end devices
  void enableAggressiveTimeouts() {
    // This method is called by LowEndDeviceHandler
    // The timeout configuration is already handled in the static getters
    SecureLogger.info('Aggressive timeouts enabled for budget device');
  }
}
