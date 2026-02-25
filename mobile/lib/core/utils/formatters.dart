import 'package:intl/intl.dart';

/// Utility class for formatting data for display
class Formatters {
  Formatters._();
  
  /// Format currency for Ghana (Ghana Cedis - GHS)
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: '₵',
      decimalDigits: 2,
      locale: 'en_GH',
    );
    return formatter.format(amount);
  }
  
  /// Format phone number for Ghana (+233 format)
  static String formatPhoneNumber(String phone) {
    // Remove all non-digit characters
    String cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    
    // Handle Ghana numbers
    if (cleanPhone.startsWith('233')) {
      // Already has country code
      cleanPhone = '+$cleanPhone';
    } else if (cleanPhone.startsWith('0')) {
      // Local format (0xx xxx xxxx)
      cleanPhone = '+233${cleanPhone.substring(1)}';
    } else if (cleanPhone.length == 9) {
      // Without leading 0 (xx xxx xxxx)
      cleanPhone = '+233$cleanPhone';
    } else {
      // Assume it needs country code
      cleanPhone = '+233$cleanPhone';
    }
    
    // Format: +233 XX XXX XXXX
    if (cleanPhone.length >= 13) {
      return '${cleanPhone.substring(0, 4)} ${cleanPhone.substring(4, 6)} ${cleanPhone.substring(6, 9)} ${cleanPhone.substring(9)}';
    }
    
    return cleanPhone;
  }
  
  /// Format time ago (e.g., "2 minutes ago")
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 7) {
      return DateFormat('MMM d, yyyy').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
  
  /// Format date for display
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
  
  /// Format time for display
  static String formatTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }
  
  /// Format date and time for display
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy · h:mm a').format(dateTime);
  }
  
  /// Format duration in minutes to readable format
  static String formatDuration(int minutes) {
    if (minutes < 60) {
      return '$minutes min${minutes == 1 ? '' : 's'}';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      if (remainingMinutes == 0) {
        return '$hours hour${hours == 1 ? '' : 's'}';
      } else {
        return '$hours hr ${remainingMinutes}m';
      }
    }
  }
  
  /// Format Duration object to readable format (e.g., "1:23:45" or "2:34")
  static String formatDurationFromDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    if (hours > 0) {
      return '${hours.toString().padLeft(1, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(1, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }
  
  /// Format relative date (e.g., "2 days ago", "Today")
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    final difference = today.difference(dateOnly).inDays;
    
    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return weeks == 1 ? '1 week ago' : '$weeks weeks ago';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }
  
  /// Format lawyer experience years
  static String formatExperience(int yearCalledToBar) {
    final currentYear = DateTime.now().year;
    final experience = currentYear - yearCalledToBar;
    
    if (experience <= 0) return 'New to practice';
    if (experience == 1) return '1 year experience';
    return '$experience years experience';
  }
  
  /// Format rating with stars
  static String formatRating(double rating, int count) {
    if (count == 0) return 'No ratings yet';
    return '${rating.toStringAsFixed(1)} ($count review${count == 1 ? '' : 's'})';
  }
  
  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  
  /// Format number with commas
  static String formatNumber(int number) {
    return NumberFormat('#,###').format(number);
  }
  
  /// Capitalize first letter of each word
  static String capitalizeWords(String text) {
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
  
  /// Extract initials from full name
  static String getInitials(String fullName) {
    final parts = fullName.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
    }
  }
  
  /// Format consultation status for display
  static String formatConsultationStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'active':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return capitalizeWords(status);
    }
  }
  
  /// Format payment provider name
  static String formatPaymentProvider(String provider) {
    switch (provider.toLowerCase()) {
      case 'mtn':
        return 'MTN Mobile Money';
      case 'vodafone':
        return 'Vodafone Cash';
      case 'airteltigo':
        return 'AirtelTigo Money';
      case 'bank':
        return 'Bank Transfer';
      default:
        return capitalizeWords(provider);
    }
  }

  /// Format relative time (e.g., "2h ago", "Just now")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}

/// Number input formatter for phone numbers
class PhoneNumberFormatter {
  static String format(String value) {
    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Handle different input scenarios
    if (digitsOnly.isEmpty) return '';
    
    // Ghana format: 0XX XXX XXXX or +233 XX XXX XXXX
    if (digitsOnly.startsWith('0') && digitsOnly.length <= 10) {
      // Local format
      final buffer = StringBuffer();
      for (int i = 0; i < digitsOnly.length; i++) {
        if (i == 0) {
          buffer.write('0');
        } else if (i == 3 || i == 6) {
          buffer.write(' ');
        }
        if (i > 0) {
          buffer.write(digitsOnly[i]);
        }
      }
      return buffer.toString();
    } else if (digitsOnly.startsWith('233') && digitsOnly.length <= 12) {
      // International format
      final buffer = StringBuffer('+233 ');
      final localPart = digitsOnly.substring(3);
      for (int i = 0; i < localPart.length; i++) {
        if (i == 2 || i == 5) buffer.write(' ');
        buffer.write(localPart[i]);
      }
      return buffer.toString();
    }
    
    return value;
  }
}

/// OTP input formatter (6 digits)
class OtpFormatter {
  static String format(String value) {
    // Only allow digits, max 6 characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length > 6) return digitsOnly.substring(0, 6);
    return digitsOnly;
  }
}