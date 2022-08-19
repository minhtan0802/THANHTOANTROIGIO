var table_HocVi_rowIndex = 0;
var maHocVi = "";
var tenHocVi = "";
var maHocViEdit = "";
var table_HocVi;
var row;
$(document).ready(function () {
    /* loading();*/
    init_table_HocVi();
    $(document).on('shown.bs.modal', '#modalAddHocVi', function () {
        $('#maHocVi').focus();
    })
    document.getElementById("title").innerHTML = "HỌC VỊ";


    $('#table_HocVi tbody').on('click', 'tr', function () {
        var index = table_HocVi.row(this).index();
        if ($(this).hasClass('selected') && table_HocVi_rowIndex != index) {
            $(this).removeClass('selected');
            table_HocVi_rowIndex = index;
        }
        else {
            table_HocVi.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_HocVi_rowIndex = index;
        }
    });

    $('#table_HocVi').on('click', 'td.editor-edit', function (e) {
        if (canEdit) {
            $("#titleAddMonHoc").html("Chỉnh sửa học vị");
            row = table_HocVi.row(this);
            maHocVi = table_HocVi.cell(this, 0).data().trim();
            var donGia = table_HocVi.cell(this, 2).data();
            var tenHocVi = table_HocVi.cell(this, 1).data().trim();
            maHocViEdit = maHocVi;
            $('#maHocVi').val(maHocVi);
            $('#tenHocVi').val(tenHocVi);
            $('#donGia').val(donGia);
            $("#modalAddHocVi").modal("show");
            $("#titleAddHocVi").html("Chỉnh sửa học vị");
            document.getElementById("btnSaveHocVi").style.display = "none";
        }
        else {
            return;
        }

    });

    $('#table_HocVi').on('click', 'td.editor-delete', function () {
        if (canEdit) {
            maHocVi = table_HocVi.cell(this, 0).data();
            swal({
                title: "Xác nhận",
                text: "Bạn có chắc chắn muốn xóa học vị này?",
                type: 'warning',
                buttons: true,
                dangerMode: true
            }).then((willDelete) => {
                if (willDelete) {
                    var row = table_HocVi.row(this);
                    $.ajax({
                        async: true,
                        type: 'POST',
                        data: { maHocVi: maHocVi },
                        url: '/hoc-vi/delete',
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
        }
        else {
            return;
        }
      
    });
    // Open modal on page load
    $("#btnAddHocVi").click(function () {
        maHocViEdit = "";
        $("#titleAddHocVi").html("Thêm học vị");
        document.getElementById("btnSaveHocVi").style.display = "inline";
        clearForm();
        $("#modalAddHocVi").modal('show');
    });

    // Close modal on button click
    $("#btnCloseHocVi").click(function () {
        $("#modalAddHocVi").modal('hide');
    });


});
function saveHocVi(close) {
    var maHocViAdd = $("#maHocVi").val().trim();
    var tenHocVi = $("#tenHocVi").val().trim();
    var donGia = $("#donGia").val();
    if (maHocViAdd == "") {
        $("#maHocVi").focus();
        toastr.error("Vui lòng nhập mã học vị", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tenHocVi == "") {
        $("#tenHocVi").focus();
        toastr.error("Vui lòng nhập tên học vị", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (donGia.toString() == "") {
        $("#donGia").focus();
        toastr.error("Vui lòng nhập đơn giá", "Lỗi", { timeOut: 2500 });
        return;
    }

    var hocVi = {
        MaHocVi: maHocViAdd,
        TenHocVi: tenHocVi,
        DonGia: donGia
    };
    if (maHocViEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: { model: hocVi },
            url: '/hoc-vi/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    // var hocViFull = { MaHocVi: maHocViAdd, TenHocVi: tenHocVi, DonGia: donGia };
                    table_HocVi.row.add(response.data).draw(false);
                    toastr.success("Thêm học vị thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddHocVi').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#maHocVi").focus();
                        toastr.error("Mã học vị đã tồn tại", "Thêm học vị thất bại", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenHocVi").focus();
                        toastr.error("Tên học vị đã tồn tại", "Thêm học vị thất bại", { timeOut: 2500 });
                        return;
                    }
                    toastr.error(response.message, "Thêm học vị thất bại", { timeOut: 2500 });
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
            data: { maHocVi: maHocViEdit, model: hocVi },
            url: '/hoc-vi/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success("Chỉnh sửa học vị thành công", "Thông báo", { timeOut: 2500 });
                    row.data(response.data);
                    $('#modalAddHocVi').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#maHocVi").focus();
                        toastr.error("Mã học vị đã tồn tại", "Chỉnh sửa học vị thất bại: ", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenHocVi").focus();
                        toastr.error("Tên học vị đã tồn tại", "Chỉnh sửa học vị thất bại: ", { timeOut: 2500 });
                        return;
                    }
                    toastr.error(response.message, "Chỉnh sửa học vị thất bại: ", { timeOut: 2500 });
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
                $("#modalLoadingHocVi").modal('show');
                setTimeout(function () {
                    $("#modalLoadingHocVi").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_HocVi(showAll) {
    table_HocVi = $("#table_HocVi").DataTable();
    table_HocVi.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { all: showAll },
        url: '/hoc-vi/quan-ly-hoc-vi',
        success: function (response) {
            console.log(response);
            table_HocVi = $('#table_HocVi').DataTable({
                "drawCallback": function () {
                    $('.paginate_button.next', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddHocVi").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddHocVi").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                    $('.paginate_button', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddHocVi").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddHocVi").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                },
                "data": $.parseJSON(response).data,
                "rowId": 'MaHocVi'.trim(),
                "columns": [{
                    'data': 'MaHocVi',
                },
                {
                    'data': 'TenHocVi',
                }, {
                    'data': 'DonGia',
                    'render': function (data, type, row) {
                        var ret = data.toLocaleString('it-IT', { style: 'currency', currency: 'VND' });
                        return ret;
                    }
                },
                {
                    'data': 'MaNKHK'
                },
                {
                    'data': 'GVDieuChinh'

                },
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
                }
                ]
            }
            );
            var listBtnEditDelete = document.getElementsByClassName("edit");

            if (showAll == 1) {
                $("#btnAddHocVi").attr("disabled", "disabled");
                canEdit = false;
                $.each(listBtnEditDelete, function (i, item) {
                    item.setAttribute("disabled", "disabled");
                });
            }
            else {
                $("#btnAddHocVi").removeAttr("disabled");
                canEdit = true;
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function clearForm() {
    $("#maHocVi").val("");
    $("#tenHocVi").val("");
    $("#donGia").val(null);
}
function showAllHocVi() {
    var checkBox = document.getElementById("showAll");
    if (checkBox.checked == true) {
        document.getElementById("notify").style.display = "inline";
        init_table_HocVi(1);
    }
    else {
        document.getElementById("notify").style.display = "none";
        init_table_HocVi(0);
    }
}