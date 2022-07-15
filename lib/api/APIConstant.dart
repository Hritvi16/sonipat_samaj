import 'Environment.dart';

class APIConstant {
  static String getGSTDetails = Environment.url + Environment.api + "getGSTDetails.php";
  static String sendSMS = Environment.url + Environment.api + "sendSMS.php";
  // static String smsApi = "http://msg.rupayweb.in/api/push";
  // static String getGSTDetails = "https://gstapi.charteredinfo.com/commonapi/v1.1/search";
  // static String smsApi = "http://msg.rupayweb.in/api/push";

  static String razorpayApiKey = Environment.url + Environment.admin + "razorpay_api_key.php";
  static String insertUserFCM = Environment.url + Environment.api + "insertUserFCM.php";
  static String sendNSE = Environment.url + Environment.api + "sendNSE.php";
  static String login = Environment.url + Environment.api + "login.php";
  static String signUp = Environment.url + Environment.api + "signUp.php";
  static String manageUser = Environment.url + Environment.api + "manage-user.php";
  static String manageBanner = Environment.url + Environment.api + "manage-banner.php";
  static String manageDashboard = Environment.url + Environment.api + "getDashboard.php";
  static String manageCities = Environment.url + Environment.api + "manage-cities.php";
  static String getPopBanner = Environment.url + Environment.api + "getPopBanner.php";
  static String getBanners = Environment.url + Environment.api + "getBanners.php";
  static String manageHotels = Environment.url + Environment.api + "manage-hotels.php";
  static String manageWishlist = Environment.url + Environment.api + "manage-wishlist.php";
  static String getHotelImages = Environment.url + Environment.api + "getHotelImages.php";
  static String getHotelSlots = Environment.url + Environment.api + "getHotelSlots.php";
  static String getCategories = Environment.url + Environment.api + "getCategories.php";
  static String getAmenities = Environment.url + Environment.api + "getAmenities.php";
  static String manageHotelTimings = Environment.url + Environment.api + "manage-hotel-timings.php";
  static String manageOffers = Environment.url + Environment.api + "manage-offers.php";
  static String manageBookings = Environment.url + Environment.api + "manage-bookings.php";
  static String managePolicies = Environment.url + Environment.api + "manage-policies.php";
  static String getRequestTypes = Environment.url + Environment.api + "getRequestTypes.php";
  static String manageTickets = Environment.url + Environment.api + "manage-tickets.php";
  static String getNearbyPlaces = Environment.url + Environment.api + "getNearbyPlaces.php";
  static String getSpecialRequests = Environment.url + Environment.api + "getSpecialRequests.php";
  static String manageSearch = Environment.url + Environment.api + "manage-search.php";
  static String getOlrHelplines = Environment.url + Environment.api + "getOlrHelplines.php";
  static String getOlrHelps = Environment.url + Environment.api + "getOlrHelps.php";
  static String manageReviews = Environment.url + Environment.api + "manage-reviews.php";
  static String becomePartner = Environment.url + Environment.api + "becomePartner.php";
  static String manageAreas = Environment.url + Environment.api + "manage-areas.php";
  static String getCancellationReasons = Environment.url + Environment.api + "getCancellationReasons.php";
  // Special Requests Retrieved
  static String act = "act";
  static String offset = "offset";
  static String type = "type";

  static String SENDSA = "SENDSA";
  static String getByID = "FETCHBYID";
  static String getByBID = "FETCHBYBID";
  static String getByName = "FETCHBYNAME";
  static String getPopular = "FETCHPOPULAR";
  static String getByTime = "FETCHBYTIME";
  static String getByHotel = "FETCHBYHOTEL";
  static String getByCategory = "FETCHBYCATEGORY";
  static String getAll = "FETCHALL";
  static String getR = "FETCHR";
  static String getNR = "FETCHNR";

  static String authorization = "Authorization";
  static String token = "Bearer ";

  static String symbol = "₹";
}
