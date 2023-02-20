import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'Colors.dart';

const AppName = 'DSR Admin';

const String DefaultFont = "Poppins";
const String Bold = "Poppins";
const String Light = "Poppins";
const String Medium = "Poppins";
const String Regular = "Poppins";
const String SemiBold = "Poppins";

Color textPrimaryColorGlobal = textPrimaryColor;
Color textSecondaryColorGlobal = textSecondaryColor;
double textBoldSizeGlobal = 16;
double textPrimarySizeGlobal = 16;
double textSecondarySizeGlobal = 14;
String? fontFamilyBoldGlobal;
String? fontFamilyPrimaryGlobal;
String? fontFamilySecondaryGlobal;
FontWeight fontWeightBoldGlobal = FontWeight.w600;
FontWeight fontWeightPrimaryGlobal = FontWeight.normal;
FontWeight fontWeightSecondaryGlobal = FontWeight.normal;

const IS_LOGGED_IN = 'IS_LOGGED_IN';
const UID = 'UID';
const NAME = 'NAME';
const PASSWORD = 'PASSWORD';
const USER_EMAIL = 'USER_EMAIL';

///COLLECTION
const ADMIN_COLLECTION = 'admin';
const DISEASES = 'diseases';
const PRESCRIPTION = 'prescription';
const PATIENTS = 'patients';


Country defaultCountry() {
  return Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 91,
    geographic: true,
    level: 1,
    name: 'India',
    example: '9123456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
    fullExampleWithPlusSign: '+919123456789',
  );
}
