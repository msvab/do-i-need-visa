// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require chosen.jquery

(function($) {

    $(function() {
        $('.chosen-select').chosen();

        $('#current-hash').click(function(event) {
            var output = $(event.target).next();
            var url = $('#visa_source_url').val().trim();
            var selector = $('#visa_source_selector').val().trim();
            if (url === '' || selector === '') {
                output.text('URL and CSS Selector have to be specified!');
            } else {
                $.ajax('/admin/page_hash', {data: {url: url, selector: selector}, dataType: 'json', cache: false})
                    .done(function(data) {
                        output.text(data.page_hash);
                    });
            }
        });
    });

})(jQuery);
