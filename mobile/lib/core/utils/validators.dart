/// Validation utility functions for LawConnect GH
class Validators {
  Validators._();
  
  /// Validate Ghana phone number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    // Ghana phone number patterns:
    // Local: 0XX XXX XXXX (10 digits total)
    // International: +233 XX XXX XXXX (12 digits after +233)
    
    if (digitsOnly.startsWith('0') && digitsOnly.length == 10) {
      // Local format validation
      final secondDigit = digitsOnly[1];
      // Valid Ghana mobile prefixes: 02x, 05x, 07x, 08x, 09x
      if (['2', '5', '7', '8', '9'].contains(secondDigit)) {
        return null; // Valid
      }
    } else if (digitsOnly.startsWith('233') && digitsOnly.length == 12) {
      // International format validation
      final localPart = digitsOnly.substring(3);
      if (localPart.length == 9) {
        final firstDigit = localPart[0];
        if (['2', '5', '7', '8', '9'].contains(firstDigit)) {
          return null; // Valid
        }
      }
    } else if (digitsOnly.length == 9) {
      // Missing leading 0, check if valid pattern
      final firstDigit = digitsOnly[0];
      if (['2', '5', '7', '8', '9'].contains(firstDigit)) {
        return null; // Valid (will be auto-formatted)
      }
    }
    
    return 'Please enter a valid Ghana phone number';
  }
  
  /// Validate OTP code (6 digits)
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'OTP code is required';
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length != 6) {
      return 'OTP must be 6 digits';
    }
    
    return null;
  }
  
  /// Validate email address (optional)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is optional
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }
  
  /// Validate full name
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    
    if (value.trim().length > 100) {
      return 'Name must be less than 100 characters';
    }
    
    // Check for at least one space (first and last name)
    if (!value.trim().contains(' ')) {
      return 'Please enter your full name (first and last name)';
    }
    
    return null;
  }
  
  /// Validate bar number for lawyers
  static String? validateBarNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bar number is required';
    }
    
    // Ghana Bar Association number format (example: GH/001/2023)
    final barRegex = RegExp(r'^GH\/\d{3,4}\/\d{4}$');
    if (!barRegex.hasMatch(value.trim().toUpperCase())) {
      return 'Please enter a valid Ghana Bar number (e.g., GH/001/2023)';
    }
    
    return null;
  }
  
  /// Validate year called to bar
  static String? validateYearCalledToBar(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Year called to bar is required';
    }
    
    final year = int.tryParse(value.trim());
    if (year == null) {
      return 'Please enter a valid year';
    }
    
    final currentYear = DateTime.now().year;
    if (year < 1960 || year > currentYear) {
      return 'Please enter a valid year between 1960 and $currentYear';
    }
    
    return null;
  }
  
  /// Validate consultation fee
  static String? validateConsultationFee(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Consultation fee is required';
    }
    
    final fee = double.tryParse(value.trim());
    if (fee == null) {
      return 'Please enter a valid amount';
    }
    
    if (fee < 10) {
      return 'Minimum consultation fee is ₵10';
    }
    
    if (fee > 1000) {
      return 'Maximum consultation fee is ₵1,000';
    }
    
    return null;
  }
  
  /// Validate problem description
  static String? validateProblemDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please describe your legal issue';
    }
    
    if (value.trim().length < 20) {
      return 'Please provide more details (at least 20 characters)';
    }
    
    if (value.trim().length > 1000) {
      return 'Description must be less than 1000 characters';
    }
    
    return null;
  }
  
  /// Validate bio for lawyers
  static String? validateBio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Professional bio is required';
    }
    
    if (value.trim().length < 50) {
      return 'Bio must be at least 50 characters';
    }
    
    if (value.trim().length > 500) {
      return 'Bio must be less than 500 characters';
    }
    
    return null;
  }
  
  /// Validate law firm name
  static String? validateLawFirm(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (value.trim().length < 2) {
        return 'Law firm name must be at least 2 characters';
      }
      if (value.trim().length > 100) {
        return 'Law firm name must be less than 100 characters';
      }
    }
    return null; // Optional field
  }
  
  /// Validate chat message
  static String? validateChatMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Message cannot be empty';
    }
    
    if (value.trim().length > 1000) {
      return 'Message must be less than 1000 characters';
    }
    
    return null;
  }
  
  /// Validate mobile money number
  static String? validateMomoNumber(String? value) {
    return validatePhoneNumber(value); // Same validation as phone number
  }
  
  /// Generic required field validator
  static String? required(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
  
  /// Validate positive number
  static String? validatePositiveNumber(String? value, [String fieldName = 'Value']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    
    final number = double.tryParse(value.trim());
    if (number == null) {
      return 'Please enter a valid number';
    }
    
    if (number <= 0) {
      return '$fieldName must be greater than 0';
    }
    
    return null;
  }
  
  /// Validate rating (1-5 stars)
  static String? validateRating(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Rating is required';
    }
    
    final rating = int.tryParse(value.trim());
    if (rating == null) {
      return 'Please enter a valid rating';
    }
    
    if (rating < 1 || rating > 5) {
      return 'Rating must be between 1 and 5 stars';
    }
    
    return null;
  }
}

/// Extension methods for string validation
extension StringValidation on String? {
  /// Check if string is null or empty
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  
  /// Check if string is a valid Ghana phone number
  bool get isValidGhanaPhone => Validators.validatePhoneNumber(this) == null;
  
  /// Check if string is a valid email
  bool get isValidEmail => Validators.validateEmail(this) == null;
  
  /// Check if string is a valid OTP
  bool get isValidOtp => Validators.validateOtp(this) == null;
}