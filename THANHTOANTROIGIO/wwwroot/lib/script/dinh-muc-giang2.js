var tenNienKhoa = "";
var maHocKy = "";
var maKhoa = "";
var listSubject;
var listGV;
var nodeTree = null;
var table_DMG;
var maGV = "";
var tenGV = "";
var maHeLop, tenHeLop, tenBac, maBac, maMonHoc, tenMonHoc = "x";
var maHocKyInt;
var flag_Focus_Bac = 0;
var flag_Focus_HeLop = 0;
var table_DMG_rowIndex = 0;
var lop = "";
var flagEdit = "";
var chucDanh, chucVu;
var tenNienKhoaCopy, maHocKyCopy;
var row;
$(document).ready(function () {
    loading();
    table_DMG = $("#table_DMG").DataTable();
    table_DMG.columns(0).visible(false);
    table_DMG.columns(1).visible(false);
    $("#select_Khoa").select2();
    $("#select_GV").select2({
        dropdownParent: $('#modalAddDMG'),
    });

    init_Select_NienKhoa();
    init_Select_Khoa();
    $('#table_DMG tbody').on('click', 'tr', function () {
        var index = table_DMG.row(this).index();
        if ($(this).hasClass('selected') && table_DMG_rowIndex != index) {
            $(this).removeClass('selected');
            table_DMG_rowIndex = index;
        }
        else {
            table_DMG.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_DMG_rowIndex = index;
        }
    });
    $('#table_DMG').on('click', 'td.editor-edit', function (e) {
        $("#label_DMG").html("Chỉnh sửa định mức giảng");
        maGV = table_DMG.cell(this, 0).data();
        flagEdit = maGV;
        $("#select_GV").val(maGV);
        $("#select_GV").trigger('change');
        $("#select_GV").attr("disabled", "disabled");
        $("#dinhMucGiang").val(table_DMG.cell(this, 5).data());
        $("#moTa").val(table_DMG.cell(this, 6).data());
        row = table_DMG.row(this);
    });

    $('#table_DMG').on('click', 'td.editor-delete', function () {
        maGV = table_DMG.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa định mức giảng này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_DMG.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maGV: maGV, maNKHK: maHocKy },
                    url: 'dinh-muc-giang/delete',
                    success: function (response) {
                        if (response.success == true) {
                            toastr.success(response.data, "Thông báo", { timeOut: 3000 });
                            row.remove().draw();
                            console.log("So hang: " + table_DMG.data().count());
                            if (table_DMG.data().count() == 0) {
                                document.getElementById("btnCopyDMG").removeAttribute("disabled");
                            //    $("#btnCopyDMG").re removeAttr("disabled");
                            }
                        } else {
                            toastr.error(response.message, "Lỗi", { timeOut: 3000 });
                        }
                    }
                });

            };
        });
    });
    $("#btnAddDMG").click(function (e) {
        flagEdit = "";
        lop = "";
        initFormAdd();
        $("#modalAddDMG").modal("show");
        document.getElementById('btnSaveDMG').style.display = "inline";
        $("#label_DMG").html("Thêm định mức giảng");

    });
    $("#btnCloseDMG").click(function (e) {
        $("#modalAddDMG").modal("hide");
    });
    $(document).on('shown.bs.modal', '#modalAddDMG', function () {
        $('#lop').focus();
    })

});
////Onchange
function onChange_Select_NienKhoa(event) {
    tenNienKhoa = $("#select_NienKhoa option:selected").val();
    init_Select_HocKy();
}
function onChange_Select_NienKhoa_Copy(event) {
    tenNienKhoaCopy = $("#select_NienKhoa_Copy option:selected").val();
    init_Select_HocKy_Copy();
}
function onChange_Select_HocKy_Copy(event) {
    maHocKyCopy = $("#select_NienKhoa_Copy option:selected").val();
    //  canCopy();
}
function onChange_Select_Khoa(event) {
    maKhoa = $("#select_Khoa option:selected").val();
    getListDMG();
    init_Select_GV(maKhoa);
}
function onChange_Select_HocKy(event) {
    maHocKy = $("#select_HocKy").val();
    getListDMG();
}
function onChange_Select_GV(event) {
    maGV = $("#select_GV").val();
    tenGV = $("#select_GV option:selected").text();
    chucDanh = $("#select_GV option:selected").attr("chucDanh");
    chucVu = $("#select_GV option:selected").attr("chucVu");
    $("#chucDanh").val(chucDanh);
    $("#chucVu").val(chucVu);
}

/////
function init_Select_HocKy() {
    $("#select_HocKy").empty();
    var nienKhoa = {
        MaNKHK: "", TenNienKhoa: tenNienKhoa, TenHocKy: ""
    };
    $.ajax({
        async: false,
        type: 'POST',
        data: nienKhoa,
        url: '/nien-khoa-hoc-ky/hoc-ky',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                if (parseInt(item.MaNKHK, 10) % 10 != 3) {
                    $('#select_HocKy').append($('<option>', {
                        value: item.MaNKHK,
                        text: item.TenHocKy
                    }));
                }
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
function init_Select_Khoa() {
    $("#select_Khoa").empty();
    $.ajax({
        async: true,
        type: 'GET',
        url: '/khoa/ds-khoa',
        success: function (response) {
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
            init_Select_GV(maKhoa);
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
        url: '/loading/dinh-muc-giang',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingDMG").modal('show');
                setTimeout(function () {
                    $("#modalLoadingDMG").modal('hide')
                }, 2500)
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function initFormAdd() {
    $("#select_GV").prop("selectedIndex", 0);
    $("#dinhMucGiang").val(null);
}
function getListDMG() {
    table_DMG.clear().draw(false);
    table_DMG.destroy();
    $.ajax({
        async: false,
        type: 'GET',
        data: { MaKhoa: maKhoa, MaNKHK: maHocKy },
        url: 'dinh-muc-giang/ds',
        success: function (response) {
            if ($.parseJSON(response).count > 0) {
                $("#btnCopyDMG").attr("disabled", "disabled");
                document.getElementById("copyDMG").style.display = "none";
            }
            else {
                $("#btnCopyDMG").removeAttr("disabled");
            }
            table_DMG = $('#table_DMG').DataTable({
                "data": $.parseJSON(response).data,
                "columns": [{
                    'data': 'MaGiangVien',
                },
                {
                    'data': 'MaNKHK',
                }, {
                    'data': 'HoTen',
                }, {
                    'data': 'ChucDanh',
                }, {
                    'data': 'ChucVu',
                }, {
                    'data': 'DinhMuc',
                }, {
                    'data': 'MoTa',
                }],
                'columnDefs': [{
                    'targets': 7,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button><i class="fa fa-pencil" onclick="editFunction()" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 8,
                    'className': "dt-center editor-delete",
                    'defaultContent': '<button><i class="fa fa-trash"/></button>',
                    'orderable': false,
                    'searchable': false
                }
                ]
            }
            );
            table_DMG.columns(0).visible(false);
            table_DMG.columns(1).visible(false);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function saveDMG(close) {
    var dinhMucGiang = $("#dinhMucGiang").val();
    var moTa = $("#moTa").val();
    if (dinhMucGiang.toString() == "") {
        $("#dinhMucGiang").focus();
        toastr.error("Vui lòng nhập định mức giảng", "Lỗi", { timeOut: 3000 });
        return;
    }
    var dinhMucGiangModelAdd = {
        MaGV: maGV,
        MaNKHK: maHocKy,
        DinhMuc: dinhMucGiang,
        MoTa:moTa
    };
    console.log("model: " + JSON.stringify(dinhMucGiangModelAdd));
    if (flagEdit == "") {
        $.ajax({
            async: false,
            type: 'POST',
            data: { model: dinhMucGiangModelAdd },
            url: '/dinh-muc-giang/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success('Thông báo', 'Thêm định mức giảng thành công!', { timeOut: 3000 });
                    var model = {
                        MaGiangVien: maGV,
                        MaNKHK: maHocKy,
                        HoTen: tenGV,
                        ChucDanh: chucDanh,
                        ChucVu: chucVu,
                        DinhMuc: dinhMucGiang,
                        MoTa:moTa
                    };
                    table_DMG.row.add(model).draw(false);
                    if (close) {
                        $('#modalAddDMG').modal('hide');
                    }
                }
                else {
                    toastr.error(response.message, 'Lỗi', { timeOut: 5000 });
                }
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    }
    else {
        $.ajax({
            async: false,
            type: 'POST',
            data: { model: dinhMucGiangModelAdd },
            url: '/dinh-muc-giang/edit',
            success: function (response) {
                toastr.success('Chỉnh sửa định mức giảng thành công!', 'Thông báo', { timeOut: 3000 });
                $("#select_GV").removeAttr("disabled");
                var model = {
                    MaGiangVien: maGV,
                    MaNKHK: maHocKy,
                    HoTen: tenGV,
                    ChucDanh: chucDanh,
                    ChucVu: chucVu,
                    DinhMuc: dinhMucGiang,
                    MoTa:moTa
                };
                $('#modalAddDMG').modal('hide');
                row.data(model);
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    }
}
function editFunction() {
    document.getElementById('btnSaveDMG').style.display = "none";
    $("#modalAddDMG").modal("show");
}
function init_Select_GV(maKhoa) {
    $('#select_GV').empty();
    $.ajax({
        async: false,
        type: 'GET',
        data: { MaKhoa: maKhoa },
        url: '/giangvien/select_khoa',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response.data, function (i, item) {
                $('#select_GV').append($('<option>', {
                    value: item.MaGiangVien,
                    text: item.HoTen,
                    chucVu: item.ChucVu,
                    chucDanh: item.ChucDanh
                }));
            });
            $("#select_GV").prop("selectedIndex", 0);
            maGV = $("#select_GV option:selected").val();
            tenGV = $("#select_GV option:selected").text();
            chucDanh = $("#select_GV option:selected").attr("chucDanh");
            chucVu = $("#select_GV option:selected").attr("chucVu");
            $("#chucDanh").val(chucDanh);
            $("#chucVu").val(chucVu);
            console.log(chucVu);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function copyDMG() {
    document.getElementById("copyDMG").style.display = "inline";
    init_Select_HocKy_Copy();
    init_Select_NienKhoa_Copy();
}
function cancelCopyDMG() {
    document.getElementById("copyDMG").style.display = "none";
}
function init_Select_NienKhoa_Copy() {
    $("#select_NienKhoa_Copy").empty();
    $.ajax({
        async: false,
        type: 'GET',
        url: '/nien-khoa-hoc-ky/nien-khoa',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_NienKhoa_Copy').append($('<option>', {
                    value: item.TenNienKhoa,
                    text: item.TenNienKhoa
                }));
            });
            $("#select_NienKhoa_Copy").prop("selectedIndex", 0);
            tenNienKhoaCopy = $("#select_NienKhoa_Copy option:selected").val();
            init_Select_HocKy_Copy();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Select_HocKy_Copy() {
    $("#select_HocKy_Copy").empty();
    var nienKhoa = {
        MaNKHK: "", TenNienKhoa: tenNienKhoaCopy, TenHocKy: ""
    };
    $.ajax({
        async: false,
        type: 'POST',
        data: nienKhoa,
        url: '/nien-khoa-hoc-ky/hoc-ky',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                if (parseInt(item.MaNKHK, 10) % 10 != 3) {
                    $('#select_HocKy_Copy').append($('<option>', {
                        value: item.MaNKHK,
                        text: item.TenHocKy
                    }));
                }
            });
            $("#select_HocKy_Copy").prop("selectedIndex", 0);
            $("#select_HocKy_Copy").trigger("change");
            maHocKyCopy = $("#select_HocKy_Copy option:selected").val();
            console.log("Mã học kỳ copy: " + maHocKyCopy);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function functionCopyDMG() {
    maHocKyCopy = $("#select_HocKy_Copy").val();
    $.ajax({
        async: false,
        type: 'POST',
        data: { maNKHK: maHocKyCopy, maNKHKTo: maHocKy },
        url: '/dinh-muc-giang/sao-chep',
        success: function (response) {
            toastr.success("Sao chép thành công!", "Thông báo", { timeOut: 3000 });
            getListDMG();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });


}
function canCopy() {
    $.ajax({
        async: false,
        type: 'POST',
        data: { maHocKy: maHocKyCopy },
        url: '/dinh-muc-giang/copy',
        success: function (response) {
            response = response.data;
            if (response.data) {
                $("#btnAgreeCopy").attr("disabled", "disabled");
            }
            else {
                $("#btnAgreeCopy").removeAttr("disabled");
            }
            $("#select_HocKy_Copy").prop("selectedIndex", 0);
            $("#select_HocKy_Copy").trigger("change");
            maHocKyCopy = $("#select_HocKy_Copy option:selected").val();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}



