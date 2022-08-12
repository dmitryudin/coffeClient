class NetworkConfiguration {
  NetworkConfiguration._privateConstructor();
  static final NetworkConfiguration _instance =
      NetworkConfiguration._privateConstructor();
  factory NetworkConfiguration() => _instance;

  String address = 'http://thefircoffe.ddns.net:5050';
  Map controllersMap = {
    'client': '/controllers/client',
    'order': "/controllers/order",
    'coffes': "/controllers/coffes",
    'coffe': "/controllers/coffe",
    'coffehouse': "/controllers/coffehouse",
    'upload_file': "/upload_file",
    'client': '/controllers/client',
    'auth': '/security/auth',
    'coffe_get': '/coffehouse/get_coffe',
    'coffe_delete': '/coffehouse/delete_coffe',
  };
}
