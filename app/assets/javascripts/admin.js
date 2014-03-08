$(function() {
    $('#add-new').on('click', function() {
        $(this).parent().find('.hidden').removeClass('hidden');
        $(this).remove();
        return false;
    });
});