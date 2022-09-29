var tenNienKhoa = "";
var maHocKy = "";
var maKhoa = "";
$(document).ready(function () {
   /* loading();*/
    select_Sheet = $('#select_Sheet').select2();
    init_Select_NienKhoa();
});
////Onchange
function onChange_Select_NienKhoa(event) {
    tenNienKhoa = $("#select_NienKhoa option:selected").val();
    init_Select_HocKy();
}
function onChange_Select_HocKy(event) {
    maHocKy = $("#select_HocKy").val();
}

/////
function init_Select_HocKy() {
    $("#select_HocKy").empty();
    var nienKhoa = {
        MaNKHK: "", TenNienKhoa: tenNienKhoa, TenHocKy: ""
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: nienKhoa,
        url: '/nien-khoa-hoc-ky/hoc-ky',
        success: function (response) {
            console.log(JSON.stringify(response));
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_HocKy').append($('<option>', {
                    value: item.MaNKHK,
                    text: item.TenHocKy
                }));
            });
            $("#select_HocKy").prop("selectedIndex", 0);
            maHocKy = $("#select_HocKy").val();
            $('#select_HocKy').trigger('change');
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Select_NienKhoa() {
    $("#select_NienKhoa").empty();
    $.ajax({
        async: true,
        type: 'GET',
        url: '/nien-khoa-hoc-ky/nien-khoa',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_NienKhoa').append($('<option>', {
                    value: item.TenNienKhoa,
                    text: item.TenNienKhoa
                }));
            });
            $("#select_NienKhoa").prop("selectedIndex", 0);
            tenNienKhoa = $("#select_NienKhoa option:selected").val();
            init_Select_HocKy();
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
/*function previewLTC() {
    $.ajax({
        async: true,
        type: 'GET',
        data: {maNKHK:maHocKy},
        url: '/report/khoi-luong-giang',
        success: function (response) {
            window.location.href = "/report/khoi-luong-giang"; 
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}*/

