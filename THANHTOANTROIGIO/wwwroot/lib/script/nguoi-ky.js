var table_NguoiKy_rowIndex = 0;
var maNguoiKy = "";
var tenNguoiKy = "";
var flagEdit = false;
var table_NguoiKy;
var row;
var nkhk;
var flagEditNKHK = false;
$(document).ready(function () {
    /* loading();*/
    init_table_NguoiKy();
    init_Select_NienKhoa();
    $('#select_ChucVu').select2({
        dropdownParent: $('#modalAddNguoiKy'),
    });
    $(document).on('shown.bs.modal', '#modalAddNguoiKy', function () {
        $('#hoTen').focus();
    })
    document.getElementById("title").innerHTML = "NGƯỜI KÝ";


    $('#table_NguoiKy tbody').on('click', 'tr', function () {
        var index = table_NguoiKy.row(this).index();
        if ($(this).hasClass('selected') && table_NguoiKy_rowIndex != index) {
            $(this).removeClass('selected');
            table_NguoiKy_rowIndex = index;
        }
        else {
            table_NguoiKy.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_NguoiKy_rowIndex = index;
        }
    });

    $('#table_NguoiKy').on('click', 'td.editor-edit', function (e) {
        if (canEdit) {
            $("#titleAddMonHoc").html("Chỉnh sửa người ký");
            row = table_NguoiKy.row(this);
            flagEdit = true;
            flagEditNKHK = true;
            var hoTen = table_NguoiKy.cell(this, 1).data();
            var chucVu = table_NguoiKy.cell(this, 2).data();
            nkhk = table_NguoiKy.cell(this, 4).data();
            var tenNienKhoa = table_NguoiKy.cell(this, 8).data();
            var maChucVu = table_NguoiKy.cell(this, 7).data();
            $('#hoTen').val(hoTen);
            $('#select_ChucVu').val(maChucVu);
            $('#select_ChucVu').trigger('change');

            $('#select_NienKhoa').val(tenNienKhoa);
            $('#select_NienKhoa').trigger('change');

            $("#select_HocKy").val(nkhk);
            $('#select_HocKy').trigger('change');

            $("#modalAddNguoiKy").modal("show");
            $("#titleAddNguoiKy").html("Chỉnh sửa người ký");

            console.log("Nien khoa: " + tenNienKhoa);
            console.log("Ma NKHK: " + nkhk);
            document.getElementById("btnSaveNguoiKy").style.display = "none";
        }
        else {
            return;
        }

    });

    $('#table_NguoiKy').on('click', 'td.editor-delete', function () {
        if (canEdit) {
            var id = table_NguoiKy.cell(this, 0).data();
            swal({
                title: "Xác nhận",
                text: "Bạn có chắc chắn muốn xóa người ký này?",
                type: 'warning',
                buttons: true,
                dangerMode: true
            }).then((willDelete) => {
                if (willDelete) {
                    var row = table_NguoiKy.row(this);
                    $.ajax({
                        async: true,
                        type: 'POST',
                        data: { id: id },
                        url: '/nguoi-ky/delete',
                        success: function (response) {
                            response = $.parseJSON(response);
                            if (response.success == true) {
                                toastr.success("Xóa người ký thành công", "Thông báo", { timeOut: 3000 });
                                init_table_NguoiKy();
                            } else {
                                toastr.error(response.message, "Lỗi", { timeOut: 5000 });
                            }
                        }
                    });

                };
            });
        }
        else {
            return;
        }

    });
    // Open modal on page load
    $("#btnAddNguoiKy").click(function () {
        flagEdit = "";
        init_Select_NienKhoa();
        $('#select_ChucVu').select2({
            dropdownParent: $('#modalAddNguoiKy'),
        });
        $("#titleAddNguoiKy").html("Thêm người ký");
        document.getElementById("btnSaveNguoiKy").style.display = "inline";
        clearForm();
        $("#modalAddNguoiKy").modal('show');
    });

    // Close modal on button click
    $("#btnCloseNguoiKy").click(function () {
        $("#modalAddNguoiKy").modal('hide');
    });


});
function saveNguoiKy(close) {
    var hoTen = $("#hoTen").val();
    var kyHieu = $("#select_ChucVu").val();
    var chucVu = $('#select_ChucVu :selected').text();
    var nkhk = $("#select_HocKy").val();
    if (hoTen.toString().trim() == "") {
        $("#hoTen").focus();
        toastr.error("Vui lòng nhập họ tên", "Lỗi", { timeOut: 2500 });
        return;
    }
    var nguoiKy = {
        id: 0,
        HoTen: hoTen,
        KyHieu: kyHieu,
        ChucVu: chucVu,
        MaNKHK: nkhk
    };
    if (!flagEdit) {
        $.ajax({
            async: true,
            type: 'POST',
            data: { model: nguoiKy },
            url: '/nguoi-ky/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    // var ldltFull = { MaNguoiKy: maNguoiKyAdd, TenNguoiKy: tenNguoiKy, DonGia: donGia };
                    init_table_NguoiKy();
                    toastr.success("Thêm người ký thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddNguoiKy').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#hoTen").focus();
                        toastr.error(response.message, "Thêm người ký thất bại", { timeOut: 2500 });
                        return;
                    }
                    toastr.error(response.message, "Thêm người ký thất bại", { timeOut: 2500 });
                }
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }

        });
    }
    else {
        nguoiKy.id = table_NguoiKy.cell(row, 0).data();
      
        $.ajax({
            async: true,
            type: 'POST',
            data: { model: nguoiKy },
            url: '/nguoi-ky/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success("Chỉnh sửa người ký thành công", "Thông báo", { timeOut: 2500 });
                    row.data(response.data);
                    $('#modalAddNguoiKy').modal('hide');
                    flagEdit = false;
                    flagEditNKHK = false;
                    return;
                }
                else {
                    $("#hoTen").focus();
                    toastr.error(response.message, "Chỉnh sửa người ký thất bại: ", { timeOut: 2500 });
                    return;
                    
                   
                }
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }

        });
    }
}
function loading() {
    $.ajax({
        async: true,
        type: 'GET',
        data: "",
        url: '/loading/bac-hoc',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingNguoiKy").modal('show');
                setTimeout(function () {
                    $("#modalLoadingNguoiKy").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_NguoiKy(showAll) {
    table_NguoiKy = $("#table_NguoiKy").DataTable();
    table_NguoiKy.columns(0).visible(false);
    table_NguoiKy.columns(4).visible(false);
    table_NguoiKy.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { all: showAll },
        url: '/nguoi-ky/ds',
        success: function (response) {
            console.log(response);
            table_NguoiKy = $('#table_NguoiKy').DataTable({
                "drawCallback": function () {
                    $('.paginate_button.next', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddNguoiKy").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddNguoiKy").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                    $('.paginate_button', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddNguoiKy").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddNguoiKy").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                },
                "data": $.parseJSON(response).data,
                "columns": [
                    {
                        'data': 'id',
                        'visible': false,
                    },

                    {
                        'data': 'HoTen',
                    },
                    {
                        'data': 'ChucVu',
                    }, {
                        'data': 'NKHK'
                    },
                    {
                        'data': 'MaNKHK',
                        'visible': false,
                    }
                    ,
                    {
                        'targets': 5,
                        'className': "dt-center editor-edit",
                        'defaultContent': '<button class="edit"><i class="fa fa-pencil" aria-hidden="true"/></button>',
                        'orderable': false,
                        'searchable': false
                    },
                    {
                        'targets': 6,
                        'className': "dt-center editor-delete",
                        'defaultContent': '<button class="edit"><i class="fa fa-trash"/></button>',
                        'orderable': false,
                        'searchable': false
                    },
                     {
                        'data': 'MaChucVu',
                        'visible':false,

                    },
                    {
                        'data': 'TenNienKhoa',
                        'visible': false,

                    }
                ]
            }
            );
            var listBtnEditDelete = document.getElementsByClassName("edit");

            if (showAll == 1) {
                $("#btnAddNguoiKy").attr("disabled", "disabled");
                canEdit = false;
                $.each(listBtnEditDelete, function (i, item) {
                    item.setAttribute("disabled", "disabled");
                });
            }
            else {
                $("#btnAddNguoiKy").removeAttr("disabled");
                canEdit = true;
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function clearForm() {
    $("#hoTen").val(null);
    $("#select_ChucVu").prop("selectedIndex", 0);
    $('#select_ChucVu').trigger('change');
    $("#select_NienKhoa").prop("selectedIndex", 0);
    $('#select_NienKhoa').trigger('change');
}
function showAllNguoiKy() {
    var checkBox = document.getElementById("showAll");
    if (checkBox.checked == true) {
        document.getElementById("notify").style.display = "inline";
        init_table_NguoiKy(1);
    }
    else {
        document.getElementById("notify").style.display = "none";
        init_table_NguoiKy(0);
    }
}
////Onchange
function onChange_Select_NienKhoa(event) {
    tenNienKhoa = $("#select_NienKhoa option:selected").val();
    init_Select_HocKy();
    if (flagEdit && flagEditNKHK) {
        $("#select_HocKy").val(nkhk);
        $('#select_HocKy').trigger('change');
    }
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
            if (flagEdit && flagEditNKHK) {
                $("#select_HocKy").val(nkhk);
                $('#select_HocKy').trigger('change');
                flagEditNKHK = false;
            }
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
            $('#select_HocKy').trigger('change');
            init_Select_HocKy();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}