var tenNam = "";
var maHocKy = "";
var maKhoa = "";
$(document).ready(function () {
   /* loading();*/
    select_Sheet = $('#select_Sheet').select2();
    init_Select_Nam();
});
////Onchange
function onChange_Select_Nam(event) {
    tenNam = $("#select_Nam option:selected").val();
}

/////
function init_Select_Nam() {
    $("#select_Nam").empty();
    $.ajax({
        async: true,
        type: 'GET',
        url: '/nien-khoa-hoc-ky/nam',
        success: function (response) {
            response = $.parseJSON(response).data;
            console.log(response);
            $.each(response, function (i, item) {
                $('#select_Nam').append($('<option>', {
                    value: item,
                    text: item
                }));
            });
            $("#select_Nam").prop("selectedIndex", 0);
            tenNam = $("#select_Nam option:selected").val();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function loading() {
    $.ajax({
        async: true,
        type: 'GET',
        data: "",
        url: '/loading/lop-tin-chi/import',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingLTC").modal('show');
                setTimeout(function () {
                    $("#modalLoadingLTC").modal('hide')
                }, 2500)
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
