if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/static/sw.js').then(function(reg) {
        console.log('Successfully registered service worker', reg);
    }).catch(function(err) {
        console.warn('Error whilst registering service worker', err);
    });
}

document.addEventListener("DOMContentLoaded", function(event) {

    const form = document.getElementById('save_ride_form');
    if (form) {

        form.addEventListener('submit', function(e) {

            e.preventDefault();

            const formData = new FormData(this);

            fetch(form.action, {
                method: 'POST',
                body: formData
            })
            .then((response) => response.json())
            .then((result) => {
                console.log('Success:', result);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        });
    }
})