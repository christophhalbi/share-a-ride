
var CACHE_NAME = 'share-a-ride-cache-v1';

this.addEventListener('install', function(event) {

    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(function(cache) {

                return cache.addAll([
                    '/index',
                    '/jump_in',
                    '/ride',
                    'static/app.js',
                    'static/bootstrap.min.css'
                ]);
            })
    );
});
