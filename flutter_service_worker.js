'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f8c3600c311b6accf68c54e3ac0f4605",
"version.json": "d2866ffaabace94c5f64c482eb42c949",
"index.html": "61bd2df60705208eb03575a7186fd17c",
"/": "61bd2df60705208eb03575a7186fd17c",
"firebase-messaging-sw.js": "797af5d166a29b443a1e2fdbaf50605d",
"main.dart.js": "3a02793ae38e60976cdd356a6fe720fe",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "483f65b890c290e9d22f9f335af24eed",
"assets/AssetManifest.json": "1a818304be4652b2dd12ed669c000a63",
"assets/NOTICES": "f0eaaf000fbc9eeac0d1f128c0cda533",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "569a95a6b0eb70620e7ca493a1f102f2",
"assets/packages/flutter_image_compress_web/assets/pica.min.js": "6208ed6419908c4b04382adc8a3053a2",
"assets/packages/mixpanel_flutter/assets/mixpanel.js": "5c717055b6683529243c292ab78aa797",
"assets/packages/google_places_flutter/images/location.json": "afa33acf2c340246c901718f4efdfccf",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "3691d91ff5f828d5f4e0a9a277a4663e",
"assets/fonts/MaterialIcons-Regular.otf": "174bd8c2a88388c625611cb42946f113",
"assets/assets/jsons/localization.json": "747735e634733ad3392da26fc4dabdbc",
"assets/assets/jsons/localization-v2.json": "498af30c427298ec911b2b09b6f5bc83",
"assets/assets/jsons/99274-loading.json": "89088f3f8bbca8b7d3b37f7002bb742d",
"assets/assets/jsons/done.json": "1c8fa00637c775887736f7f470acfa9a",
"assets/assets/jsons/remote-localization-v2.json": "2b6002142b11dfdd1594382a76ddb164",
"assets/assets/jsons/loading%2520dot.json": "e731e409704f2191708adcd290187a67",
"assets/assets/images/login_illustration.png": "92fc617d1201d0af27d1f20a265d88d3",
"assets/assets/images/img_coming_soon_nutriscore.png": "f84882ddda9121d2ae1da170809fb44e",
"assets/assets/images/img_male.png": "668caa8ea7f1b40f80b348cc5bb7dc41",
"assets/assets/images/img_female.png": "8e32762b0f862df4608c62cf3cd0d21e",
"assets/assets/images/img_empty_wellness.svg": "6ace4b603a8da3655b1eda3124ed274e",
"assets/assets/images/FA_Livewell_Logo.svg": "5cb6e5e120c726ecb2dbc0010d210fe5",
"assets/assets/images/img_female.svg": "b691ebde731572502d704df798df5302",
"assets/assets/images/img_male.svg": "d5d713fe102d29934ecfb8a6f5cc9941",
"assets/assets/images/icons8-apple-logo.svg": "d42aa58b6b7ae63e0a8dd98a02d86e35",
"assets/assets/images/IMG_5451.png": "72cfc415aa6c25e3df4d495b5b9a5262",
"assets/assets/images/livewell_logo.png": "a17d4fda76b8f573d27bebbb11f88a39",
"assets/assets/images/FA_Livewell_Supergraphic.svg": "14192ba928ee20a04444945e9462bcbb",
"assets/assets/images/img_finish_questionnaire.svg": "9a465a8b00b745029513045aceefe27c",
"assets/assets/images/livewell_logo_yellow.png": "79e06f5d1bcc75744932e87f2d878077",
"assets/assets/images/logo_googleg_48dp.svg": "9543df1f15eb4e3a517dee74890a13d0",
"assets/assets/images/img_landing_questionnaire.png": "87f28362c7ed4047218244f5bb0a4a59",
"assets/assets/images/livewell_logo_yellow.svg": "3e4e3736cc81ba85820e6a5bb4bfd30d",
"assets/assets/images/FA_Livewell_Logo_2.svg": "1527a4728a4399fbfead4d70690367a9",
"assets/assets/icons/mood_meh.svg": "d273da3ec50f1da550c2d93fa0c1f2f5",
"assets/assets/icons/summary_calories.svg": "d90e7c094221f21eba831d953248e8a7",
"assets/assets/icons/summary_exercise.svg": "0bd9e5d923449eafdb8fc40d9728d231",
"assets/assets/icons/ic_lunch.png": "e07515f01eb3fde94f9152527a2fcfa4",
"assets/assets/icons/collections_bookmark_24px.svg": "33c8565635a27612180de8c12a5f6e85",
"assets/assets/icons/ic_breakfast.svg": "8fc0ca3ba3266216bdd995e2c623cd3a",
"assets/assets/icons/ic_nutrition.svg": "9de2a00cda2c1507d21ee759ec565e1c",
"assets/assets/icons/ic_force_update.svg": "808dcd6bdc981e9fecf26917fc2d20ef",
"assets/assets/icons/ic_scanmeal.svg": "eb5f1eceb237bafa5c3d334b9f06149f",
"assets/assets/icons/ic_woke_up.svg": "7e7ed05763c21b80ad035bfaee876342",
"assets/assets/icons/ic_water_100ml.svg": "0ed79158aad6ad18b07a1fe1598321c6",
"assets/assets/icons/summary_fat.svg": "2915d4a0c2e35089f012026667524a5d",
"assets/assets/icons/streak_icon.svg": "58c5a03beb5cf9db5f386fac0677e9f6",
"assets/assets/icons/livewell-calories-burnt.svg": "298a30bb7119b790b9328d4bbc9629ec",
"assets/assets/icons/ic_went_to_sleep.svg": "f51f15a8b4d69e1941d9e6e075ea16ed",
"assets/assets/icons/ic_snack.svg": "3467b5c25eddfb37dda23ab5980f02d7",
"assets/assets/icons/ic_water_custom.svg": "0e10d7e770be011f1abe7a82020725d7",
"assets/assets/icons/ic_water_unselected.png": "3b9fcc77a8bd262b30e06580574f867b",
"assets/assets/icons/instagram.png": "23b6aa7ed5ceca0b2114864a20e38878",
"assets/assets/icons/kemenkes-icon.svg": "911a9329b98a1eaf1bebbe5e3d8ee7f5",
"assets/assets/icons/mood_awful.svg": "4c78e6c5ffe884a597a4819fa749b661",
"assets/assets/icons/livewell-footstep.svg": "5fe3d07216bab6967c608de27b8b5f73",
"assets/assets/icons/ic_barcode.svg": "48c2c1ee13027b6928bc74d655b7b9fc",
"assets/assets/icons/livewell_apps_icon_yellow.png": "2094de1fca538120b6ce4eaa2fcea989",
"assets/assets/icons/ic_calories.svg": "bf5f29a986dbf3d48f7b824ad237bf1b",
"assets/assets/icons/ic_exercise_selected.png": "1682adcd40787f36b8e386076eb5b699",
"assets/assets/icons/ic_exercise_black.png": "6cb625f1333041ca5065c58a4ca61a32",
"assets/assets/icons/ic_feel_a_sleep.svg": "b68e7fed386f6308295c00a6e849ce0d",
"assets/assets/icons/instagram.svg": "f85fa5d73a3014d67d2df82dd1775b12",
"assets/assets/icons/summary_carbs.svg": "38336c31cf5bf3ebce705762f19b2b66",
"assets/assets/icons/ic_snack.png": "4e7a4358d8383301ffab7897b95c1561",
"assets/assets/icons/ic_wellness_profile.svg": "a09cbd4d74cfd45c2ae28ebd7c68f59d",
"assets/assets/icons/ic_exercise_black_3.png": "43f8a071cb5e95ad6d46cfcde38ea217",
"assets/assets/icons/ic_went_to_sleep_2.svg": "24cf36fb2023860ff6fe34507a23267f",
"assets/assets/icons/ic_sleep_unselected.png": "1e96c57f99bb31a620e0b2443bbd0414",
"assets/assets/icons/ic_steps_exercise.svg": "8f6d57b138ea44fb82537d824b9e5bbe",
"assets/assets/icons/home_24px.svg": "da17bf7a337eb2c1f43cb5fd7b15a3c9",
"assets/assets/icons/ic_exercise_black_2.png": "bb333f41a1bd8ed41e2602aedbb56afa",
"assets/assets/icons/ic_meditation_unselected.png": "2923c01b5ce0840a1c367110c6aa5e61",
"assets/assets/icons/ic_exercise_unselected.png": "053c18481655d1ddb7ce7acbfa0076be",
"assets/assets/icons/summary_protein.svg": "50dfc8aafb6e79860ba1ba260d78ed6b",
"assets/assets/icons/ic_blood_unselected.png": "f05c88c730450923bc8efabfdb080503",
"assets/assets/icons/ic_breakfast.png": "99490d860056c77f6b9f3066e75d340b",
"assets/assets/icons/ic_account_settings.png": "953e2e77c1497a10817e8a2dcda131e8",
"assets/assets/icons/ic_lunch.svg": "f90e1b80085d4c42a6c3f497bbde9af5",
"assets/assets/icons/ic_home_selected.png": "e3db64a3dcc4ab60401f3e0cd53f694e",
"assets/assets/icons/ic_physical_info.png": "24ea9c074703da87f165c6d5ed5065d0",
"assets/assets/icons/ic_water_selected.png": "df54f82c4c1d9b1a014ba02a2e40b549",
"assets/assets/icons/sumary_water.svg": "a9b658ab5071735b11e1b69b413a8002",
"assets/assets/icons/ic_key.png": "46a6b1a4078d188d792e452eec14f1ab",
"assets/assets/icons/ic_water_250ml.svg": "d7b86b50b41a68564d53a7c475703b14",
"assets/assets/icons/ic_logout.png": "05146777c02ffff73ae9bf5a2dbaca7b",
"assets/assets/icons/mood_good.svg": "c3b3cc695b5f8ca7e8ba0cc1fa1f69ab",
"assets/assets/icons/ic_calories_exercise.svg": "655e0ab2002ca76c4ef93e923efa48ac",
"assets/assets/icons/ic_task_card_star.svg": "720b8620feeb5c3eadf7c0289e69f8ea",
"assets/assets/icons/ic_update_password_success.svg": "515c84c866171abf33524d8b0bccca8e",
"assets/assets/icons/ic_meditation_selected.png": "2b0e4a18a5083a04b765efd7f1592a8b",
"assets/assets/icons/facebook.svg": "a8a99d9c1a661b36bb474b6a9f9c8a7f",
"assets/assets/icons/ic_search.png": "30daf8b8bd5eff9d61969e594362b3ee",
"assets/assets/icons/whatsapp.svg": "0106f659dc33bd50c49aee31758c9e78",
"assets/assets/icons/ic_dinner.png": "134b4004d233d2f635df832dfa436a8a",
"assets/assets/icons/summary_sleep.svg": "06811357b84387bbf1b83035c7ac9dc4",
"assets/assets/icons/ic_home_unselected.png": "85be9e6207cd18d0ec9275ebce9667ae",
"assets/assets/icons/ic_custom_input_water.svg": "7f2da1ff4d8577fb0c4098b7993d4d41",
"assets/assets/icons/buble.svg": "93b934279b67c8a744e50ed426855ef0",
"assets/assets/icons/summary_mood.svg": "e7da3afe7b2d1e000554c3e1434aaad9",
"assets/assets/icons/ic_home_account.svg": "82c2a5008413d8082de4b61969675642",
"assets/assets/icons/ic_blood_selected.png": "f776c5203aef524b50952dc430a9ca68",
"assets/assets/icons/ic_dinner.svg": "1debe5fa8db0d719022f085098ea609d",
"assets/assets/icons/mood_bad.svg": "93426f9c12672d94882eb22c1a7f110a",
"assets/assets/icons/whatsapp.png": "a48df6ad8f0c798786fece7a8f06d079",
"assets/assets/icons/facebook.png": "15a82fe27db88dd343be022fdd1f39ef",
"assets/assets/icons/ic_sleep_selected.png": "9be27befc50499cbc065e406c5c3ceb9",
"assets/assets/icons/ic_quickadd.svg": "7f28a5317d751b07dd7cadf9e18f3f20",
"assets/assets/icons/ic_avatar_placeholder.svg": "f618390d6e53026b7dafa42859d7c53b",
"assets/assets/icons/ic_deep_sleep.svg": "3cc391c82803f9d717421a1f24912bcc",
"assets/assets/icons/ic_wellness_recommendation.svg": "456a114ee83dc5d7c6de312e9c1a02f7",
"assets/assets/icons/ic_food_selected.png": "f8135959a785742f93e8850976897914",
"assets/assets/icons/ic_water_500ml.svg": "b980ea13591bbf7652baa99ef2bfd58f",
"assets/assets/icons/ic_food_unselected.png": "e6ad7b19149dfcf017cd57e9fd342cae",
"assets/assets/icons/ic_update_password_success.png": "ab5a2dcf96e80d20c1828c5cf6557e97",
"assets/assets/icons/ic_hydration_score.svg": "5089e1603117ac58c45f2b9ab4126ff7",
"assets/assets/icons/account_circle_24px.svg": "84e5a64e892a5e709560c096f6e22ac2",
"assets/assets/icons/mood_great.svg": "bdd9a9e2a2aa41fb513b89160024d8a7",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
