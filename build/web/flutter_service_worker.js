'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "f2280bf303cb7d688c1c846a8d5f65ea",
"assets/AssetManifest.bin.json": "14be3d7618f2b1597f9f41222e1cd233",
"assets/assets/580826babe95d602b28af0e822f2f55b.jpg": "9a5d5226dd60e12e5972d16a7620d4a5",
"assets/assets/A1.jpg": "86b89df16b6848a4b47d8e05a41c9ee7",
"assets/assets/A2.jpg": "bd45a20fa4415e719ea86541290f5e5f",
"assets/assets/A3.jpg": "d0dd132f0737b1ecdd261a68aaa8f184",
"assets/assets/A4.jpg": "97e9dc28b6cc3ee9d79d86efa34806ff",
"assets/assets/ABA.webp": "b0c83d059a04ba8ee4f9e8c9fd03ddcb",
"assets/assets/AC.jpg": "8d89fd324aae3f628713f197d2b74a16",
"assets/assets/adidas.webp": "c84b00fa13ea466239fbe0cea7f361a8",
"assets/assets/adidas_blue.webp": "dac3d1a092ca8554f5e2363af6a003d3",
"assets/assets/intro1.webp": "507621f34697e6daf9b01d55328c3a80",
"assets/assets/intro3.png": "70fe3b22ff197da50f9b56971983378d",
"assets/assets/introduction2.webp": "267921a8bfd5c683940f9dba171a43a9",
"assets/assets/introduction3.webp": "71b1b1d9cddf3d8f3b1f5d2276810ba3",
"assets/assets/jean.jpg": "0374a916578e5cc1c3bf6ae51865acfe",
"assets/assets/K1.jpg": "c41e6fefbda3a520f0dc59730f3f4ab7",
"assets/assets/K10.jpg": "ded742e114b476178ccf08b672360849",
"assets/assets/K11.jpg": "262fe9a50bbb04bfb0eb8c7fb65f6381",
"assets/assets/K12.jpg": "8351f2f011faf5cd99405caf42588276",
"assets/assets/K13.jpg": "543701f481b5e30dee6ce1f9dc676f66",
"assets/assets/K14.jpg": "cc541274470831af8c6c8e3da3c18d06",
"assets/assets/K15.jpg": "cbc903e93f685c6f32920e622aa776df",
"assets/assets/K16.jpg": "0a97456aa5947a343bd378c59d581fbe",
"assets/assets/K17.jpg": "4b22c3ced4c9f235dee691f7fda076d2",
"assets/assets/K18.jpg": "cb1fce57fe8ca80144dbc99feade1888",
"assets/assets/K19.jpg": "c13522e099de17da3990b055d74f1db5",
"assets/assets/K2.jpg": "6d2c97961a99ebd18616051805242827",
"assets/assets/K20.jpg": "d51258706cbc59cc4a2140347064f620",
"assets/assets/K21.jpg": "07a2fe2eda4cccf052eb7abf50854f17",
"assets/assets/K22.jpg": "7389e44d3bacaecc6b51e2b0fa7341cd",
"assets/assets/K23.jpg": "1f447d1be798a853c2900b55711d6f77",
"assets/assets/K24.jpg": "df8bdc309472f0dc71d6ff9f67e821d0",
"assets/assets/K25.jpg": "d917a87e61ce6fff72b87ab0af2e7669",
"assets/assets/k4.jpg": "33224c3ced0ed142fc76cdf46fceb236",
"assets/assets/K5.jpg": "6c5c0c30db9a39dc168cd94daf75a106",
"assets/assets/K6.jpg": "6b3914054615cd567adfb6c67207ebfd",
"assets/assets/K7.jpg": "29ad4e2e0d0be02d107e5e7c9301c135",
"assets/assets/K8.jpg": "8377e9d0b5b172288018651d7a85304c",
"assets/assets/K9.jpg": "da079bb855e3c1384ae2cf6f9739bf76",
"assets/assets/M1.jpg": "fefa18fd21d892d60d5eee2eed72b0a8",
"assets/assets/M10.jpg": "478ea5bbedda321738a4f7c17b67ad45",
"assets/assets/M2.jpg": "cce2cfc0edd7ddfa19c8e4f5b3cbc061",
"assets/assets/M3.jpg": "39c97326e90292fc66cd9a446caa24c2",
"assets/assets/M4.jpg": "321a8625bd410cdc0ec8b5610aef0e37",
"assets/assets/M5.jpg": "638535f635967ddadf5e0f16790a699b",
"assets/assets/M6.jpg": "891e8dc8bb79bf09e8d2dba47a35d95e",
"assets/assets/M7.jpg": "df01c5942b9a84b1fa8472a5beebacf0",
"assets/assets/M8.jpg": "a85af7d027dce9d328d554e59aaa7e7a",
"assets/assets/M9.jpg": "72ac34b74651f18cfc5a727ceb3eca80",
"assets/assets/nike_blue.webp": "a1fcd8314123247c239ff583dc7d3f0a",
"assets/assets/nike_child_green.webp": "ea863ae1d5e281a83d6ddc1325f79e71",
"assets/assets/nike_green.webp": "0f3b35c976c43815960df0512b0166f6",
"assets/assets/nike_pink.webp": "a5f2197a6696bf6f4d9c7f3908516f9a",
"assets/assets/nike_sport_shoes.webp": "e253e4d2cad49df5649c3e603444f726",
"assets/assets/Order%2520completed.json": "da7ed6751528962e7fc0a4fe35e01e57",
"assets/assets/Order%2520completed.lottie": "6e3a3a9886a01f63e33ec3e945af466d",
"assets/assets/profile.webp": "9b29363d7ef51abd7be58536f10c2369",
"assets/assets/s10.jpg": "07aa5ecd5f8f9991630a99e5a1e5a64f",
"assets/assets/s11.jpg": "9a5d5226dd60e12e5972d16a7620d4a5",
"assets/assets/s12.jpg": "a211b858bf9084691bc953755dc46a60",
"assets/assets/s13.jpg": "a27d91145105a69ffcae0a2bd7b35ae5",
"assets/assets/s14.jpg": "208448e348a3b053fed59288bb8c03cf",
"assets/assets/s15.jpg": "79b1d1237f26ace8dcaa159948d2d3d6",
"assets/assets/s16.jpg": "19015d5a008a10828eac55cded78253d",
"assets/assets/s17.jpg": "ded6329d0749d8bcc9f215034c5d6d7f",
"assets/assets/s18.jpg": "cff6e05b715e30c63c6e7e0de707ade5",
"assets/assets/s19.jpg": "e3df37ac97bfd5cd49174b4d4bc2182a",
"assets/assets/s2.jpg": "9aa535630bec956ef3e2880326de96d7",
"assets/assets/s20.jpg": "9b51dd7981cac624b666ab197cee71b8",
"assets/assets/s21.jpg": "41284cebf49f7c736cb68a049b657514",
"assets/assets/s3.jpg": "c501b1a9e4b0adf0f2df4537474ff300",
"assets/assets/s4.jpg": "b5f44b96d11a72028bbc792c9749849f",
"assets/assets/s5.jpg": "ac2971333ae672f0e1383de9a65933f9",
"assets/assets/s6.jpg": "e04c80a951718798e0252cdaaf54cc7b",
"assets/assets/s7.jpg": "9d1863889db1108aaa3aa3a81cce0a89",
"assets/assets/s8.jpg": "0d938109424036c7f2cc3358e9b6194e",
"assets/assets/s9.jpg": "219d2dd3851a242a4c4363c236da7fb1",
"assets/assets/shoes.jpg": "a88cdc9751cb74b7ce2afe4edc155963",
"assets/assets/visa_card.webp": "517ba81c34a05e3033cf6db8a154f376",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "ca7027eb179e2a3b73cf0d4d810332a4",
"assets/NOTICES": "755df300a4786b84edff23f55985463c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "01981394b2321ab1752a7079cfc81605",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "548f68ce164b65dfa961a5fd45d36831",
"/": "548f68ce164b65dfa961a5fd45d36831",
"main.dart.js": "33a010f44b8675103c4c60f8200b6c95",
"manifest.json": "3cf762d8b05dec7a5f0eb201232b193f",
"version.json": "78cc76a858d6d51eec8939e39974a826"};
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
