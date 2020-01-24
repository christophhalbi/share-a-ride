
var CACHE_NAME = 'share-a-ride-cache-v1';

this.addEventListener('install', (event) => {

    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(function(cache) {

                return cache.addAll([
                    '/',
                    '/jump_in',
                    '/ride',
                    '/manifest.json',
                    '/favicon.ico',
                    '/static/app.js',
                    '/static/bootstrap.min.css',
                    '/static/images/icons-512.png'
                ]);
            })
    );
});

this.addEventListener('activate', (event) => {
    console.log('👷', 'activate', event);
    return self.clients.claim();
});

this.addEventListener('fetch', (event) => {

    event.respondWith(caches.match(event.request));
});
