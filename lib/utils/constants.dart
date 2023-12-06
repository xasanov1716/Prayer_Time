import 'package:flutter_defualt_project/data/local/db/storage_repo.dart';

String region = StorageRepository.getString('region');
int month = DateTime.now().month;

bool isBoarding = false;




List<String> regions = [
  'Andijon',
  'Buxoro',
  "Farg'ona",
  'Jizzax',
  'Namangan',
  'Navoiy',
  "Qoraqalpog'iston",
  "Samarqand",
  'Toshkent'
];

List<String> regionsEng = [
  'Andijan',
  'Bukhara',
  'Fergana',
  'Jizzakh',
  'Namangan',
  'Navoiy',
  'Karakalpakstan',
  'Samarqand',
  'Tashkent'
];


String switchRegion(String ){
  switch(region){
    case 'Toshkent':
      return 'Tashkent';
    case 'Namangan':
      return 'Namangan';
    case 'Navoiy':
      return 'Navoiy';
    case 'Samarqand':
      return 'Samarqand';
    case "Qoraqalpog'iston":
      return 'Karakalpakstan';
    case 'Jizzah':
      return 'Jizzakh';
    case "Farg'ona":
      return 'Fergana';
    case 'Andijon':
      return 'Andijan';
    default:
      return 'Bukhara';
  }
}