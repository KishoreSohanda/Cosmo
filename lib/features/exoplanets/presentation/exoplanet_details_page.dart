import 'package:flutter/material.dart';
import 'package:cosmo/l10n/app_localizations.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/animations/app_animations.dart';
import '../../../core/extensions/spacing_extensions.dart';
import '../data/models/exoplanet_model.dart';

class ExoplanetDetailsPage extends StatelessWidget {
  final ExoplanetModel exoplanet;

  const ExoplanetDetailsPage({super.key, required this.exoplanet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context)!;

    final overview = <_PlanetFact>[
      _PlanetFact(l.hostStar, exoplanet.hostName, Icons.star_outline),
      _PlanetFact(
        l.distanceFromEarth,
        _format(exoplanet.distanceLightYears, l.lightYears, decimals: 2),
        Icons.place_outlined,
      ),
      _PlanetFact(
        l.discoveryYear,
        exoplanet.discoveryYear?.toString(),
        Icons.calendar_today_outlined,
      ),
      _PlanetFact(l.discoveryMethod, exoplanet.discoveryMethod, Icons.search),
      _PlanetFact(
        l.planetsInSystem,
        exoplanet.planetCount?.toString(),
        Icons.public,
      ),
      _PlanetFact(
        l.starsInSystem,
        exoplanet.starCount?.toString(),
        Icons.auto_awesome,
      ),
    ];

    final physicalProperties = <_PlanetFact>[
      _PlanetFact(
        l.planetRadiusEarth,
        _format(exoplanet.radiusEarth, l.earthRadii),
        Icons.circle_outlined,
        detail: _uncertainty(
          exoplanet.radiusUncertaintyUpper,
          exoplanet.radiusUncertaintyLower,
          l,
        ),
      ),
      _PlanetFact(
        l.planetRadiusJupiter,
        _format(exoplanet.radiusJupiter, l.jupiterRadii),
        Icons.radio_button_unchecked,
      ),
      _PlanetFact(
        l.planetMassEarth,
        _format(exoplanet.massEarth, l.earthMasses),
        Icons.scale_outlined,
        detail: _uncertainty(
          exoplanet.massUncertaintyUpper,
          exoplanet.massUncertaintyLower,
          l,
        ),
      ),
      _PlanetFact(
        l.planetMassJupiter,
        _format(exoplanet.massJupiter, l.jupiterMasses),
        Icons.monitor_weight_outlined,
      ),
      _PlanetFact(
        l.planetDensity,
        _format(exoplanet.density, l.gramsPerCubicCentimeter),
        Icons.water_drop_outlined,
      ),
      _PlanetFact(
        l.equilibriumTemperature,
        _format(exoplanet.equilibriumTemperature, l.kelvin),
        Icons.thermostat_outlined,
        detail: _uncertainty(
          exoplanet.temperatureUncertaintyUpper,
          exoplanet.temperatureUncertaintyLower,
          l,
        ),
      ),
      _PlanetFact(
        l.temperatureCelsius,
        exoplanet.equilibriumTemperature == null
            ? null
            : '${(exoplanet.equilibriumTemperature! - 273.15).toStringAsFixed(1)} °C',
        Icons.device_thermostat,
      ),
      _PlanetFact(
        l.stellarEnergyReceived,
        _format(exoplanet.stellarFlux, l.earthFluxUnits),
        Icons.wb_sunny_outlined,
      ),
      _PlanetFact(
        l.transmissionSpectroscopyMetric,
        exoplanet.transmissionSpectroscopyMetric?.toStringAsFixed(2),
        Icons.science_outlined,
        detail: l.transmissionMetricDescription,
      ),
      _PlanetFact(
        l.emissionSpectroscopyMetric,
        exoplanet.emissionSpectroscopyMetric?.toStringAsFixed(2),
        Icons.biotech_outlined,
        detail: l.emissionMetricDescription,
      ),
    ];

    final orbitalProperties = <_PlanetFact>[
      _PlanetFact(
        l.orbitalPeriod,
        _format(exoplanet.orbitalPeriod, l.earthDays),
        Icons.timelapse,
        detail: _uncertainty(
          exoplanet.orbitalPeriodUncertaintyUpper,
          exoplanet.orbitalPeriodUncertaintyLower,
          l,
        ),
      ),
      _PlanetFact(
        l.distanceFromHostStar,
        _format(exoplanet.semiMajorAxis, l.astronomicalUnits),
        Icons.compare_arrows,
        detail: l.averageOrbitalDistanceDescription,
      ),
      _PlanetFact(
        l.orbitalInclination,
        _format(exoplanet.orbitalInclination, '°'),
        Icons.rotate_right,
      ),
      _PlanetFact(
        l.orbitalEccentricity,
        exoplanet.orbitalEccentricity?.toStringAsFixed(4),
        Icons.track_changes,
        detail: l.eccentricityDescription,
      ),
      _PlanetFact(
        l.argumentOfPeriastron,
        _format(exoplanet.argumentOfPeriastron, '°'),
        Icons.explore_outlined,
      ),
      _PlanetFact(
        l.impactParameter,
        exoplanet.impactParameter?.toStringAsFixed(3),
        Icons.linear_scale,
      ),
      _PlanetFact(
        l.transitDepth,
        _format(exoplanet.transitDepth, '%'),
        Icons.remove_red_eye_outlined,
        detail: [
          l.transitDepthDescription,
          _uncertainty(
            exoplanet.transitDepthUncertaintyUpper,
            exoplanet.transitDepthUncertaintyLower,
            l,
          ),
        ].whereType<String>().join('\n'),
      ),
      _PlanetFact(
        l.transitDuration,
        _format(exoplanet.transitDuration, l.hours),
        Icons.hourglass_bottom,
      ),
      _PlanetFact(
        l.transitMidpoint,
        exoplanet.transitMidpoint?.toStringAsFixed(5),
        Icons.schedule,
        detail: exoplanet.transitMidpointTimeSystem,
      ),
      _PlanetFact(
        l.projectedObliquity,
        _format(exoplanet.projectedObliquity, '°'),
        Icons.sync,
      ),
      _PlanetFact(
        l.trueObliquity,
        _format(exoplanet.trueObliquity, '°'),
        Icons.threed_rotation,
      ),
      _PlanetFact(
        l.radialVelocityAmplitude,
        _format(exoplanet.radialVelocityAmplitude, l.metersPerSecond),
        Icons.speed,
        detail: l.radialVelocityDescription,
      ),
    ];

    final hostStarProperties = <_PlanetFact>[
      _PlanetFact(
        l.spectralType,
        exoplanet.starSpectralType,
        Icons.stars_outlined,
      ),
      _PlanetFact(
        l.starTemperature,
        _format(exoplanet.starTemperature, l.kelvin),
        Icons.thermostat_outlined,
      ),
      _PlanetFact(
        l.starMass,
        _format(exoplanet.starMass, l.solarMasses),
        Icons.scale_outlined,
      ),
      _PlanetFact(
        l.starRadius,
        _format(exoplanet.starRadius, l.solarRadii),
        Icons.circle_outlined,
      ),
      _PlanetFact(
        l.starDensity,
        _format(exoplanet.starDensity, l.gramsPerCubicCentimeter),
        Icons.water_drop_outlined,
      ),
      _PlanetFact(
        l.starAge,
        _format(exoplanet.starAge, l.billionYears),
        Icons.history,
      ),
      _PlanetFact(
        l.metallicity,
        exoplanet.starMetallicity?.toStringAsFixed(3),
        Icons.science_outlined,
        detail: l.metallicityDescription,
      ),
      _PlanetFact(
        l.starLuminosity,
        exoplanet.starLuminosity == null
            ? null
            : '${exoplanet.starLuminosity!.toStringAsFixed(3)} log(L☉)',
        Icons.light_mode_outlined,
        detail: l.luminosityDescription,
      ),
      _PlanetFact(
        l.starSurfaceGravity,
        _format(exoplanet.starSurfaceGravity, l.logGravityUnit),
        Icons.arrow_downward,
      ),
      _PlanetFact(
        l.starRotationPeriod,
        _format(exoplanet.starRotationPeriod, l.days),
        Icons.sync,
      ),
      _PlanetFact(
        l.starRadialVelocity,
        _format(exoplanet.starRadialVelocity, l.kilometersPerSecond),
        Icons.speed,
      ),
    ];

    final discoveryProperties = <_PlanetFact>[
      _PlanetFact(
        l.discoveryFacility,
        exoplanet.discoveryFacility,
        Icons.location_city_outlined,
      ),
      _PlanetFact(
        l.discoveryInstrument,
        exoplanet.discoveryInstrument,
        Icons.camera_alt_outlined,
      ),
      _PlanetFact(
        l.discoveryTelescope,
        exoplanet.discoveryTelescope,
        Icons.travel_explore,
      ),
    ];

    final locationProperties = <_PlanetFact>[
      _PlanetFact(
        l.rightAscension,
        exoplanet.rightAscensionText ?? _format(exoplanet.rightAscension, '°'),
        Icons.explore_outlined,
      ),
      _PlanetFact(
        l.declination,
        exoplanet.declinationText ?? _format(exoplanet.declination, '°'),
        Icons.explore,
      ),
    ];

    final observationProperties = <_PlanetFact>[
      _PlanetFact(
        l.transmissionSpectra,
        exoplanet.transmissionSpectraCount?.toString(),
        Icons.waves_outlined,
        detail: l.transmissionSpectraDescription,
      ),
      _PlanetFact(
        l.emissionSpectra,
        exoplanet.emissionSpectraCount?.toString(),
        Icons.multiline_chart,
        detail: l.emissionSpectraDescription,
      ),
      _PlanetFact(
        l.jwstTransitObservations,
        exoplanet.jwstTransitObservations?.toString(),
        Icons.visibility_outlined,
      ),
      _PlanetFact(
        l.jwstEclipseObservations,
        exoplanet.jwstEclipseObservations?.toString(),
        Icons.visibility,
      ),
      _PlanetFact(
        l.visualMagnitude,
        exoplanet.visualMagnitude?.toStringAsFixed(2),
        Icons.brightness_6_outlined,
        detail: l.visualMagnitudeDescription,
      ),
      _PlanetFact(
        l.gaiaMagnitude,
        exoplanet.apparentMagnitude?.toStringAsFixed(2),
        Icons.brightness_5_outlined,
        detail: l.gaiaMagnitudeDescription,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            title: Text(l.planetDetails),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.1, -0.1),
                    radius: 0.9,
                    colors: [
                      Color(0xFF3459A8),
                      Color(0xFF151B35),
                      Color(0xFF050816),
                    ],
                  ),
                ),
                child: Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.85, end: 1),
                    duration: AppAnimations.slow,
                    curve: AppAnimations.emphasized,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF8DB9FF),
                            Color(0xFF3867B7),
                            Color(0xFF17294F),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF4F8EF7,
                            ).withValues(alpha: 0.35),
                            blurRadius: 45,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppTheme.spacing20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(exoplanet.name, style: theme.textTheme.headlineMedium),
                AppTheme.spacing8.verticalSpace,
                Text(
                  exoplanet.discoveryMethod ?? l.discoveryMethodUnavailable,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTheme.spacing16.verticalSpace,
                Text(l.beyondOurSolarSystem, style: theme.textTheme.titleLarge),
                AppTheme.spacing8.verticalSpace,
                Text(
                  l.exoplanetIntroduction(exoplanet.name, exoplanet.hostName),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppTheme.spacing24.verticalSpace,
                _FactSection(
                  title: l.planetOverview,
                  subtitle: l.planetOverviewSubtitle,
                  icon: Icons.public,
                  facts: overview,
                ),
                _FactSection(
                  title: l.physicalProperties,
                  subtitle: l.physicalPropertiesSubtitle,
                  icon: Icons.science_outlined,
                  facts: physicalProperties,
                ),
                _FactSection(
                  title: l.orbitAndMotion,
                  subtitle: l.orbitAndMotionSubtitle,
                  icon: Icons.blur_circular,
                  facts: orbitalProperties,
                ),
                _FactSection(
                  title: l.hostStarSection,
                  subtitle: l.hostStarSubtitle,
                  icon: Icons.star_outline,
                  facts: hostStarProperties,
                ),
                _FactSection(
                  title: l.discoveryDetails,
                  subtitle: l.discoveryDetailsSubtitle,
                  icon: Icons.search,
                  facts: discoveryProperties,
                ),
                _FactSection(
                  title: l.celestialCoordinates,
                  subtitle: l.celestialCoordinatesSubtitle,
                  icon: Icons.explore_outlined,
                  facts: locationProperties,
                ),
                _FactSection(
                  title: l.observationsAndBrightness,
                  subtitle: l.observationsAndBrightnessSubtitle,
                  icon: Icons.visibility_outlined,
                  facts: observationProperties,
                ),
                AppTheme.spacing8.verticalSpace,
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppTheme.radius14),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                      ),
                      AppTheme.spacing12.horizontalSpace,
                      Expanded(
                        child: Text(
                          l.habitabilityDisclaimer,
                          style: theme.textTheme.bodySmall?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppTheme.spacing24.verticalSpace,
              ]),
            ),
          ),
        ],
      ),
    );
  }

  static String? _format(double? value, String unit, {int decimals = 2}) {
    if (value == null || !value.isFinite) return null;
    return '${value.toStringAsFixed(decimals)} $unit';
  }

  static String? _uncertainty(
    double? upper,
    double? lower,
    AppLocalizations l,
  ) {
    if (upper == null && lower == null) return null;

    final upperText = upper == null ? null : '+${upper.abs()}';
    final lowerText = lower == null ? null : '-${lower.abs()}';

    if (upperText != null && lowerText != null) {
      return l.reportedUncertainty(upperText, lowerText);
    }

    return l.reportedUncertainty(upperText ?? '', lowerText ?? '');
  }
}

class _PlanetFact {
  final String label;
  final String? value;
  final IconData icon;
  final String? detail;

  const _PlanetFact(this.label, this.value, this.icon, {this.detail});
}

class _FactSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<_PlanetFact> facts;

  const _FactSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.facts,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableFacts = facts
        .where((fact) => fact.value != null && fact.value!.trim().isNotEmpty)
        .toList();

    if (availableFacts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              AppTheme.spacing12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleLarge),
                    AppTheme.spacing4.verticalSpace,
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppTheme.spacing16.verticalSpace,
          ...availableFacts.map(
            (fact) => Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacing12),
              child: _FactCard(
                icon: fact.icon,
                label: fact.label,
                value: fact.value!,
                detail: fact.detail,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String? detail;

  const _FactCard({
    required this.icon,
    required this.label,
    required this.value,
    this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radius14),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 24),
          AppTheme.spacing16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AppTheme.spacing4.verticalSpace,
                Text(value, style: theme.textTheme.titleSmall),
                if (detail != null) ...[
                  AppTheme.spacing4.verticalSpace,
                  Text(
                    detail!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      height: 1.4,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
