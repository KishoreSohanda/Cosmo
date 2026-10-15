import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Cosmo'**
  String get appName;

  /// No description provided for @exploreTheUniverse.
  ///
  /// In en, this message translates to:
  /// **'Explore the Universe'**
  String get exploreTheUniverse;

  /// No description provided for @goodEveningExplorer.
  ///
  /// In en, this message translates to:
  /// **'Good evening, Explorer 👋'**
  String get goodEveningExplorer;

  /// No description provided for @goodAfternoonExplorer.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon, Explorer 👋'**
  String get goodAfternoonExplorer;

  /// No description provided for @goodMorningExplorer.
  ///
  /// In en, this message translates to:
  /// **'Good morning, Explorer 👋'**
  String get goodMorningExplorer;

  /// No description provided for @upcomingLaunches.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Launches'**
  String get upcomingLaunches;

  /// No description provided for @closeApproaches.
  ///
  /// In en, this message translates to:
  /// **'Close Approaches'**
  String get closeApproaches;

  /// No description provided for @exploreMore.
  ///
  /// In en, this message translates to:
  /// **'Explore More'**
  String get exploreMore;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @asteroids.
  ///
  /// In en, this message translates to:
  /// **'Asteroids'**
  String get asteroids;

  /// No description provided for @launches.
  ///
  /// In en, this message translates to:
  /// **'Launches'**
  String get launches;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutCosmo.
  ///
  /// In en, this message translates to:
  /// **'About Cosmo'**
  String get aboutCosmo;

  /// No description provided for @apiSources.
  ///
  /// In en, this message translates to:
  /// **'API Sources'**
  String get apiSources;

  /// No description provided for @creditsAndLicenses.
  ///
  /// In en, this message translates to:
  /// **'Credits & Licenses'**
  String get creditsAndLicenses;

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get app;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @astronomyPictureOfTheDay.
  ///
  /// In en, this message translates to:
  /// **'Astronomy Picture of the Day'**
  String get astronomyPictureOfTheDay;

  /// No description provided for @nasaImages.
  ///
  /// In en, this message translates to:
  /// **'NASA Images'**
  String get nasaImages;

  /// No description provided for @nasaImagesDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore NASA\'s collection of space imagery'**
  String get nasaImagesDescription;

  /// No description provided for @exoplanets.
  ///
  /// In en, this message translates to:
  /// **'Exoplanets'**
  String get exoplanets;

  /// No description provided for @exoplanetsDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover worlds beyond our solar system'**
  String get exoplanetsDescription;

  /// No description provided for @discoverTheUniverse.
  ///
  /// In en, this message translates to:
  /// **'Discover the Universe'**
  String get discoverTheUniverse;

  /// No description provided for @exploreApodDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the universe through daily astronomy images'**
  String get exploreApodDescription;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @noLaunchesFound.
  ///
  /// In en, this message translates to:
  /// **'No launches available.'**
  String get noLaunchesFound;

  /// No description provided for @apodLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load astronomy pictures.'**
  String get apodLoadError;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @noApodPictures.
  ///
  /// In en, this message translates to:
  /// **'No astronomy pictures available.'**
  String get noApodPictures;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetails;

  /// No description provided for @nasaImageLibrary.
  ///
  /// In en, this message translates to:
  /// **'NASA Image Library'**
  String get nasaImageLibrary;

  /// No description provided for @nasaImageDetailsAbout.
  ///
  /// In en, this message translates to:
  /// **'About this image'**
  String get nasaImageDetailsAbout;

  /// No description provided for @nasaImageDetailsKeywords.
  ///
  /// In en, this message translates to:
  /// **'Keywords'**
  String get nasaImageDetailsKeywords;

  /// No description provided for @nasaImageDetailsImageInformation.
  ///
  /// In en, this message translates to:
  /// **'Image information'**
  String get nasaImageDetailsImageInformation;

  /// No description provided for @nasaImageDetailsNasaId.
  ///
  /// In en, this message translates to:
  /// **'NASA ID'**
  String get nasaImageDetailsNasaId;

  /// No description provided for @nasaImageDetailsDateCreated.
  ///
  /// In en, this message translates to:
  /// **'Date created'**
  String get nasaImageDetailsDateCreated;

  /// No description provided for @nasaImageDetailsNasaCenter.
  ///
  /// In en, this message translates to:
  /// **'NASA center'**
  String get nasaImageDetailsNasaCenter;

  /// No description provided for @nasaImageDetailsCreator.
  ///
  /// In en, this message translates to:
  /// **'Creator'**
  String get nasaImageDetailsCreator;

  /// No description provided for @nasaImageDetailsPhotographer.
  ///
  /// In en, this message translates to:
  /// **'Photographer'**
  String get nasaImageDetailsPhotographer;

  /// No description provided for @nasaImageDetailsDimensions.
  ///
  /// In en, this message translates to:
  /// **'Dimensions'**
  String get nasaImageDetailsDimensions;

  /// No description provided for @nasaImageDetailsFormat.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get nasaImageDetailsFormat;

  /// No description provided for @nasaImageDetailsFileSize.
  ///
  /// In en, this message translates to:
  /// **'File size'**
  String get nasaImageDetailsFileSize;

  /// No description provided for @nasaImageDetailsMegapixels.
  ///
  /// In en, this message translates to:
  /// **'Megapixels'**
  String get nasaImageDetailsMegapixels;

  /// No description provided for @nasaImageDetailsAccessibleDescription.
  ///
  /// In en, this message translates to:
  /// **'Accessible description'**
  String get nasaImageDetailsAccessibleDescription;

  /// No description provided for @planetDetails.
  ///
  /// In en, this message translates to:
  /// **'Planet Details'**
  String get planetDetails;

  /// No description provided for @hostStar.
  ///
  /// In en, this message translates to:
  /// **'Host Star'**
  String get hostStar;

  /// No description provided for @distanceFromEarth.
  ///
  /// In en, this message translates to:
  /// **'Distance from Earth'**
  String get distanceFromEarth;

  /// No description provided for @discoveryYear.
  ///
  /// In en, this message translates to:
  /// **'Discovery Year'**
  String get discoveryYear;

  /// No description provided for @discoveryMethod.
  ///
  /// In en, this message translates to:
  /// **'Discovery Method'**
  String get discoveryMethod;

  /// No description provided for @planetsInSystem.
  ///
  /// In en, this message translates to:
  /// **'Planets in This System'**
  String get planetsInSystem;

  /// No description provided for @starsInSystem.
  ///
  /// In en, this message translates to:
  /// **'Stars in This System'**
  String get starsInSystem;

  /// No description provided for @lightYears.
  ///
  /// In en, this message translates to:
  /// **'light-years'**
  String get lightYears;

  /// No description provided for @planetRadiusEarth.
  ///
  /// In en, this message translates to:
  /// **'Radius (Earth)'**
  String get planetRadiusEarth;

  /// No description provided for @planetRadiusJupiter.
  ///
  /// In en, this message translates to:
  /// **'Radius (Jupiter)'**
  String get planetRadiusJupiter;

  /// No description provided for @planetMassEarth.
  ///
  /// In en, this message translates to:
  /// **'Mass (Earth)'**
  String get planetMassEarth;

  /// No description provided for @planetMassJupiter.
  ///
  /// In en, this message translates to:
  /// **'Mass (Jupiter)'**
  String get planetMassJupiter;

  /// No description provided for @planetDensity.
  ///
  /// In en, this message translates to:
  /// **'Density'**
  String get planetDensity;

  /// No description provided for @equilibriumTemperature.
  ///
  /// In en, this message translates to:
  /// **'Equilibrium Temperature'**
  String get equilibriumTemperature;

  /// No description provided for @temperatureCelsius.
  ///
  /// In en, this message translates to:
  /// **'Temperature (Celsius)'**
  String get temperatureCelsius;

  /// No description provided for @stellarEnergyReceived.
  ///
  /// In en, this message translates to:
  /// **'Stellar Energy Received'**
  String get stellarEnergyReceived;

  /// No description provided for @transmissionSpectroscopyMetric.
  ///
  /// In en, this message translates to:
  /// **'Transmission Spectroscopy Metric'**
  String get transmissionSpectroscopyMetric;

  /// No description provided for @emissionSpectroscopyMetric.
  ///
  /// In en, this message translates to:
  /// **'Emission Spectroscopy Metric'**
  String get emissionSpectroscopyMetric;

  /// No description provided for @transmissionMetricDescription.
  ///
  /// In en, this message translates to:
  /// **'A metric used to help prioritize atmospheric studies.'**
  String get transmissionMetricDescription;

  /// No description provided for @emissionMetricDescription.
  ///
  /// In en, this message translates to:
  /// **'A metric used to help prioritize atmospheric studies.'**
  String get emissionMetricDescription;

  /// No description provided for @orbitalPeriod.
  ///
  /// In en, this message translates to:
  /// **'Orbital Period'**
  String get orbitalPeriod;

  /// No description provided for @distanceFromHostStar.
  ///
  /// In en, this message translates to:
  /// **'Distance from Host Star'**
  String get distanceFromHostStar;

  /// No description provided for @orbitalInclination.
  ///
  /// In en, this message translates to:
  /// **'Orbital Inclination'**
  String get orbitalInclination;

  /// No description provided for @orbitalEccentricity.
  ///
  /// In en, this message translates to:
  /// **'Orbital Eccentricity'**
  String get orbitalEccentricity;

  /// No description provided for @transitDepth.
  ///
  /// In en, this message translates to:
  /// **'Transit Depth'**
  String get transitDepth;

  /// No description provided for @transitDuration.
  ///
  /// In en, this message translates to:
  /// **'Transit Duration'**
  String get transitDuration;

  /// No description provided for @radialVelocityAmplitude.
  ///
  /// In en, this message translates to:
  /// **'Radial Velocity Amplitude'**
  String get radialVelocityAmplitude;

  /// No description provided for @averageOrbitalDistanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Average orbital distance. One AU is Earth\'s average distance from the Sun.'**
  String get averageOrbitalDistanceDescription;

  /// No description provided for @eccentricityDescription.
  ///
  /// In en, this message translates to:
  /// **'Zero indicates a circular orbit. Higher values indicate a more elongated orbit.'**
  String get eccentricityDescription;

  /// No description provided for @transitDepthDescription.
  ///
  /// In en, this message translates to:
  /// **'The reported dip in the star\'s brightness when the planet passes in front.'**
  String get transitDepthDescription;

  /// No description provided for @radialVelocityDescription.
  ///
  /// In en, this message translates to:
  /// **'The measured scale of the host star\'s motion caused by the planet.'**
  String get radialVelocityDescription;

  /// No description provided for @spectralType.
  ///
  /// In en, this message translates to:
  /// **'Spectral Type'**
  String get spectralType;

  /// No description provided for @starTemperature.
  ///
  /// In en, this message translates to:
  /// **'Star Temperature'**
  String get starTemperature;

  /// No description provided for @starMass.
  ///
  /// In en, this message translates to:
  /// **'Star Mass'**
  String get starMass;

  /// No description provided for @starRadius.
  ///
  /// In en, this message translates to:
  /// **'Star Radius'**
  String get starRadius;

  /// No description provided for @starDensity.
  ///
  /// In en, this message translates to:
  /// **'Star Density'**
  String get starDensity;

  /// No description provided for @starAge.
  ///
  /// In en, this message translates to:
  /// **'Estimated Star Age'**
  String get starAge;

  /// No description provided for @metallicity.
  ///
  /// In en, this message translates to:
  /// **'Metallicity'**
  String get metallicity;

  /// No description provided for @metallicityDescription.
  ///
  /// In en, this message translates to:
  /// **'A measure related to the abundance of elements heavier than helium.'**
  String get metallicityDescription;

  /// No description provided for @starLuminosity.
  ///
  /// In en, this message translates to:
  /// **'Star Luminosity'**
  String get starLuminosity;

  /// No description provided for @luminosityDescription.
  ///
  /// In en, this message translates to:
  /// **'Logarithmic luminosity relative to the Sun.'**
  String get luminosityDescription;

  /// No description provided for @starSurfaceGravity.
  ///
  /// In en, this message translates to:
  /// **'Star Surface Gravity'**
  String get starSurfaceGravity;

  /// No description provided for @starRotationPeriod.
  ///
  /// In en, this message translates to:
  /// **'Star Rotation Period'**
  String get starRotationPeriod;

  /// No description provided for @starRadialVelocity.
  ///
  /// In en, this message translates to:
  /// **'Star Radial Velocity'**
  String get starRadialVelocity;

  /// No description provided for @discoveryFacility.
  ///
  /// In en, this message translates to:
  /// **'Discovery Facility'**
  String get discoveryFacility;

  /// No description provided for @discoveryInstrument.
  ///
  /// In en, this message translates to:
  /// **'Discovery Instrument'**
  String get discoveryInstrument;

  /// No description provided for @discoveryTelescope.
  ///
  /// In en, this message translates to:
  /// **'Discovery Telescope'**
  String get discoveryTelescope;

  /// No description provided for @rightAscension.
  ///
  /// In en, this message translates to:
  /// **'Right Ascension'**
  String get rightAscension;

  /// No description provided for @declination.
  ///
  /// In en, this message translates to:
  /// **'Declination'**
  String get declination;

  /// No description provided for @transmissionSpectra.
  ///
  /// In en, this message translates to:
  /// **'Transmission Spectra'**
  String get transmissionSpectra;

  /// No description provided for @emissionSpectra.
  ///
  /// In en, this message translates to:
  /// **'Emission Spectra'**
  String get emissionSpectra;

  /// No description provided for @jwstTransitObservations.
  ///
  /// In en, this message translates to:
  /// **'JWST Transit Observations'**
  String get jwstTransitObservations;

  /// No description provided for @jwstEclipseObservations.
  ///
  /// In en, this message translates to:
  /// **'JWST Eclipse Observations'**
  String get jwstEclipseObservations;

  /// No description provided for @visualMagnitude.
  ///
  /// In en, this message translates to:
  /// **'Visual Magnitude'**
  String get visualMagnitude;

  /// No description provided for @gaiaMagnitude.
  ///
  /// In en, this message translates to:
  /// **'Gaia Magnitude'**
  String get gaiaMagnitude;

  /// No description provided for @transmissionSpectraDescription.
  ///
  /// In en, this message translates to:
  /// **'Number of reported transmission spectra, when available.'**
  String get transmissionSpectraDescription;

  /// No description provided for @emissionSpectraDescription.
  ///
  /// In en, this message translates to:
  /// **'Number of reported emission spectra, when available.'**
  String get emissionSpectraDescription;

  /// No description provided for @visualMagnitudeDescription.
  ///
  /// In en, this message translates to:
  /// **'Apparent brightness in the V band. Smaller values generally mean brighter objects.'**
  String get visualMagnitudeDescription;

  /// No description provided for @gaiaMagnitudeDescription.
  ///
  /// In en, this message translates to:
  /// **'Apparent brightness measured in the Gaia photometric band.'**
  String get gaiaMagnitudeDescription;

  /// No description provided for @beyondOurSolarSystem.
  ///
  /// In en, this message translates to:
  /// **'Beyond Our Solar System'**
  String get beyondOurSolarSystem;

  /// No description provided for @discoveryMethodUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Discovery method unavailable'**
  String get discoveryMethodUnavailable;

  /// No description provided for @exoplanetIntroduction.
  ///
  /// In en, this message translates to:
  /// **'{planetName} orbits {hostName}. Explore its reported physical properties, orbit, host star, discovery and observations. Available measurements depend on what researchers have been able to determine.'**
  String exoplanetIntroduction(String planetName, String hostName);

  /// No description provided for @planetOverview.
  ///
  /// In en, this message translates to:
  /// **'Planet Overview'**
  String get planetOverview;

  /// No description provided for @planetOverviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Key facts about this planetary system'**
  String get planetOverviewSubtitle;

  /// No description provided for @physicalProperties.
  ///
  /// In en, this message translates to:
  /// **'Physical Properties'**
  String get physicalProperties;

  /// No description provided for @physicalPropertiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Size, mass, temperature and other measurements'**
  String get physicalPropertiesSubtitle;

  /// No description provided for @orbitAndMotion.
  ///
  /// In en, this message translates to:
  /// **'Orbit and Motion'**
  String get orbitAndMotion;

  /// No description provided for @orbitAndMotionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How the planet moves around its host star'**
  String get orbitAndMotionSubtitle;

  /// No description provided for @hostStarSection.
  ///
  /// In en, this message translates to:
  /// **'Host Star'**
  String get hostStarSection;

  /// No description provided for @hostStarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Properties of the star the planet orbits'**
  String get hostStarSubtitle;

  /// No description provided for @discoveryDetails.
  ///
  /// In en, this message translates to:
  /// **'Discovery Details'**
  String get discoveryDetails;

  /// No description provided for @discoveryDetailsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How and where the planet was discovered'**
  String get discoveryDetailsSubtitle;

  /// No description provided for @celestialCoordinates.
  ///
  /// In en, this message translates to:
  /// **'Celestial Coordinates'**
  String get celestialCoordinates;

  /// No description provided for @celestialCoordinatesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Position of the system in the sky'**
  String get celestialCoordinatesSubtitle;

  /// No description provided for @observationsAndBrightness.
  ///
  /// In en, this message translates to:
  /// **'Observations and Brightness'**
  String get observationsAndBrightness;

  /// No description provided for @observationsAndBrightnessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Available observation and brightness data'**
  String get observationsAndBrightnessSubtitle;

  /// No description provided for @habitabilityDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'These measurements do not establish whether the planet is habitable or supports life. Some values are estimates, and scientific measurements may change as new observations become available.'**
  String get habitabilityDisclaimer;

  /// No description provided for @reportedUncertainty.
  ///
  /// In en, this message translates to:
  /// **'Reported uncertainty: {upper} / {lower}'**
  String reportedUncertainty(String upper, String lower);

  /// No description provided for @earthRadii.
  ///
  /// In en, this message translates to:
  /// **'Earth radii'**
  String get earthRadii;

  /// No description provided for @jupiterRadii.
  ///
  /// In en, this message translates to:
  /// **'Jupiter radii'**
  String get jupiterRadii;

  /// No description provided for @earthMasses.
  ///
  /// In en, this message translates to:
  /// **'Earth masses'**
  String get earthMasses;

  /// No description provided for @jupiterMasses.
  ///
  /// In en, this message translates to:
  /// **'Jupiter masses'**
  String get jupiterMasses;

  /// No description provided for @gramsPerCubicCentimeter.
  ///
  /// In en, this message translates to:
  /// **'g/cm³'**
  String get gramsPerCubicCentimeter;

  /// No description provided for @kelvin.
  ///
  /// In en, this message translates to:
  /// **'K'**
  String get kelvin;

  /// No description provided for @earthFluxUnits.
  ///
  /// In en, this message translates to:
  /// **'Earth flux units'**
  String get earthFluxUnits;

  /// No description provided for @earthDays.
  ///
  /// In en, this message translates to:
  /// **'Earth days'**
  String get earthDays;

  /// No description provided for @astronomicalUnits.
  ///
  /// In en, this message translates to:
  /// **'AU'**
  String get astronomicalUnits;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// No description provided for @metersPerSecond.
  ///
  /// In en, this message translates to:
  /// **'m/s'**
  String get metersPerSecond;

  /// No description provided for @solarMasses.
  ///
  /// In en, this message translates to:
  /// **'Solar masses'**
  String get solarMasses;

  /// No description provided for @solarRadii.
  ///
  /// In en, this message translates to:
  /// **'Solar radii'**
  String get solarRadii;

  /// No description provided for @billionYears.
  ///
  /// In en, this message translates to:
  /// **'billion years'**
  String get billionYears;

  /// No description provided for @logGravityUnit.
  ///
  /// In en, this message translates to:
  /// **'log(cm/s²)'**
  String get logGravityUnit;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @kilometersPerSecond.
  ///
  /// In en, this message translates to:
  /// **'km/s'**
  String get kilometersPerSecond;

  /// No description provided for @argumentOfPeriastron.
  ///
  /// In en, this message translates to:
  /// **'Argument of Periastron'**
  String get argumentOfPeriastron;

  /// No description provided for @transitMidpoint.
  ///
  /// In en, this message translates to:
  /// **'Transit Midpoint'**
  String get transitMidpoint;

  /// No description provided for @transitTimeSystem.
  ///
  /// In en, this message translates to:
  /// **'Time System'**
  String get transitTimeSystem;

  /// No description provided for @impactParameter.
  ///
  /// In en, this message translates to:
  /// **'Impact Parameter'**
  String get impactParameter;

  /// No description provided for @projectedObliquity.
  ///
  /// In en, this message translates to:
  /// **'Projected Spin-Orbit Angle'**
  String get projectedObliquity;

  /// No description provided for @trueObliquity.
  ///
  /// In en, this message translates to:
  /// **'True Spin-Orbit Angle'**
  String get trueObliquity;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
