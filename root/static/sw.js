
var CACHE_NAME = 'share-a-ride-cache-v1';

this.addEventListener('install', function(event) {

    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(function(cache) {

                console.log("install done");
            })
    );
});
