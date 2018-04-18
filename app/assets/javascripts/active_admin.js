//= require application
$(document).ready(function() {
    jQuery('input.hasDatetimePicker').datetimepicker({
        dateFormat: "dd/mm/yy",
        beforeShow: function () {
            setTimeout(
                function () {
                    $('#ui-datepicker-div').css("z-index", "3000");
                }, 100
            );
        }
    });
});