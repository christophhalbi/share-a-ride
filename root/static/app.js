if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/sw.js').then(function(reg) {
        console.log('Successfully registered service worker', reg);
    }).catch(function(err) {
        console.warn('Error whilst registering service worker', err);
    });
}

function SaveForm(form) {

    this.form = form;

    this.initEvents = function() {

        const that = this;

        that.form.addEventListener('submit', function(e) {

            e.preventDefault();

            const formData = new FormData(this);

            fetch(that.form.action, {
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

        return this;
    };
}

function RidesOverview(container, rowTemplate) {

    this.container   = container;
    this.rowTemplate = rowTemplate

    this.get = function() {

        const that = this;

        fetch(that.container.dataset.uri, {
            method: 'GET'
        })
        .then((response) => response.json())
        .then((json) => {

            that.render(json);
        })
        .catch((error) => {
            console.error('Error:', error);
        });

        return this;
    };

    this.render = function(json) {

        const that = this;

        var tb = this.container.querySelector('tbody');

        td = this.rowTemplate.content.querySelectorAll('td');

        json.results.forEach(function(result) {

            td[0].textContent = result.driver;
            td[1].textContent = result.start_from;
            td[2].textContent = result.go_to;
            td[3].textContent = result.start_dt;
            td[4].textContent = result.seats;

            var clone = document.importNode(that.rowTemplate.content, true);
            tb.appendChild(clone);
        });

        return this;
    }

    this.clear = function() {

        [].forEach.call(this.container.querySelectorAll('tbody tr'), function(row) {

            row.parentNode.removeChild(row);
        });

        return this;
    }
}

function Quicksearch(input, ridesOverview) {

    this.input         = input;
    this.ridesOverview = ridesOverview;

    this.initEvents = function() {

        const that = this;

        that.input.addEventListener('keyup', function(e) {

            fetch(that.input.dataset.uri, {
                method: 'GET'
            })
            .then((response) => response.json())
            .then((json) => {

                that.ridesOverview.clear().render(json);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
        });

        return this;
    };
}

document.addEventListener("DOMContentLoaded", function(event) {

    const form = document.getElementById('save_ride_form');
    if (form) {

        new SaveForm(form).initEvents();
    }

    const ridesContainer   = document.getElementById('rides');
    const ridesRowTemplate = document.getElementById('ride_row');
    if (ridesContainer) {

        const ridesOverview = new RidesOverview(ridesContainer, ridesRowTemplate);

        ridesOverview.get();

        const quicksearchInput = document.getElementById('quicksearch');
        if (quicksearchInput) {

            new Quicksearch(quicksearchInput, ridesOverview).initEvents();
        }
    }
})
