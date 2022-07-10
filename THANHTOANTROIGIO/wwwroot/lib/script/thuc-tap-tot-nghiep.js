var tenNienKhoa = "";
var maHocKy = "";
var maKhoa = "";
var listSubject;
var listGV;
var nodeTree = null;
var table_TTTN;
var maGV = "";
var hocViLTC = "";
var maHeLop, tenHeLop, tenBac, maBac, maMonHoc, tenMonHoc = "x";
var maHocKyInt;
var flag_Focus_Bac = 0;
var flag_Focus_HeLop = 0;
var table_TTTN_rowIndex = 0;
var lop = "";
var tttnModel = null;
var flagEdit = "";
$(document).ready(function () {
    loading();
    table_TTTN = $("#table_TTTN").DataTable();
    table_TTTN.columns(0).visible(false);
    table_TTTN.columns(1).visible(false);
    $("#select_Khoa").select2();
    init_Select_NienKhoa();
    init_Select_Khoa();
    init_Tree_GV();
    $('#table_TTTN tbody').on('click', 'tr', function () {
        var index = table_TTTN.row(this).index();
        if ($(this).hasClass('selected') && table_TTTN_rowIndex != index) {
            $(this).removeClass('selected');
            table_TTTN_rowIndex = index;
        }
        else {
            table_TTTN.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_TTTN_rowIndex = index;
        }
    });
    $('#table_TTTN').on('click', 'td.editor-edit', function (e) {
        $("#label_TTTN").html("Chỉnh sửa lớp hướng dẫn TTTN");
        lop = table_TTTN.cell(this, 2).data();
        flagEdit = lop;
        tttnModel = {
            MaGV: maGV,
            MaNKHK: maHocKy,
            HSPhanBien: table_TTTN.cell(this, 7).data(),
            SoSinhVienPB: table_TTTN.cell(this, 6).data(),
            Lop: table_TTTN.cell(this, 2).data(),
            SoSinhVienHD: table_TTTN.cell(this, 4).data(),
            SoTuan: table_TTTN.cell(this, 3).data(),
            HSHuongDan: table_TTTN.cell(this, 5).data(),
        };
        $('#hsHuongDan').val(tttnModel.HSHuongDan);
        $('#hsPhanBien').val(tttnModel.HSPhanBien);
        $('#lop').val(tttnModel.Lop);
        $('#soSinhVienHD').val(tttnModel.SoSinhVienHD);
        $('#soSinhVienPB').val(tttnModel.SoSinhVienPB);
        $('#soTuan').val(tttnModel.SoTuan);
     
    });

    $('#table_TTTN').on('click', 'td.editor-delete', function () {
        lop = table_TTTN.cell(this, 2).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa lớp tín chỉ này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_TTTN.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maGV: maGV, maNKHK: maHocKy,lop:lop },
                    url: 'thuc-tap-tot-nghiep/delete',
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

    $('#btnAddTTTN').attr('disabled', 'disabled');
    $("#btnAddTTTN").click(function (e) {
        flagEdit = "";
        lop = "";
        initFormAdd();
        $("#modalAddTTTN").modal("show");
        document.getElementById('btnSaveTTTN').style.display = "inline";
        $("#label_TTTN").html("Thêm lớp tín chỉ");

    });
    $("#btnCloseTTTN").click(function (e) {
        $("#modalAddTTTN").modal("hide");
    });
    $(document).on('shown.bs.modal', '#modalAddTTTN', function () {
        $('#lop').focus();
    })

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
        getListTTTN();
    }

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
                    $("#btnAddTTTN").removeAttr("disabled");
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
                                document.getElementById("titleTTTN").innerHTML = "DANH SÁCH hướng dẫn thực tập tốt nghiệp của GIẢNG VIÊN: " + hocViLTC + ". " + item.innerHTML;
                                console.log(response);
                            },
                            error: function () {
                                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
                                console.log(response);
                            }
                        });
                        getListTTTN();
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
function loading() {
    $.ajax({
        async: true,
        type: 'GET',
        data: "",
        url: '/loading/thuc-tap-tot-nghiep',
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
function initFormAdd() {
    $('#hsHuongDan').val(0.8);
    $('#hsPhanBien').val(0.4);
    $('#lop').val("");
    $('#soSinhVienHD').val(null);
    $('#soSinhVienPB').val(null);
    if (maKhoa == "CNTT2") {
        $('#soTuan').val(6);
    }
    else {
        $('#soTuan').val(4);
    }

    $('#thanhToan').val(null);
}
function getListTTTN() {
    table_TTTN.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { MaNKHK: maHocKy, MaGV: maGV },
        url: '/thuc-tap-tot-nghiep/ds-tttn',
        success: function (response) {
            table_TTTN = $('#table_TTTN').DataTable({
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
                }],
                'columnDefs': [{
                    'targets': 8,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button><i class="fa fa-pencil" onclick="editFunction()" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 9,
                    'className': "dt-center editor-delete",
                    'defaultContent': '<button><i class="fa fa-trash"/></button>',
                    'orderable': false,
                    'searchable': false
                }
                ]
            }
            );
            table_TTTN.columns(0).visible(false);
            table_TTTN.columns(1).visible(false);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function saveTTTN(close) {
    var lopAdd = $("#lop").val();
    var hsHuongDan = $('#hsHuongDan').val();
    var hsPhanBien = $('#hsPhanBien').val();
    var soSVHD = $('#soSinhVienHD').val();
    var soSVPB = $('#soSinhVienPB').val();
    var soTuan = $('#soTuan').val();

    if (lopAdd == "") {
        $("#lop").focus();
        toastr.error("Vui lòng nhập tên lớp hướng dẫn TTTN", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (hsHuongDan.toString() == "") {
        $("#hsHuongDan").focus();
        toastr.error("Vui lòng nhập hệ số hướng dẫn", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (hsPhanBien.toString() == "") {
        $("#hsPhanBien").focus();
        toastr.error("Vui lòng nhập hệ số phản biện", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (soSVHD.toString() == "") {
        $("#soSinhVienHD").focus();
        toastr.error("Vui lòng nhập số sinh viên hướng dẫn", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (soSVPB.toString() == "") {
        $("#soSinhVienPB").focus();
        toastr.error("Vui lòng nhập số sinh viên phản biện", "Lỗi", { timeOut: 3000 });
        return;
    }
    if (soTuan.toString() == "") {
        $("#soTuan").focus();
        toastr.error("Vui lòng nhập số tuần", "Lỗi", { timeOut: 3000 });
        return;
    }
    tttnModel = {
        MaGV: maGV,
        MaNKHK: maHocKy,
        HSPhanBien: hsPhanBien,
        SoSinhVienPB: soSVPB,
        Lop: lopAdd,
        SoSinhVienHD: soSVHD,
        SoTuan: soTuan,
        HSHuongDan: hsHuongDan
    };
    if (flagEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: tttnModel,
            url: '/thuc-tap-tot-nghiep/add',
            success: function (response) {
                console.log(response);
                if (response.success == true) {
                    toastr.success('Thông báo', 'Thêm lớp hướng dẫn thực tập tốt nghiệp thành công!', { timeOut: 3000 });
                    table_TTTN.row.add(tttnModel).draw(false);
                    if (close) {
                        $('#modalAddTTTN').modal('hide');
                    }
                }
                else {
                    toastr.error('Lỗi rồi ' + response.message, 'Error Alert', { timeOut: 5000 });
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
            data: { lop: lop, model: tttnModel },
            url: '/thuc-tap-tot-nghiep/edit',
            success: function (response) {
                toastr.success('Chỉnh sửa lớp hướng dẫn thực tập tốt nghiệp thành công!', 'Thông báo', { timeOut: 3000 });
                $('#modalAddTTTN').modal('hide');
                table_TTTN.row(this).data(tttnModel);
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    }
}
function editFunction() {
    document.getElementById('btnSaveTTTN').style.display = "none";
    $("#modalAddTTTN").modal("show");
}




