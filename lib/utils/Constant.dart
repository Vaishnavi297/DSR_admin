import 'package:country_picker/country_picker.dart';

const AppName = 'DSR Admin';


const MORNING = 'Morning';
const AFTER_NOON = 'After Noon';
const EVENING = 'Evening';
const NIGHT = 'Night';

const IS_LOGGED_IN = 'IS_LOGGED_IN';
const PATIENT_MODEL = 'PATIENT_MODEL';
const UID = 'UID';
const NAME = 'NAME';
const PASSWORD = 'PASSWORD';
const USER_EMAIL = 'USER_EMAIL';

///COLLECTION
const ADMIN_COLLECTION = 'admin';
const DISEASES = 'diseases';
const PRESCRIPTION = 'prescription_list';
const PATIENTS = 'patients';
const MEDICINE = 'medicine';
const MEDICINE_HISTORY = 'medicine_history';

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

const PER_PAGE_CHAT_LIST_COUNT=15;
