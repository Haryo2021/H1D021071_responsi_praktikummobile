class ApiUrl{
  static const String baseUrl=  "https://responsi1b.dalhaqq.xyz/api";
  static const String listmanajemen = baseUrl + '/manajemen';
  static const String createmanajemen = baseUrl + '/manajemen';

  static String updatemanajemen(int id){
    return baseUrl+ '/manajemen/'+id.toString();
  }

  static String showmanajemen(int id){
    return baseUrl+ "/manajemen/"+id.toString();
  }

  static String deletemanajemen(int id){
    return baseUrl+"/manajemen/"+ id.toString();
  }
}