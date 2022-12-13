var tenNienKhoa = "";
var maHocKy = "";
var maKhoa = "";
var table_DMG;
var maGV = "";
var tenGV = "";
var lop = "";
var flagEdit = "";
var chucDanh, chucVu;
var tenNienKhoaCopy, maHocKyCopy;
var row;
var maHocKyCurrent;
var canEdit = true;
var haveGV = false;
var haveDMNCKH = 0;
$(document).ready(function () {
    /*   loading();*/
    $(document).on('shown.bs.modal', '#modalAddDMNCKH', function () {
        $('#dinhMucNCKH').focus();
    })
    table_DMNCKH = $("#table_DMNCKH").DataTable();
    table_DMNCKH.columns(0).visible(false);
    table_DMNCKH.columns(1).visible(false);
    $("#select_Khoa").select2();
    $("#select_GV").select2({
        dropdownParent: $('#modalAddDMNCKH'),
    });

    init_Select_NienKhoa();
    maHocKyCurrent = maHocKy;
    init_Select_Khoa();
    $('#table_DMNCKH tbody').on('click', 'tr', function () {
        var index = table_DMNCKH.row(this).index();
        if ($(this).hasClass('selected') && table_DMNCKH_rowIndex != index) {
            $(this).removeClass('selected');
            table_DMNCKH_rowIndex = index;
        }
        else {
            table_DMNCKH.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_DMNCKH_rowIndex = index;
        }
    });
    $('#table_DMNCKH').on('click', 'td.editor-edit', function (e) {
        if (!canEdit) {
            return;
        }
        $("#label_DMNCKH").html("Chỉnh sửa định mức NCKH");
        maGV = table_DMNCKH.cell(this, 0).data();
        flagEdit = maGV;
        $("#select_GV").val(maGV);
        $("#select_GV").trigger('change');
        $("#select_GV").attr("disabled", "disabled");
        $("#dinhMucNCKH").val(table_DMNCKH.cell(this, 5).data());
        $("#ghiChu").val(table_DMNCKH.cell(this, 6).data());
        row = table_DMNCKH.row(this);
    });

    $('#table_DMNCKH').on('click', 'td.editor-delete', function () {
        if (!canEdit) {
            return;
        }
        maGV = table_DMNCKH.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa định mức NCKH này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_DMNCKH.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maGV: maGV, maNKHK: maHocKy },
                    url: 'dinh-muc-nckh/delete',
                    success: function (response) {
                        if (response.success == true) {
                            toastr.success(response.data, "Thông báo", { timeOut: 3000 });
                            row.remove().draw();
                            if (table_DMNCKH.data().count() == 0) {
                                document.getElementById("btnCopyDMNCKH").removeAttribute("disabled");
                            }
                        } else {
                            toastr.error(response.message, "Lỗi", { timeOut: 3000 });
                        }
                    }
                });

            };
        });
    });
    $("#btnAddDMNCKH").click(function (e) {
        flagEdit = "";
        lop = "";
        initFormAdd();
        $("#modalAddDMNCKH").modal("show");
        document.getElementById('btnSaveDMNCKH').style.display = "inline";
        $("#label_DMNCKH").html("Thêm định mức NCKH");

    });
    $("#btnCloseDMNCKH").click(function (e) {
        $("#modalAddDMNCKH").modal("hide");
    });
    $(document).on('shown.bs.modal', '#modalAddDMNCKH', function () {
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
    init_Select_GV(maKhoa);
    getListDMNCKH();
    if (haveGV == false) {
        $("#btnAddDMNCKH").attr("disabled", "disabled");
      //  $("#btnCopyDMNCKH").attr("disabled", "disabled");
    }
    else {
        $("#btnAddDMNCKH").removeAttr("disabled");
        if (haveDMNCKH == 0)
            $("#btnCopyDMNCKH").removeAttr("disabled");
    }

}
function onChange_Select_HocKy(event) {
    maHocKy = $("#select_HocKy").val();
    getListDMNCKH();
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
            var count = -1;
            $.each(response, function (i, item) {
                if (parseInt(item.MaNKHK, 10) % 10 != 3) {
                    $('#select_HocKy').append($('<option>', {
                        value: item.MaNKHK,
                        text: item.TenHocKy
                    }));
                };
                count++;
            });
            $("#select_HocKy").prop("selectedIndex", count);
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
        async: false,
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
        url: '/loading/dinh-muc-nckh',
        success: function (response) {
            response = $.parseJSON(response);
            flagDisableUpdate = response;
            if (response == 1) {

                $("#modalLoadingDMNCKH").modal('show');
                setTimeout(function () {
                    $("#modalLoadingDMNCKH").modal('hide')
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
    $("#select_GV").removeAttr("disabled");
    $("#dinhMucNCKH").val(null);
    $("#ghiChu").val("");

}
function getListDMNCKH() {
    table_DMNCKH.clear().draw(false);
    table_DMNCKH.destroy();
    $.ajax({
        async: false,
        type: 'GET',
        data: { MaKhoa: maKhoa, MaNKHK: maHocKy },
        url: 'dinh-muc-nckh/ds',
        success: function (response) {
            if ($.parseJSON(response).count > 0) {
                haveDMNCKH = $.parseJSON(response).count;
          //      $("#btnCopyDMNCKH").attr("disabled", "disabled");
               document.getElementById("copyDMNCKH").style.display = "none";
            }
            else {
                $("#btnCopyDMNCKH").removeAttr("disabled");
            }
            table_DMNCKH = $('#table_DMNCKH').DataTable({
                "drawCallback": function () {
                    $('.paginate_button.next', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (maHocKy != maHocKyCurrent) {
                                $("#btnAddDMNCKH").attr("disabled", "disabled");

                                $("#btnCopyDMNCKH").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
  
                            else if (maHocKy == maHocKyCurrent && haveGV == true) {
                                $("#btnAddDMNCKH").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                    $('.paginate_button', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");
                            if (maHocKy != maHocKyCurrent ) {
                                $("#btnAddDMNCKH").attr("disabled", "disabled");
                               $("#btnCopyDMNCKH").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else if (maHocKy == maHocKyCurrent && haveGV == true) {
                                $("#btnAddDMNCKH").removeAttr("disabled");
      
                                canEdit = true;
                            }
                        });
                },
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
                    'data': 'GhiChu',
                }],
                'columnDefs': [{
                    'targets': 7,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button class="edit"><i class="fa fa-pencil" onclick="editFunction()" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 8,
                    'className': "dt-center editor-delete",
                    'defaultContent': '<button class="edit"><i class="fa fa-trash"/></button>',
                    'orderable': false,
                    'searchable': false
                }
                ]
            }
            );
            var listBtnEditDelete = document.getElementsByClassName("edit");

                if (maHocKy != maHocKyCurrent ) {
                    $("#btnAddDMNCKH").attr("disabled", "disabled");
                   $("#btnCopyDMNCKH").attr("disabled", "disabled");
                    canEdit = false;
                    $.each(listBtnEditDelete, function (i, item) {
                        item.setAttribute("disabled", "disabled");
                    });
                }
                else if (maHocKy == maHocKyCurrent ) {
                    $("#btnAddDMNCKH").removeAttr("disabled");
                    $("#btnCopyDMNCKH").removeAttr("disabled");
                    canEdit = true;
                }
            table_DMNCKH.columns(0).visible(false);
            table_DMNCKH.columns(1).visible(false);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function saveDMNCKH(close) {
    var dinhMucNCKH = $("#dinhMucNCKH").val();
    var ghiChu = $("#ghiChu").val();
    if (dinhMucNCKH.toString() == "") {
        $("#dinhMucNCKH").focus();
        toastr.error("Vui lòng nhập định mức NCKH", "Lỗi", { timeOut: 3000 });
        return;
    }
    var dinhMucNCKHModelAdd = {
        MaGV: maGV,
        MaNKHK: maHocKy,
        DinhMuc: dinhMucNCKH,
        GhiChu: ghiChu
    };
    if (flagEdit == "") {
        $.ajax({
            async: false,
            type: 'POST',
            data: { model: dinhMucNCKHModelAdd },
            url: '/dinh-muc-nckh/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success('Thông báo', 'Thêm định mức NCKH thành công!', { timeOut: 3000 });
                    var model = {
                        MaGiangVien: maGV,
                        MaNKHK: maHocKy,
                        HoTen: tenGV,
                        ChucDanh: chucDanh,
                        ChucVu: chucVu,
                        DinhMuc: dinhMucNCKH,
                        GhiChu: ghiChu
                    };
                    table_DMNCKH.row.add(model).draw(false);
                    if (close) {
                        $('#modalAddDMNCKH').modal('hide');
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
            data: { model: dinhMucNCKHModelAdd },
            url: '/dinh-muc-nckh/edit',
            success: function (response) {
                toastr.success('Chỉnh sửa định mức NCKH thành công!', 'Thông báo', { timeOut: 3000 });
                $("#select_GV").removeAttr("disabled");
                var model = {
                    MaGiangVien: maGV,
                    MaNKHK: maHocKy,
                    HoTen: tenGV,
                    ChucDanh: chucDanh,
                    ChucVu: chucVu,
                    DinhMuc: dinhMucNCKH,
                    GhiChu: ghiChu
                };
                $('#modalAddDMNCKH').modal('hide');
                row.data(model);
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    }
}
function editFunction() {
    if (!canEdit) {
        return;
    }
    document.getElementById('btnSaveDMNCKH').style.display = "none";
    $("#modalAddDMNCKH").modal("show");
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
            if (response.data == 0) {
                haveGV = false;
            }
            else {
                haveGV = true;
            }

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function copyDMNCKH() {
    document.getElementById("copyDMNCKH").style.display = "inline";
    init_Select_HocKy_Copy();
    init_Select_NienKhoa_Copy();
}
function cancelCopyDMNCKH() {
    document.getElementById("copyDMNCKH").style.display = "none";
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
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function functionCopyDMNCKH() {
    maHocKyCopy = $("#select_HocKy_Copy").val();
    $.ajax({
        async: false,
        type: 'POST',
        data: { maNKHK: maHocKyCopy, maNKHKTo: maHocKy },
        url: '/dinh-muc-nckh/sao-chep',
        success: function (response) {
            toastr.success("Sao chép thành công!", "Thông báo", { timeOut: 3000 });
            getListDMNCKH();
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
        url: '/dinh-muc-nckh/copy',
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



