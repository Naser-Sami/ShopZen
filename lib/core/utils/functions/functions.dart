// Packages
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

// Files
import '/core/utils/_utils.dart';

class TFunctions {
  TFunctions._();

  // Is Dark Mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // URL Launcher
  static Future<void> launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // FOR SVG ICONS
  static String getIconSVG(String name) {
    try {
      return '${Constants.pathSystemIcons}$name.svg';
    } catch (e) {
      return '';
    }
  }

  // FOR PNG IMAGES
  static String getPngImage(String name) {
    try {
      return '${Constants.pathImages}$name.png';
    } catch (e) {
      return '';
    }
  }

  // Get Last 4 Digits in a String
  static String? returnLastNDigits(String? text, int? digits) {
    try {
      if (text == null) {
        return '';
      } else if (digits == null) {
        return '';
      } else {
        return text.substring(text.length - digits);
      }
    } catch (e) {
      return '';
    }
  }
}
