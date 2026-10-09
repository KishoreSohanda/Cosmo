class ApiEndpoints {
  ApiEndpoints._();

  static const String nasaBaseUrl = 'https://science.nasa.gov';

  static const String apod = '/wp-json/wp/v2/apod-basic';

  static const String nasaImagesBaseUrl = 'https://images-api.nasa.gov';

  static const String nasaImagesSearch = '/search';

  static const String exoplanetBaseUrl =
      'https://exoplanetarchive.ipac.caltech.edu';

  static const String exoplanetQuery = '/TAP/sync';

  static const String asteroidBaseUrl = 'https://api.nasa.gov';

  static const String asteroidFeed = '/neo/rest/v1/feed';
}
