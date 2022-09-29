var tenNienKhoa = "";
var maHocKy = "";
var table_LTC_Import;
var maGV = "";
var maHocKyInt;
var table_LTC_Import_rowIndex = 0;
var lop = "";
var fileLTC;
var select_Sheet;
var maSheet;
var listLTCPreview;
var listLTCImport;
$(document).ready(function () {
    /* loading();*/
    select_Sheet = $('#select_Sheet').select2();
    table_LTC_Import = $("#table_LTC_Import").DataTable();
    /* setVisibleColumn(false);*/
    init_Select_NienKhoa();
    $('#table_LTC_Import tbody').on('click', 'tr', function () {
        var index = table_LTC_Import.row(this).index();
        if ($(this).hasClass('selected') && table_LTC_Import_rowIndex != index) {
            $(this).removeClass('selected');
            table_LTC_Import_rowIndex = index;
        }
        else {
            table_LTC_Import.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_LTC_Import_rowIndex = index;
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
    if (maHocKyInt % 10 != 3) {
        $("#hsHocKy").val(1.0);
    }
    else {
        $("#hsHocKy").val(1.5);
    }
    if (maGV.toString() != "") {
        getListLTC();
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
/*function getListLTC() {
    table_LTC_Import.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { MaNKHK: maHocKy, MaGV: maGV },
        url: '/lop-tin-chi/ds-ltc',
        success: function (response) {
            table_LTC_Import = $('#table_LTC_Import').DataTable({
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
*/function previewLTC() {
    document.getElementById("btnImport").removeAttribute("disabled");
    document.getElementById("hsHocKy").setAttribute("readonly", "readonly");
    var hsHK = $("#hsHocKy").val();
    var formData = new FormData();
    formData.append('file', fileLTC);
    formData.append('maNKHK', maHocKy);
    formData.append('maSheet', maSheet);
    formData.append('hsHocKy', hsHK);
    $.ajax({
        async: true,
        type: 'POST',
        data: formData,
        url: '/lop-tin-chi/preview',
        processData: false,
        contentType: false,
        success: function (response) {
            response = $.parseJSON(response);
            if (response.success == true) {
                table_LTC_Import.destroy();
                listLTCPreview = response.dataView;
                listLTCImport = response.data;
                table_LTC_Import = $('#table_LTC_Import').DataTable({
                    "data": listLTCPreview,
                    "columns": [{
                        'data': 'Stt',
                    },
                    {
                        'data': 'MaGV',
                    }, {
                        'data': 'TenGiangVien',
                    }, {
                        'data': 'ChucDanh',
                    }, {
                        'data': 'TenMonHoc',
                    }, {
                        'data': 'MaMonHoc',
                    }, {
                        'data': 'MaHeLop',
                    }, {
                        'data': 'TenLTC',
                    }, {
                        'data': 'SiSo',
                    },
                    {
                        'data': 'SoNhomTH',
                    },
                    {
                        'data': 'TietLTQD',
                    },
                    {
                        'data': 'TietBTQD',
                    },
                    {
                        'data': 'TietTHQD',
                    },
                    {
                        'data': 'HSLopDongLT',
                    },
                    {
                        'data': 'HSNgoaiGio',
                    },
                    {
                        'data': 'HSMonMoi',
                    },
                    {
                        'data': 'HSLopDongTH',
                    },
                    {
                        'data': 'HSLTC',
                    },
                    {
                        'data': 'TietLTTD',
                    },
                    {
                        'data': 'TietBTTD',
                    },
                    {
                        'data': 'TietTHTD',
                    }],
                    "columnDefs": [{
                        "targets": 4,
                        "width": "100px"
                    }, {
                        "targets": 2,
                        "width": "100px"
                    }
                    ]
                }
                );
            }
            else {
                toastr.error(response.message, 'Lỗi', { timeOut: 3000 });
            }

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function onChangeFile(event) {
    document.getElementById("btnPreview").removeAttribute("disabled");
    document.getElementById("hsHocKy").removeAttribute("readonly");
    document.getElementById("btnImport").setAttribute("disabled", "disabled");
    fileLTC = event.target.files[0];
    table_LTC_Import.clear().draw(false);
    initSelect_Sheet();
}
function initSelect_Sheet() {
    $('#select_Sheet').select2('destroy');
    $("#select_Sheet").empty();
    var formData = new FormData();
    formData.append('file', fileLTC);
    formData.append('maNKHK', maHocKy);
    $.ajax({
        async: false,
        type: 'POST',
        data: formData,
        url: '/import/list-sheet',
        processData: false,
        contentType: false,
        success: function (response) {
            response = $.parseJSON(response);
            console.log(JSON.stringify(response.data));
            if (response.success) {
                $("#select_Sheet").select2({
                    data: response.data
                });
                maSheet = 0;          
            }
            else {
                toastr.error('Lỗi', response.message, { timeOut: 3000 });
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function importLTC() {
    $.ajax({
        async: true,
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        type: 'POST',
        data: JSON.stringify(listLTCImport),
        url: '/lop-tin-chi/import-file',
        success: function (response) {
            toastr.success("Import Danh sách LTC thành công", "Thông báo", { timeOut: 3000 });
            table_LTC_Import.clear().draw(false);
            document.getElementById("btnImport").setAttribute("disabled", "disabled");
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function onChange_Select_Sheet() {
    maSheet = $('#select_Sheet option:selected').val();
    document.getElementById("hsHocKy").removeAttribute("readonly");
    document.getElementById("btnImport").setAttribute("disabled", "disabled");
}


