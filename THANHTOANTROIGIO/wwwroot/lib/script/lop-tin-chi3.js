var tenNienKhoa = "";
var maHocKy = "";
var maKhoa = "";
var listSubject;
var listGV;
var nodeTree = null;
var table_LTC;
var maGV = "";
var hocViLTC = "";
var maHeLop, tenHeLop, tenBac, maBac, maMonHoc, tenMonHoc = "x";
var maHocKyInt;
var flag_Focus_Bac = 0;
var flag_Focus_HeLop = 0;
var table_LTC_rowIndex = 0;
var maLTC = 0;
var ltcAdd = null;
var flagEdit = "";
var tenGV = "";
$(document).ready(function () {
  /*  loading();*/
    table_LTC = $("#table_LTC").DataTable({
        'columnDefs': [
            {
                'targets': 16,
                'className': "dt-center editor-edit",
                'defaultContent': '<button><i class="fa fa-pencil" onclick="editFunction()" aria-hidden="true"/></button>',
                'orderable': false,
                'searchable': false
            },
            {
                'targets': 17,
                'className': "dt-center editor-delete",
                'defaultContent': '<button><i class="fa fa-trash"/></button>',
                'orderable': false,
                'searchable': false
            },
            {
                'targets': 13,
                'type': 'currency'
            }
        ]
    });
    $('#btnAddLTC').attr('disabled', 'disabled');
    $('#hsNhomTH').val(0.5);
    flag_Focus_Bac++;
    flag_Focus_HeLop++;
    $("#hsLTC").val(1.1);
    $("#btnCloseLTC").click(function (e) {
        $("#modalAddLTC").modal("hide");
    });
    $('#select_MonHoc').select2({
        dropdownParent: $('#modalAddLTC'),
    });
    $('#select_HeLop').select2({
        dropdownParent: $('#modalAddLTC'),
    });
    $('#select_BacHoc').select2({
        dropdownParent: $('#modalAddLTC'),
    });
    $(document).on('shown.bs.modal', '#modalAddLTC', function () {
        $('#tenLTC').focus();
    })
    initFormAdd();
    $("#btnAddLTC").click(function (e) {
        flagEdit = "";
        maLTC = 0;
        initFormAdd();
        $("#modalAddLTC").modal("show");
        getDonGia();

        $("#label_LTC").html("Thêm lớp tín chỉ của GIẢNG VIÊN " + hocViLTC + ". " + tenGV);

    });
    $("#select_Khoa").select2();
    init_Select_NienKhoa();
    init_Select_Khoa();
    init_Tree_GV();
    table_LTC.columns(0).visible(false);
    $('#table_LTC tbody').on('click', 'tr', function () {
        var index = table_LTC.row(this).index();
        if ($(this).hasClass('selected') && table_LTC_rowIndex != index) {
            $(this).removeClass('selected');
            table_LTC_rowIndex = index;
        }
        else {
            table_LTC.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_LTC_rowIndex = index;
        }


    });
    $('#table_LTC').on('click', 'td.editor-edit', function (e) {
        $("#label_LTC").html("Chỉnh sửa lớp tín chỉ của GIẢNG VIÊN " + hocViLTC + ". " + tenGV);
        maLTC = table_LTC.cell(this, 0).data();
        flagEdit = maLTC;
        $.ajax({
            async: true,
            type: 'POST',
            data: { maLTC: maLTC },
            url: '/lop-tin-chi/ma-ltc',
            success: function (response) {
                response = $.parseJSON(response);
                console.log(response);
                $('#tenLTC').val(response.TenLTC);
                $('#select_MonHoc').val(response.MaMon);
                $('#select_MonHoc').trigger('change');
                $('#hsHocKy').val(response.HSHocKy);
                $('#hsLTC').val(response.HSLTC);
                maBac = response.MaBac;
                $('#select_BacHoc').val(response.MaBac.trim());
                $('#select_BacHoc').trigger('change');

                $('#select_HeLop').val(response.MaHeLop.trim());
                $('#select_HeLop').trigger('change');

                $('#hsBac').val(response.HSBac);
                $('#siSo').val(response.SiSo);

                if (response.HSNgoaiGio > 1) {
                    $('#lopDem').attr('checked', 'checked');
                    $('#hsLopDem').removeAttr('readonly');
                    $('#hsLopDem').val(response.HSNgoaiGio);
                }
                if (response.HSMonMoi > 1) {
                    $('#monMoi').attr('checked', 'checked');
                    $('#hsMonMoi').removeAttr('readonly');
                }
                $('#donGia').val(response.DonGia);
                $('#hsLDLT').val(response.HSLopDongLT);
                $('#soNhomTH').val(response.SoNhomTH);
                $('#hsLDTH').val(response.HSLopDongTH);
                $('#tietLTQD').val(response.TietLTQD);
                $('#tietLTTD').val(response.TietLTTD);
                $('#tietBTQD').val(response.TietBTQD);
                $('#tietBTTD').val(response.TietBTTD);
                $('#tietTHQD').val(response.TietTHQD);
                $('#tietTHTD').val(response.TietTHTD);


            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
                console.log(response);
            }
        });
    });

    $('#table_LTC').on('click', 'td.editor-delete', function () {
        maLTC = table_LTC.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa lớp tín chỉ này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_LTC.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maLTC: maLTC },
                    url: '/lop-tin-chi/delete',
                    success: function (response) {
                        if (response.success == true) {
                            toastr.success(response.data, "Thông báo", { timeOut: 3000 });
                            row.remove().draw();
                        } else {
                            toastr.error(response.message, "Lỗi", { timeOut: 3000 });
                        }
                    }
                });

            };
        });
    });

});
////Onchange
function onChange_Select_NienKhoa(event) {
    tenNienKhoa = $("#select_NienKhoa option:selected").val();
    init_Select_HocKy();
}
function onChange_Select_Khoa(event) {
    maKhoa = $("#select_Khoa option:selected").val();
    init_Tree_GV();
}
function onChange_Select_HocKy(event) {
    maHocKy = $("#select_HocKy").val();
    maHocKyInt = parseInt(maHocKy, 10);
    if (maGV.toString() != "") {
        getListLTC();
    }

}
function onChange_Select_BacHoc(event) {
    flag_Focus_Bac++;
    maBac = $('#select_BacHoc').val();
    getHeSoBac();
    /*    $('#select_BacHoc').focus();*/
}
function onChange_Select_HeLop(event) {
    flag_Focus_HeLop++;
    maHeLop = $('#select_HeLop').val();
    getHeSoHeLop();
}
function onChange_Select_MonHoc(event) {
    maMonHoc = $("#select_MonHoc").val();
    tenMonHoc = $('#select_MonHoc option:selected').text();
    getSoTietMonHoc();
    getDonGia();
}

/////
function init_Select_HocKy() {
    $("#select_HocKy").empty();
    var nienKhoa = {
        MaNKHK: "", TenNienKhoa: tenNienKhoa, TenHocKy: ""
    };
    console.log(JSON.stringify(nienKhoa));
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
function init_Select_Khoa() {
    $("#select_Khoa").empty();
    $.ajax({
        async: false,
        type: 'GET',
        url: '/khoa/ds-khoa',
        success: function (response) {
            console.log(JSON.stringify(response));
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_Khoa').append($('<option>', {
                    value: item.MaKhoa,
                    text: item.TenKhoa
                }));
            });
            $("#select_Khoa").prop("selectedIndex", 0);
            $('#select_Khoa').trigger('change');
            maKhoa = $("#select_Khoa option:selected").val();
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
            console.log(JSON.stringify(response));
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
function init_Tree_GV() {
    $("#tree_GV").remove();
    $("#label_GV").after("<div class='form-control' id='tree_GV'></div>");
    var khoa = {
        MaKhoa: maKhoa, TenKhoa: ""
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: khoa,
        url: '/giangvien/ds-gv-by-khoa',
        success: function (response) {
            console.log(JSON.stringify(response));
            response = $.parseJSON(response);
            $('#tree_GV').bstreeview({
                data: response,
                expandIcon: 'fa fa-angle-down fa-fw',
                collapseIcon: 'fa fa-angle-right fa-fw',
                indent: 1.25,
                parentsMarginLeft: '1.25rem',
                openNodeLinkOnNewTab: true
            });
            listGV = document.querySelectorAll('[aria-level="2"]');
            $.each(listGV, function (i, item) {
                console.log(JSON.stringify(item));
            });

            $.each(listGV, function (i, item) {
                item.addEventListener('click', function (e) {
                    nodeCurrent = item;
                    $("#btnAddLTC").removeAttr("disabled");

                    //            console.log(item.parentElement.id);
                    if (nodeTree != nodeCurrent) {

                        nodeCurrent.style.background = "#ccc";
                        maGV = item.id;
                        var gv = {
                            MaGiangVien: maGV, Ho: "", Ten: "", HocVi: "", ChucDanh: "", GioiTinh: 1, NgaySinh: '1970-1-1',
                            DiaChi: "", Sdt: "", GVCoHuu: true, MaBoMon: "", ChucVu: "", TrangThaiXoa: false
                        };
                        $.ajax({
                            async: true,
                            type: 'POST',
                            data: gv,
                            url: '/hoc-vi/by-ma-gv',
                            success: function (response) {
                                response = $.parseJSON(response);
                                hocViLTC = response;
                                document.getElementById("titleLTC").innerHTML = "Danh sách lớp tín chỉ của GIẢNG VIÊN: " + hocViLTC + ". " + item.innerHTML;
                                tenGV = item.innerHTML;
                                console.log(response);
                            },
                            error: function () {
                                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
                                console.log(response);
                            }
                        });

                        getListLTC();
                        console.log('Click happened for: ' + item.id);
                        if (nodeTree != null) {
                            nodeTree.style.background = "#ffffff"
                            nodeTree = item;

                        }
                        nodeTree = item;
                    }
                    else {

                    }
                });
            });
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function getListLTC() {
    table_LTC.clear().draw();
    var LTCGetModel = {
        MaNKHK: maHocKy, MaGV: maGV
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: LTCGetModel,
        url: '/lop-tin-chi',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                item.DonGia = item.DonGia.toLocaleString('it-IT', { style: 'currency', currency: 'VND' });
                table_LTC.row.add([item.MaLTC, item.TenLTC, item.TenMonHoc, item.SiSo, item.HSLopDongLT, item.SoNhomTH, item.HSLopDongTH, item.TietLTTD, item.TietBTTD, item.TietTHTD, item.TietLTQD, item.TietBTQD, item.TietTHQD, item.DonGia, item.TenHeLop, item.TenBac]).draw(false);
            });
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function LopDem() {
    var checkBox = document.getElementById("lopDem");
    if (checkBox.checked == true) {
        $("#hsLopDem").focus();
        $("#hsLopDem").removeAttr('readonly');
        $("#hsLopDem").val(1.0);
    }
    else {
        $("#hsLopDem").attr('readonly', 'readonly');
        $("#hsLopDem").val(1.0);
    }
}
function MonMoi() {
    var checkBox = document.getElementById("monMoi");
    if (checkBox.checked == true) {
        $("#hsMonMoi").focus();
        $("#hsMonMoi").removeAttr('readonly');
        $("#hsMonMoi").val(1.0);
    }
    else {
        $("#hsMonMoi").attr('readonly', 'readonly');
        $("#hsMonMoi").val(1.0);
    }
}
function init_Select_MonHoc_LTC() {
    $('#select_MonHoc').empty();
    $.ajax({
        async: true,
        type: 'POST',
        data: "",
        url: '/mon-hoc/ds-mon-hoc',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                console.log("Môn học: " + item.TenMonHoc);
                $('#select_MonHoc').append($('<option>', {
                    value: item.MaMonHoc,
                    text: item.TenMonHoc
                }));
            });
            $("#select_MonHoc").prop("selectedIndex", 0);
            maMonHoc = $("#select_MonHoc").val();
            tenMonHoc = $("#select_MonHoc option:selected").text();
            getSoTietMonHoc();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Select_HeLop() {
    $('#select_HeLop').empty();
    $.ajax({
        async: true,
        type: 'POST',
        data: "",
        url: '/he-lop/ds-he-lop',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                console.log("Mã hệ lớp: " + JSON.stringify(item.MaHeLop));
                $('#select_HeLop').append($('<option>', {
                    value: item.MaHeLop.trim(),
                    text: item.TenHeLop.trim()
                }));
            });
            $("#select_HeLop").val('CQ');
            $("#select_HeLop").trigger('change');

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Select_BacHoc() {
    $('#select_BacHoc').empty();
    $.ajax({
        async: true,
        type: 'POST',
        data: "",
        url: '/bac-hoc/ds-bac-hoc',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                console.log(item);
                $('#select_BacHoc').append($('<option>', {
                    value: item.MaBac.trim(),
                    text: item.TenBac.trim()
                }));
            });

            $('#select_BacHoc').val('DH');
            $('#select_BacHoc').trigger('change');

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function getHeSoBac() {
    var bacHoc = {
        MaBac: maBac, TenBac: tenBac
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: bacHoc,
        url: '/bac-hoc/he-so',
        success: function (response) {

            $('#hsBac').val(response);
            if (flag_Focus_Bac > 1) {
                $("#hsBac").focus();
            }

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function getHeSoHeLop() {
    var heLop = {
        MaHeLop: maHeLop, TenHeLop: tenHeLop
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: heLop,
        url: '/he-lop/he-so',
        success: function (response) {
            $('#hsHeLop').val(response);
            if (flag_Focus_HeLop > 1) {
                $("#hsHeLop").focus();
            }

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function getSoTietMonHoc() {
    var monHoc = {
        MaMonHoc: maMonHoc, tenMonHoc, TietLT: 0, TietBT: 0, TietTH: 0
    };
    $.ajax({
        async: false,//de fix bug khi edit, neu la true thi se set sau response tra ve => sai
        type: 'POST',
        data: monHoc,
        url: '/mon-hoc/by-ma-mon',
        success: function (response) {
            response = $.parseJSON(response);
            console.log('Tiet LT: ' + response.TietLT);
            $('#tietLTQD').val(response.TietLT);
            $('#tietTHQD').val(response.TietTH);
            $('#tietBTQD').val(response.TietBT);

            $('#tietLTTD').val(response.TietLT);
            $('#tietTHTD').val(response.TietTH);
            $('#tietBTTD').val(response.TietBT);

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function saveLTC(close) {
    var tenLTC = $("#tenLTC").val();
    var hsHocKy = $('#hsHocKy').val();
    var hsLTC = $('#hsLTC').val();
    var hsBac = $('#hsBac').val();
    var hsLopDem = $('#hsLopDem').val();
    var hsMonMoi = $('#hsMonMoi').val();
    var lopDem = document.getElementById("lopDem");
    if (!lopDem.checked) {
        hsLopDem = 1;
    }
    var monMoi = document.getElementById("lopDem");
    if (!monMoi.checked) {
        hsMonMoi = 1;
    }
    var hsHeLop = $('#hsHeLop').val();
    var hsNhomTH = $('#hsNhomTH').val();
    var donGia = $('#donGia').val();
    var siSo = $('#siSo').val();
    var hsLDLT = $('#hsLDLT').val();
    var hsLDTH = $('#hsLDTH').val();
    var soNhomTH = $('#soNhomTH').val();
    var hsNhomTH = $('#hsNhomTH').val();
    var hsLDTH = $('#hsLDTH').val();
    var tietLTQD = $('#tietLTQD').val();
    var tietBTQD = $('#tietBTQD').val();
    var tietTHQD = $('#tietTHQD').val();
    var tietLTTD = $('#tietLTTD').val();
    var tietBTTD = $('#tietBTTD').val();
    var tietTHTD = $('#tietTHTD').val();
    var tenMon = $("#select_MonHoc option:selected").text();
    var tenHeLop = $("#select_HeLop option:selected").text();
    var tenBac = $("#select_BacHoc option:selected").text();
    if (tenLTC == "") {
        $("#tenLTC").focus();
        toastr.error("Vui lòng nhập tên lớp tín chỉ", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (hsHocKy.toString() == "") {
        $("#hsHocKy").focus();
        toastr.error("Vui lòng nhập hệ số học kỳ", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (hsLTC.toString() == "") {
        $("#hsLTC").focus();
        toastr.error("Vui lòng nhập hệ số lớp tín chỉ", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (hsBac.toString() == "") {
        $("#hsBac").focus();
        toastr.error("Vui lòng nhập hệ số bậc học", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (hsHeLop.toString() == "") {
        $("#hsHeLop").focus();
        toastr.error("Vui lòng nhập hệ số hệ lớp", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (document.getElementById("lopDem").checked == true && hsLopDem.toString() == "") {
        $("#hsLopDem").focus();
        toastr.error("Vui lòng nhập hệ số lớp đêm", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (document.getElementById("monMoi").checked == true && hsMonMoi.toString() == "") {
        $("#hsMonMoi").focus();
        toastr.error("Vui lòng nhập hệ số môn mới", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (donGia.toString() == "") {
        $("#donGia").focus();
        toastr.error("Vui lòng nhập đơn giá", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (siSo.toString() == "") {
        $("#siSo").focus();
        toastr.error("Vui lòng nhập sỉ số", "Lỗi", { timeOut: 3000 });
        return;
    }


    if (hsLDLT.toString() == "") {
        $("#hsLDLT").focus();
        toastr.error("Vui lòng nhập hệ số LĐ LT", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (soNhomTH.toString() == "") {
        $("#soNhomTH").focus();
        toastr.error("Vui lòng nhập số nhóm TH", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (hsNhomTH.toString() == "") {
        $("#hsNhomTH").focus();
        toastr.error("Vui lòng nhập hệ số nhóm TH", "Lỗi", { timeOut: 3000 });
        return;
    }

    if (hsLDTH.toString() == "") {
        $("#hsLDTH").focus();
        toastr.error("Vui lòng nhập hệ số LĐ TH", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (tietLTQD.toString() == "") {
        $("#tietLTQD").focus();
        toastr.error("Vui lòng nhập tiết LT QĐ", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (tietLTTD.toString() == "") {
        $("#tietLTTD").focus();
        toastr.error("Vui lòng nhập tiết LT TD", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (tietBTQD.toString() == "") {
        $("#tietBTQD").focus();
        toastr.error("Vui lòng nhập tiết BT QĐ", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (tietBTTD.toString() == "") {
        $("#tietBTTD").focus();
        toastr.error("Vui lòng nhập tiết BT TD", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (tietTHQD.toString() == "") {
        $("#tietTHQD").focus();
        toastr.error("Vui lòng nhập tiết TH QD", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (tietTHTD.toString() == "") {
        $("#tietTHTD").focus();
        toastr.error("Vui lòng nhập tiết TH TD", "Lỗi", { timeOut: 3000 });
        return;
    }
    ltcAdd = {
        MaLTC: maLTC,
        TenLTC: tenLTC,
        SiSo: siSo,
        SoNhomTH: soNhomTH,
        TietBTQD: tietBTQD,
        TietBTTD: tietBTTD,
        TietTHTD: tietTHTD,
        TietTHQD: tietTHQD,
        TietLTQD: tietLTQD,
        TietLTTD: tietLTTD,
        DonGia: donGia,
        HSMonMoi: hsMonMoi,
        HSNgoaiGio: hsLopDem,
        HSLopDongLT: hsLDLT,
        HSLopDongTH: hsLDTH,
        HSLTC: hsLTC,
        HSHocKy: hsHocKy,
        HSNhomTH: hsNhomTH,
        MaMon: maMonHoc,
        HSBac: hsBac,
        MaBac: maBac,
        HSHeLop: hsHeLop,
        MaHeLop: maHeLop,
        MaGV: maGV,
        MaNKHK: maHocKy
    };
    if (flagEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: ltcAdd,
            url: '/lop-tin-chi/add',
            success: function (response) {
                console.log(response);
                if (response.success == true) {
                    toastr.success('Thông báo', 'Thêm lớp tín chỉ thành công!', { timeOut: 3000 });

                    maLTC = JSON.parse(JSON.stringify(response.data)).maLTC;
                    var donGia = parseInt(ltcAdd.DonGia.toString());
                    donGia = donGia.toLocaleString('it-IT', { style: 'currency', currency: 'VND' });
                    table_LTC.row.add([maLTC, ltcAdd.TenLTC, tenMon, ltcAdd.SiSo, ltcAdd.HSLopDongLT, ltcAdd.SoNhomTH, ltcAdd.HSLopDongTH, ltcAdd.TietLTTD, ltcAdd.TietBTTD, ltcAdd.TietTHTD, ltcAdd.TietLTQD, ltcAdd.TietBTQD, ltcAdd.TietTHQD, donGia, tenHeLop, tenBac]).draw(false);
                    if (close) {
                        $('#modalAddLTC').modal('hide');
                    }
                }
                else {
                    toastr.error('Lỗi rồi ' + response.message, 'Error Alert', { timeOut: 3000 });
                }
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    }
    else {
        $.ajax({
            async: true,
            type: 'POST',
            data: ltcAdd,
            url: '/lop-tin-chi/edit',
            success: function (response) {
                console.log('LTC: ' + JSON.stringify(ltcAdd));
                toastr.success('Thông báo', 'Chỉnh sửa lớp tín chỉ thành công!', { timeOut: 3000 });
                if (close) {
                    $('#modalAddLTC').modal('hide');
                }
                var donGia = parseInt(ltcAdd.DonGia.toString());
                donGia = donGia.toLocaleString('it-IT', { style: 'currency', currency: 'VND' });

                table_LTC.cell(this, 1).data(ltcAdd.TenLTC);
                table_LTC.cell(this, 2).data(tenMon);
                table_LTC.cell(this, 3).data(ltcAdd.SiSo);
                table_LTC.cell(this, 4).data(ltcAdd.HSLopDongLT);
                table_LTC.cell(this, 5).data(ltcAdd.SoNhomTH);
                table_LTC.cell(this, 6).data(ltcAdd.HSLopDongTH);
                table_LTC.cell(this, 7).data(ltcAdd.TietLTTD);
                table_LTC.cell(this, 8).data(ltcAdd.TietBTTD);
                table_LTC.cell(this, 9).data(ltcAdd.TietTHTD);
                table_LTC.cell(this, 10).data(ltcAdd.TietLTQD);
                table_LTC.cell(this, 11).data(ltcAdd.TietBTQD);
                table_LTC.cell(this, 12).data(ltcAdd.TietTHQD);
                table_LTC.cell(this, 13).data(donGia);
                table_LTC.cell(this, 14).data(tenHeLop);
                table_LTC.cell(this, 15).data(tenBac);
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    }
}
function editFunction() {
    document.getElementById('btnSaveLTC').style.display = "none";
    $("#modalAddLTC").modal("show");
}
function onKeyUpSiSo() {
    var siSo = document.getElementById("siSo").value;
    getHeSoLopDongLyThuyet(siSo);
}
function onKeyUpSoNhomTH() {
    var siSo = document.getElementById("siSo").value;
    var soNhom = document.getElementById("soNhomTH").value;
    if (siSo.toString() == "") {
        toastr.error("Mời bạn nhập sỉ số lớp tín chỉ", "Lỗi", { timeOut: 3000 });
        $('#siSo').focus();
        return;
    }
    var siSoNhomTH = siSo / soNhom;
    getHeSoLopDongThucHanh(siSoNhomTH);
}
function onClickHSTH() {
    var siSo = document.getElementById("siSo").value;
    var soNhom = document.getElementById("soNhomTH").value;
    if (siSo.toString() == "") {
        toastr.error("Mời bạn nhập sỉ số lớp tín chỉ", "Lỗi", { timeOut: 3000 });
        $('#siSo').focus();
        return;
    }
    if (soNhom.toString() == "") {
        toastr.error("Mời bạn nhập số nhóm thực hành", "Lỗi", { timeOut: 3000 });
        $('#soNhomTH').focus();
        return;
    }
    var siSoNhomTH = siSo / soNhom;
    getHeSoLopDongThucHanh(siSoNhomTH);
}
function getHeSoLopDongLyThuyet(siSo) {
    $.ajax({
        async: true,
        type: 'GET',
        data: { maKhoa: maKhoa, siSo: siSo },
        url: '/lop-dong-ly-thuyet/he-so',
        success: function (response) {
            response = $.parseJSON(response);
            $('#hsLDLT').val(response);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            console.log(response);
        }
    });
}
function getHeSoLopDongThucHanh(siSoNhomTH) {
    $.ajax({
        async: true,
        type: 'GET',
        data: { maKhoa: maKhoa, siSo: siSoNhomTH },
        url: '/lop-dong-thuc-hanh/he-so',
        success: function (response) {
            response = $.parseJSON(response);
            $('#hsLDTH').val(response);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            console.log(response);
        }
    });
}
function loading() {
    $.ajax({
        async: true,
        type: 'GET',
        data: "",
        url: '/loading/lop-tin-chi',
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

function getDonGia() {
    $.ajax({
        async: false,//fix khi edit, chỉ chạy khi select môn thay đổi xong mới set giá từ DB
        type: 'GET',
        data: { maGV: maGV, tenMon: tenMonHoc },
        url: '/lop-tin-chi/don-gia',
        success: function (response) {
            response = $.parseJSON(response.data);
            $('#donGia').val(response);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function initFormAdd() {
    $('#tenLTC').val("");
    $('#lopDem').prop('checked', false);
    $('#monMoi').prop('checked', false);
    $('#siSo').val(null);
    $('#hsLDTH').val(null);
    $('#soNhomTH').val(null);
    $('#hsLDTH').val(null);
    document.getElementById("btnSaveLTC").style.display = "inline";
    init_Select_MonHoc_LTC();
    init_Select_HeLop();
    init_Select_BacHoc();
    if (maHocKyInt % 10 == 3) {
        $('#hsHocKy').val(1.5);
    }
    else {
        $('#hsHocKy').val('1');
    }
}





