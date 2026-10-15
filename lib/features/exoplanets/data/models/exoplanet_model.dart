class ExoplanetModel {
  final Map<String, dynamic> data;

  const ExoplanetModel({required this.data});

  factory ExoplanetModel.fromJson(Map<String, dynamic> json) {
    return ExoplanetModel(data: Map<String, dynamic>.unmodifiable(json));
  }

  // Planet overview
  String get name => _string('pl_name') ?? 'Unknown planet';

  String get hostName => _string('hostname') ?? 'Unknown star';

  String? get discoveryMethod => _string('discoverymethod');

  String? get discoveryFacility => _string('disc_facility');

  String? get discoveryInstrument => _string('disc_instrument');

  String? get discoveryTelescope => _string('disc_telescope');

  String? get discoveryReference => _string('disc_refname');

  int? get discoveryYear => _number('disc_year')?.toInt();

  int? get planetCount => _number('sy_pnum')?.toInt();

  int? get starCount => _number('sy_snum')?.toInt();

  double? get distanceParsecs => _number('sy_dist');

  double? get distanceLightYears {
    final distance = distanceParsecs;
    return distance == null ? null : distance * 3.26156;
  }

  // Planet physical properties
  double? get radiusEarth => _number('pl_rade');

  double? get radius => radiusEarth;

  double? get radiusJupiter => _number('pl_radj');

  double? get massEarth => _number('pl_masse');

  double? get massJupiter => _number('pl_massj');

  double? get density => _number('pl_dens');

  double? get equilibriumTemperature => _number('pl_eqt');

  double? get stellarFlux => _number('pl_insol');

  double? get transmissionSpectroscopyMetric => _number('pl_tsm');

  double? get emissionSpectroscopyMetric => _number('pl_esm');

  // Orbital properties
  double? get orbitalPeriod => _number('pl_orbper');

  double? get semiMajorAxis => _number('pl_orbsmax');

  double? get orbitalInclination => _number('pl_orbincl');

  double? get orbitalEccentricity => _number('pl_orbeccen');

  double? get argumentOfPeriastron => _number('pl_orblper');

  double? get planetStarDistanceRatio => _number('pl_ratdor');

  double? get impactParameter => _number('pl_imppar');

  double? get transitDepth => _number('pl_trandep');

  double? get transitDuration => _number('pl_trandur');

  double? get radialVelocityAmplitude => _number('pl_rvamp');

  String? get planetMassProvenance => _string('pl_bmassprov');

  // Planet measurement uncertainties
  double? get orbitalPeriodUncertaintyUpper => _number('pl_orbpererr1');

  double? get orbitalPeriodUncertaintyLower => _number('pl_orbpererr2');

  double? get radiusUncertaintyUpper => _number('pl_radeerr1');

  double? get radiusUncertaintyLower => _number('pl_radeerr2');

  double? get massUncertaintyUpper => _number('pl_masseerr1');

  double? get massUncertaintyLower => _number('pl_masseerr2');

  double? get temperatureUncertaintyUpper => _number('pl_eqterr1');

  double? get temperatureUncertaintyLower => _number('pl_eqterr2');

  // Host star
  String? get starSpectralType => _string('st_spectype');

  double? get starTemperature => _number('st_teff');

  double? get starMass => _number('st_mass');

  double? get starRadius => _number('st_rad');

  double? get starDensity => _number('st_dens');

  double? get starAge => _number('st_age');

  double? get starMetallicity => _number('st_met');

  double? get starRotationPeriod => _number('st_rotp');

  double? get starLuminosity => _number('st_lum');

  double? get starSurfaceGravity => _number('st_logg');

  double? get starRadialVelocity => _number('st_radv');

  double? get starProjectedRotationVelocity => _number('st_vsin');

  // Sky coordinates
  double? get rightAscension => _number('ra');

  double? get declination => _number('dec');

  String? get rightAscensionText => _string('rastr');

  String? get declinationText => _string('decstr');

  double? get galacticLongitude => _number('glon');

  double? get galacticLatitude => _number('glat');

  double? get eclipticLongitude => _number('elon');

  double? get eclipticLatitude => _number('elat');

  // Brightness
  double? get visualMagnitude => _number('sy_vmag');

  double? get apparentMagnitude => _number('sy_gaiamag');

  double? get bMagnitude => _number('sy_bmag');

  double? get uMagnitude => _number('sy_umag');

  double? get rMagnitude => _number('sy_rmag');

  double? get iMagnitude => _number('sy_imag');

  double? get jMagnitude => _number('sy_jmag');

  double? get hMagnitude => _number('sy_hmag');

  double? get kMagnitude => _number('sy_kmag');

  double? get tessMagnitude => _number('sy_tmag');

  // Research observations
  double? get transmissionSpectraCount => _number('pl_ntranspec');

  double? get emissionSpectraCount => _number('pl_nespec');

  double? get jwstTransitObservations => _number('pl_nobs_jwst_tran');

  double? get jwstEclipseObservations => _number('pl_nobs_jwst_e');

  double? get photometryMeasurementCount => _number('st_nphot');

  double? get radialVelocityMeasurementCount => _number('st_nrvc');

  double? get stellarSpectraCount => _number('st_nspec');

  // Proper motion and parallax
  double? get parallax => _number('sy_plx');

  double? get properMotion => _number('sy_pm');

  double? get properMotionRightAscension => _number('sy_pmra');

  double? get properMotionDeclination => _number('sy_pmdec');

  double? get transitMidpoint => _number('pl_tranmid');

  String? get transitMidpointTimeSystem => _string('pl_tranmid_systemref');

  double? get transitDepthUncertaintyUpper => _number('pl_trandeperr1');

  double? get transitDepthUncertaintyLower => _number('pl_trandeperr2');

  double? get stellarTemperatureUncertaintyUpper => _number('st_tefferr1');

  double? get stellarTemperatureUncertaintyLower => _number('st_tefferr2');

  double? get hostStarAgeUncertaintyUpper => _number('st_ageerr1');

  double? get hostStarAgeUncertaintyLower => _number('st_ageerr2');

  double? get projectedObliquity => _number('pl_projobliq');

  double? get trueObliquity => _number('pl_trueobliq');

  // Safe raw access
  String? _string(String key) {
    final value = data[key];
    if (value == null) return null;

    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  double? _number(String key) {
    final value = data[key];

    if (value is num) return value.toDouble();
    if (value == null) return null;

    return double.tryParse(value.toString().trim());
  }
}
