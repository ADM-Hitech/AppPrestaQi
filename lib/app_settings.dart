class AppSettings {

  String apiUrl;
  bool envProd;

  AppSettings() {
    this.envProd = false;
    this.apiUrl = this.envProd ? 'prestaqi.com:81' : '52.255.138.106:81';
  }
}