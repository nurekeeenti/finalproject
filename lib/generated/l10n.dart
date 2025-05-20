// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Travel App`
  String get appTitle {
    return Intl.message('Travel App', name: 'appTitle', desc: '', args: []);
  }

  /// `Explore`
  String get explore {
    return Intl.message('Explore', name: 'explore', desc: '', args: []);
  }

  /// `Trips`
  String get trips {
    return Intl.message('Trips', name: 'trips', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Map`
  String get map {
    return Intl.message('Map', name: 'map', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Google Map`
  String get gmap {
    return Intl.message('Google Map', name: 'gmap', desc: '', args: []);
  }

  /// `Average Traveler`
  String get averageTraveler {
    return Intl.message(
      'Average Traveler',
      name: 'averageTraveler',
      desc: '',
      args: [],
    );
  }

  /// `Experienced Traveler`
  String get experiencedTraveler {
    return Intl.message(
      'Experienced Traveler',
      name: 'experiencedTraveler',
      desc: '',
      args: [],
    );
  }

  /// `My Favorite Destinations`
  String get myFavorites {
    return Intl.message(
      'My Favorite Destinations',
      name: 'myFavorites',
      desc: '',
      args: [],
    );
  }

  /// `You have no favorite destinations yet.`
  String get noFavorites {
    return Intl.message(
      'You have no favorite destinations yet.',
      name: 'noFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Trips`
  String get tripsTitle {
    return Intl.message('Trips', name: 'tripsTitle', desc: '', args: []);
  }

  /// `Sort A-Z`
  String get sortAZ {
    return Intl.message('Sort A-Z', name: 'sortAZ', desc: '', args: []);
  }

  /// `Sort by Date`
  String get sortDate {
    return Intl.message('Sort by Date', name: 'sortDate', desc: '', args: []);
  }

  /// `Search Trips`
  String get searchTrips {
    return Intl.message(
      'Search Trips',
      name: 'searchTrips',
      desc: '',
      args: [],
    );
  }

  /// `Add Trip`
  String get addTrip {
    return Intl.message('Add Trip', name: 'addTrip', desc: '', args: []);
  }

  /// `Add New Trip`
  String get addNewTrip {
    return Intl.message('Add New Trip', name: 'addNewTrip', desc: '', args: []);
  }

  /// `Trip Title`
  String get tripTitle {
    return Intl.message('Trip Title', name: 'tripTitle', desc: '', args: []);
  }

  /// `Please enter trip title`
  String get enterTripTitle {
    return Intl.message(
      'Please enter trip title',
      name: 'enterTripTitle',
      desc: '',
      args: [],
    );
  }

  /// `No date selected`
  String get noDateSelected {
    return Intl.message(
      'No date selected',
      name: 'noDateSelected',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Pick Date`
  String get pickDate {
    return Intl.message('Pick Date', name: 'pickDate', desc: '', args: []);
  }

  /// `Number of guests:`
  String get numGuests {
    return Intl.message(
      'Number of guests:',
      name: 'numGuests',
      desc: '',
      args: [],
    );
  }

  /// `Guests: {count}`
  String guestsCount(Object count) {
    return Intl.message(
      'Guests: $count',
      name: 'guestsCount',
      desc: '',
      args: [count],
    );
  }

  /// `New trip added`
  String get newTripDesc {
    return Intl.message(
      'New trip added',
      name: 'newTripDesc',
      desc: '',
      args: [],
    );
  }

  /// `Please pick a date`
  String get pleasePickDate {
    return Intl.message(
      'Please pick a date',
      name: 'pleasePickDate',
      desc: '',
      args: [],
    );
  }

  /// `removed`
  String get removed {
    return Intl.message('removed', name: 'removed', desc: '', args: []);
  }

  /// `Trip to Bali`
  String get tripToBali {
    return Intl.message('Trip to Bali', name: 'tripToBali', desc: '', args: []);
  }

  /// `Trip to Santorini`
  String get tripToSantorini {
    return Intl.message(
      'Trip to Santorini',
      name: 'tripToSantorini',
      desc: '',
      args: [],
    );
  }

  /// `Trip to Kyoto`
  String get tripToKyoto {
    return Intl.message(
      'Trip to Kyoto',
      name: 'tripToKyoto',
      desc: '',
      args: [],
    );
  }

  /// `Experience tropical paradise on Bali with beaches, cultural experiences, and adventures.`
  String get descBali {
    return Intl.message(
      'Experience tropical paradise on Bali with beaches, cultural experiences, and adventures.',
      name: 'descBali',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy the breathtaking sunsets, white-washed buildings, and Mediterranean charm of Santorini.`
  String get descSantorini {
    return Intl.message(
      'Enjoy the breathtaking sunsets, white-washed buildings, and Mediterranean charm of Santorini.',
      name: 'descSantorini',
      desc: '',
      args: [],
    );
  }

  /// `Discover ancient temples, cherry blossoms, and traditional Japanese culture in Kyoto.`
  String get descKyoto {
    return Intl.message(
      'Discover ancient temples, cherry blossoms, and traditional Japanese culture in Kyoto.',
      name: 'descKyoto',
      desc: '',
      args: [],
    );
  }

  /// `Map & Weather`
  String get mapTitle {
    return Intl.message('Map & Weather', name: 'mapTitle', desc: '', args: []);
  }

  /// `Bali`
  String get cityBali {
    return Intl.message('Bali', name: 'cityBali', desc: '', args: []);
  }

  /// `Santorini`
  String get citySantorini {
    return Intl.message('Santorini', name: 'citySantorini', desc: '', args: []);
  }

  /// `Kyoto`
  String get cityKyoto {
    return Intl.message('Kyoto', name: 'cityKyoto', desc: '', args: []);
  }

  /// `Astana`
  String get cityAstana {
    return Intl.message('Astana', name: 'cityAstana', desc: '', args: []);
  }

  /// `Karaganda`
  String get cityKaraganda {
    return Intl.message('Karaganda', name: 'cityKaraganda', desc: '', args: []);
  }

  /// `New York`
  String get cityNewYork {
    return Intl.message('New York', name: 'cityNewYork', desc: '', args: []);
  }

  /// `Temp: {temp}°C, {description}`
  String temperature(Object temp, Object description) {
    return Intl.message(
      'Temp: $temp°C, $description',
      name: 'temperature',
      desc: '',
      args: [temp, description],
    );
  }

  /// `Bali Resort`
  String get destinationBali {
    return Intl.message(
      'Bali Resort',
      name: 'destinationBali',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy luxury & nature in Bali.`
  String get descriptionBali {
    return Intl.message(
      'Enjoy luxury & nature in Bali.',
      name: 'descriptionBali',
      desc: '',
      args: [],
    );
  }

  /// `Santorini Escape`
  String get destinationSantorini {
    return Intl.message(
      'Santorini Escape',
      name: 'destinationSantorini',
      desc: '',
      args: [],
    );
  }

  /// `Experience the best sunsets in Santorini.`
  String get descriptionSantorini {
    return Intl.message(
      'Experience the best sunsets in Santorini.',
      name: 'descriptionSantorini',
      desc: '',
      args: [],
    );
  }

  /// `Kyoto Getaway`
  String get destinationKyoto {
    return Intl.message(
      'Kyoto Getaway',
      name: 'destinationKyoto',
      desc: '',
      args: [],
    );
  }

  /// `Discover traditional Japanese culture in Kyoto.`
  String get descriptionKyoto {
    return Intl.message(
      'Discover traditional Japanese culture in Kyoto.',
      name: 'descriptionKyoto',
      desc: '',
      args: [],
    );
  }

  /// `Adventure`
  String get categoryAdventure {
    return Intl.message(
      'Adventure',
      name: 'categoryAdventure',
      desc: '',
      args: [],
    );
  }

  /// `Culture`
  String get categoryCulture {
    return Intl.message('Culture', name: 'categoryCulture', desc: '', args: []);
  }

  /// `Nature`
  String get categoryNature {
    return Intl.message('Nature', name: 'categoryNature', desc: '', args: []);
  }

  /// `{count} destinations`
  String destinationsCount(Object count) {
    return Intl.message(
      '$count destinations',
      name: 'destinationsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Visited Bali and loved it!`
  String get activityAlice {
    return Intl.message(
      'Visited Bali and loved it!',
      name: 'activityAlice',
      desc: '',
      args: [],
    );
  }

  /// `Checked in at Santorini, amazing views.`
  String get activityBob {
    return Intl.message(
      'Checked in at Santorini, amazing views.',
      name: 'activityBob',
      desc: '',
      args: [],
    );
  }

  /// `Exploring Kyoto temples.`
  String get activityCharlie {
    return Intl.message(
      'Exploring Kyoto temples.',
      name: 'activityCharlie',
      desc: '',
      args: [],
    );
  }

  /// `Popular Destinations`
  String get popularDestinations {
    return Intl.message(
      'Popular Destinations',
      name: 'popularDestinations',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Friends Activity`
  String get friendsActivity {
    return Intl.message(
      'Friends Activity',
      name: 'friendsActivity',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get emptyCart {
    return Intl.message(
      'Your cart is empty',
      name: 'emptyCart',
      desc: '',
      args: [],
    );
  }

  /// `Edit Trip`
  String get editTrip {
    return Intl.message('Edit Trip', name: 'editTrip', desc: '', args: []);
  }

  /// `Trip details`
  String get tripDetails {
    return Intl.message(
      'Trip details',
      name: 'tripDetails',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
