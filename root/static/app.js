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
            .then((json) => {

                window.location = '/jump_in';
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        });
    }

    const rides = document.getElementById('rides');
    if (rides) {

        fetch(rides.dataset.uri, {
            method: 'GET'
        })
        .then((response) => response.json())
        .then((json) => {

            var tb = document.querySelector('#rides_table tbody');
            var t  = document.querySelector('#ride_row');
            td = t.content.querySelectorAll('td');

            json.results.forEach(function(result) {

                td[0].textContent = 'Max';
                td[1].textContent = result.from;
                td[2].textContent = result.to;
                td[3].textContent = result.on + ' ' + result.at;
                td[4].textContent = result.seats;

                var clone = document.importNode(t.content, true);
                tb.appendChild(clone);
            });
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    }
})
