var tenNienKhoa = "";
var maHocKy = "";
var maKhoa = "";
var listSubject;
var listGV;
var nodeTree = null;
var table_TTTN_Import;
var maGV = "";
var hocViLTC = "";
var maHeLop, tenHeLop, tenBac, maBac, maMonHoc, tenMonHoc = "x";
var maHocKyInt;
var flag_Focus_Bac = 0;
var flag_Focus_HeLop = 0;
var table_TTTN_Import_rowIndex = 0;
var lop = "";
var tttnModel = null;
var flagEdit = "";
var fileTTTN;
var select_Sheet;
var maSheet;
var listHuongDanTTTN;
$(document).ready(function () {
    loading();
    select_Sheet = $('#select_Sheet').select2();
    table_TTTN_Import = $("#table_TTTN_Import").DataTable();
    init_Select_NienKhoa();
    $('#table_TTTN_Import tbody').on('click', 'tr', function () {
        var index = table_TTTN_Import.row(this).index();
        if ($(this).hasClass('selected') && table_TTTN_Import_rowIndex != index) {
            $(this).removeClass('selected');
            table_TTTN_Import_rowIndex = index;
        }
        else {
            table_TTTN_Import.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_TTTN_Import_rowIndex = index;
        }
    });
});
////Onchange
function onChange_Select_NienKhoa(event) {
    tenNienKhoa = $("#select_NienKhoa option:selected").val();
    init_Select_HocKy();
}
function onChange_Select_HocKy(event) {
    maHocKy = $("#select_HocKy").val();
    maHocKyInt = parseInt(maHocKy, 10);
    if (maGV.toString() != "") {
        getListTTTN();
    }
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
            maHocKyInt = parseInt(maHocKy, 10);
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
        url: '/loading/thuc-tap-tot-nghiep/import',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingTTTN").modal('show');
                setTimeout(function () {
                    $("#modalLoadingTTTN").modal('hide')
                }, 2500)
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function getListTTTN() {
    table_TTTN_Import.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { MaNKHK: maHocKy, MaGV: maGV },
        url: '/thuc-tap-tot-nghiep/ds-tttn',
        success: function (response) {
            table_TTTN_Import = $('#table_TTTN_Import').DataTable({
                "data": $.parseJSON(response).data,
                "columns": [{
                    'data': 'MaGV',
                },
                {
                    'data': 'MaNKHK',
                }, {
                    'data': 'Lop',
                }, {
                    'data': 'SoTuan',
                }, {
                    'data': 'SoSinhVienHD',
                }, {
                    'data': 'HSHuongDan',
                }, {
                    'data': 'SoSinhVienPB',
                }, {
                    'data': 'HSPhanBien'
                }]
            }
            );
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function previewTTTN() {
    document.getElementById("btnImport").removeAttribute("disabled");
    table_TTTN_Import.destroy();
    var formData = new FormData();
    formData.append('file', fileTTTN);
    formData.append('maNKHK', maHocKy);
    formData.append('maSheet', maSheet);
    $.ajax({
        async: true,
        type: 'POST',
        data: formData,
        url: '/thuc-tap-tot-nghiep/preview',
        processData: false,
        contentType: false,
        success: function (response) {
            listHuongDanTTTN = JSON.stringify($.parseJSON(response).data);
            table_TTTN_Import = $('#table_TTTN_Import').DataTable({
                "data": $.parseJSON(response).data,
                "columns": [{
                    'data': 'MaGV',
                },
                {
                    'data': 'MaNKHK',
                }, {
                    'data': 'Lop',
                }, {
                    'data': 'SoTuan',
                }, {
                    'data': 'SoSinhVienHD',
                }, {
                    'data': 'HSHuongDan',
                }, {
                    'data': 'SoSinhVienPB',
                }, {
                    'data': 'HSPhanBien',
                }]
            }
            );
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function onChangeFile(event) {
    document.getElementById("btnPreview").removeAttribute("disabled");
    document.getElementById("btnImport").setAttribute("disabled", "disabled");
    fileTTTN = event.target.files[0];
    table_TTTN_Import.clear().draw(false);
    initSelect_Sheet();
}
function initSelect_Sheet() {
    $('#select_Sheet').select2('destroy');
    $("#select_Sheet").empty();
    var formData = new FormData();
    formData.append('file', fileTTTN);
    formData.append('maNKHK', maHocKy);
    $.ajax({
        async: true,
        type: 'POST',
        data: formData,
        url: '/import/list-sheet',
        processData: false,
        contentType: false,
        success: function (response) {
            console.log(response.data);
            $("#select_Sheet").select2({
                data: response.data
            });
            maSheet = 0;
            console.log("Mã sheet: " + maSheet);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function importTTTN() {
    $.ajax({
        async: true,
        type: 'POST',
        data: "",
        url: '/thuc-tap-tot-nghiep/import-file',
        success: function (response) {
            toastr.success("Thành công", "Thông báo", { timeOut: 3000 });
            table_TTTN_Import.clear().draw(false);
     /*       $("#fileTTTN").val(null);    
            $('#select_Sheet').empty();
            document.getElementById("btnPreview").setAttribute("disabled", "disabled");*/
            document.getElementById("btnImport").setAttribute("disabled", "disabled");
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function onChange_Select_Sheet() {
    maSheet = $('#select_Sheet option:selected').val();
    console.log('Mã sheet: ' + maSheet);
}



