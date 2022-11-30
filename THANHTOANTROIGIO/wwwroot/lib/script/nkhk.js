var table_NKHK_rowIndex = 0;
var maNKHK = "";
var tenNKHK = "";
var flagEdit = false;
var table_NKHK;
var row;
var nkhk;
var flagEditNKHK = false;
$(document).ready(function () {
    /* loading();*/
    init_table_NKHK();
    // init_Select_NienKhoa();
    // init_Select_NKHK();
    $('#select_NKHK').select2({
        dropdownParent: $('#modalAddNKHK'),
    });
    $(document).on('shown.bs.modal', '#modalAddNKHK', function () {
        $('#hoTen').focus();
    })
    document.getElementById("title").innerHTML = "NGƯỜI KÝ";


    $('#table_NKHK tbody').on('click', 'tr', function () {
        var index = table_NKHK.row(this).index();
        if ($(this).hasClass('selected') && table_NKHK_rowIndex != index) {
            $(this).removeClass('selected');
            table_NKHK_rowIndex = index;
        }
        else {
            table_NKHK.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_NKHK_rowIndex = index;
        }
    });

    $('#table_NKHK').on('click', 'td.editor-edit', function (e) {
        if (canEdit) {
            $("#titleAddMonHoc").html("Chỉnh sửa Niên khóa học kỳ");
            row = table_NKHK.row(this);
            flagEdit = true;
            flagEditNKHK = true;
            var hoTen = table_NKHK.cell(this, 1).data();
            var chucVu = table_NKHK.cell(this, 2).data();
            nkhk = table_NKHK.cell(this, 4).data();
            var tenNienKhoa = table_NKHK.cell(this, 8).data();
            var maNKHK = table_NKHK.cell(this, 7).data();
            $('#hoTen').val(hoTen);
            $('#select_NKHK').val(maNKHK);
            $('#select_NKHK').trigger('change');

            $('#select_NienKhoa').val(tenNienKhoa);
            $('#select_NienKhoa').trigger('change');

            $("#select_HocKy").val(nkhk);
            $('#select_HocKy').trigger('change');

            $("#modalAddNKHK").modal("show");
            $("#titleAddNKHK").html("Chỉnh sửa Niên khóa học kỳ");

            console.log("Nien khoa: " + tenNienKhoa);
            console.log("Ma NKHK: " + nkhk);
            document.getElementById("btnSaveNKHK").style.display = "none";
        }
        else {
            return;
        }

    });

    $('#table_NKHK').on('click', 'td.editor-delete', function () {
        var MaNKHK = table_NKHK.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa Niên khóa học kỳ này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_NKHK.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { MaNKHK: MaNKHK },
                    url: '/nien-khoa-hoc-ky/delete',
                    success: function (response) {
                        response = $.parseJSON(response);
                        if (response.success == true) {
                            toastr.success("Xóa Niên khóa học kỳ thành công", "Thông báo", { timeOut: 3000 });
                            init_table_NKHK();
                        } else {
                            toastr.error(response.message, "Lỗi", { timeOut: 5000 });
                        }
                    }
                });

            };
        });

    });
    // Open modal on page load
    $("#btnAddNKHK").click(function () {
        flagEdit = "";
        //   init_Select_NienKhoa();
        $('#select_NKHK').select2({
            dropdownParent: $('#modalAddNKHK'),
        });
        $("#titleAddNKHK").html("Thêm Niên khóa học kỳ");
        //  document.getElementById("btnSaveNKHK").style.display = "inline";
        clearForm();
        $(document).on('shown.bs.modal', '#modalAddNKHK', function () {
            $('#tenNienKhoa').focus();
        })
        $.ajax({
            async: true,
            type: 'GET',
            data: "",
            url: '/nien-khoa-hoc-ky/goi-y',
            success: function (response) {
                var tenNienKhoa = $.parseJSON(response).TenNienKhoa;
                var hocKy = $.parseJSON(response).HocKy;
                $("#tenNienKhoa").val(tenNienKhoa);
                $("#select_HocKy").val(hocKy);
                $('#select_HocKy').trigger('change');
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }

        });

        $("#modalAddNKHK").modal('show');
    });

    // Close modal on button click
    $("#btnCloseNKHK").click(function () {
        $("#modalAddNKHK").modal('hide');
    });


});
function saveNKHK(close) {
    var tenNienKhoa = $("#tenNienKhoa").val();
    var hocKy = $('#select_HocKy :selected').text();
    if (tenNienKhoa.toString().trim() == "") {
        $("#tenNienKhoa").focus();
        toastr.error("Vui lòng nhập tên Niên khóa", "Lỗi", { timeOut: 2500 });
        return;
    }
    var model = {
        MaNKHK: 0,
        TenHocKy: hocKy,
        TenNienKhoa: tenNienKhoa
    };

    $.ajax({
        async: true,
        type: 'POST',
        data: { model: model },
        url: '/nien-khoa-hoc-ky/add',
        success: function (response) {
            response = $.parseJSON(response);
            if (response.success == true) {
                // var ldltFull = { MaNKHK: maNKHKAdd, TenNKHK: tenNKHK, DonGia: donGia };
                table_NKHK.row.add(response.data).draw(false);;
                toastr.success("Thêm Niên khóa học kỳ thành công", "Thông báo", { timeOut: 2500 });
                if (close) {
                    $('#modalAddNKHK').modal('hide');
                }
            }
            else {
                if (response.message == "pk") {
                    $("#tenNienKhoa").focus();
                    toastr.error(response.message, "Thêm Niên khóa học kỳ thất bại", { timeOut: 2500 });
                    return;
                }
                toastr.error(response.message, "Thêm Niên khóa học kỳ thất bại", { timeOut: 2500 });
            }
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
        url: '/loading/bac-hoc',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingNKHK").modal('show');
                setTimeout(function () {
                    $("#modalLoadingNKHK").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_NKHK() {
    table_NKHK = $("#table_NKHK").DataTable();
    table_NKHK.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: "",
        url: '/nien-khoa-hoc-ky/ds',
        success: function (response) {
            console.log(response);
            table_NKHK = $('#table_NKHK').DataTable({
                "drawCallback": function () {
                    $('.paginate_button.next', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            /*          if (showAll == 1) {
                                          $("#btnAddNKHK").attr("disabled", "disabled");
                                          canEdit = false;
                                          $.each(listBtnEditDelete, function (i, item) {
                                              item.setAttribute("disabled", "disabled");
                                          });
                                      }
                                      else {
                                          $("#btnAddNKHK").removeAttr("disabled");
                                          canEdit = true;
                                      }*/
                        });
                    $('.paginate_button', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddNKHK").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddNKHK").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                },
                "data": $.parseJSON(response).data,
                "columns": [
                    {
                        'data': 'MaNKHK',
                    },

                    {
                        'data': 'TenNienKhoa',
                    },
                    {
                        'data': 'TenHocKy',
                    }
                    ,
                    {
                        'targets': 3,
                        'className': "dt-center editor-delete",
                        'defaultContent': '<button class="edit"><i class="fa fa-trash"/></button>',
                        'orderable': false,
                        'searchable': false,
                    }
                ]
            }
            );
            var listBtnEditDelete = document.getElementsByClassName("edit");

            /*   if (showAll == 1) {
                   $("#btnAddNKHK").attr("disabled", "disabled");
                   canEdit = false;
                   $.each(listBtnEditDelete, function (i, item) {
                       item.setAttribute("disabled", "disabled");
                   });
               }
               else {
                   $("#btnAddNKHK").removeAttr("disabled");
                   canEdit = true;
               }*/
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function clearForm() {
    $("#hoTen").val(null);
    $("#select_NKHK").prop("selectedIndex", 0);
    $('#select_NKHK').trigger('change');
    $("#select_NienKhoa").prop("selectedIndex", 0);
    $('#select_NienKhoa').trigger('change');
}
function showAllNKHK() {
    var checkBox = document.getElementById("showAll");
    if (checkBox.checked == true) {
        document.getElementById("notify").style.display = "inline";
        init_table_NKHK(1);
    }
    else {
        document.getElementById("notify").style.display = "none";
        init_table_NKHK(0);
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
/*function init_Select_HocKy() {
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
}*/
/*function init_Select_NienKhoa() {
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
*//*}*//*
function init_Select_NKHK() {
    $("#select_NKHK").empty();
    $.ajax({
        async: true,
        type: 'GET',
        data: "",
        url: '/nien-khoa-hoc-ky/ds-chuc-vu',
        success: function (response) {
            console.log(response);
            response = $.parseJSON(response);
     
            $.each(response, function (i, item) {
                $('#select_NKHK').append($('<option>', {
                    value: item.MaNKHK,
                    text: item.TenNKHK
                }));
            });
            $("#select_NKHK").prop("selectedIndex", 0);
            $('#select_NKHK').trigger('change');
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}*/