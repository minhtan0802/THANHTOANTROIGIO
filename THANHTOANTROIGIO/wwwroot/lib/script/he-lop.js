var table_HeLop_rowIndex = 0;
var maHeLop = "";
var tenHeLop = "";
var maHeLopEdit = "";
var table_HeLop;
var row;
$(document).ready(function () {
    /* loading();*/
    init_table_HeLop();
    $(document).on('shown.bs.modal', '#modalAddHeLop', function () {
        $('#maHeLop').focus();
    })
    document.getElementById("title").innerHTML = "HỆ LỚP";


    $('#table_HeLop tbody').on('click', 'tr', function () {
        var index = table_HeLop.row(this).index();
        if ($(this).hasClass('selected') && table_HeLop_rowIndex != index) {
            $(this).removeClass('selected');
            table_HeLop_rowIndex = index;
        }
        else {
            table_HeLop.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_HeLop_rowIndex = index;
        }
    });

    $('#table_HeLop').on('click', 'td.editor-edit', function (e) {
        if (canEdit) {
            $("#titleAddMonHoc").html("Chỉnh sửa hệ lớp");
            row = table_HeLop.row(this);
            maHeLop = table_HeLop.cell(this, 0).data().trim();
            var heSo = table_HeLop.cell(this, 2).data();
            var tenHeLop = table_HeLop.cell(this, 1).data().trim();
            maHeLopEdit = maHeLop;
            $('#maHeLop').val(maHeLop);
            $('#tenHeLop').val(tenHeLop);
            $('#heSo').val(heSo);
            $("#modalAddHeLop").modal("show");
            $("#titleAddHeLop").html("Chỉnh sửa hệ lớp");
            document.getElementById("btnSaveHeLop").style.display = "none";
        }
        else {
            return;
        }

    });

    $('#table_HeLop').on('click', 'td.editor-delete', function () {
        if (canEdit) {
            maHeLop = table_HeLop.cell(this, 0).data();
            swal({
                title: "Xác nhận",
                text: "Bạn có chắc chắn muốn xóa hệ lớp này?",
                type: 'warning',
                buttons: true,
                dangerMode: true
            }).then((willDelete) => {
                if (willDelete) {
                    var row = table_HeLop.row(this);
                    $.ajax({
                        async: true,
                        type: 'POST',
                        data: { maHeLop: maHeLop },
                        url: '/he-lop/delete',
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
    $("#btnAddHeLop").click(function () {
        maHeLopEdit = "";
        $("#titleAddHeLop").html("Thêm hệ lớp");
        document.getElementById("btnSaveHeLop").style.display = "inline";
        clearForm();
        $("#modalAddHeLop").modal('show');
    });

    // Close modal on button click
    $("#btnCloseHeLop").click(function () {
        $("#modalAddHeLop").modal('hide');
    });


});
function saveHeLop(close) {
    var maHeLopAdd = $("#maHeLop").val().trim();
    var tenHeLop = $("#tenHeLop").val().trim();
    var heSo = $("#heSo").val();
    if (maHeLopAdd == "") {
        $("#maHeLop").focus();
        toastr.error("Vui lòng nhập mã hệ lớp", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tenHeLop == "") {
        $("#tenHeLop").focus();
        toastr.error("Vui lòng nhập tên hệ lớp", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (heSo.toString() == "") {
        $("#heSo").focus();
        toastr.error("Vui lòng nhập hệ số", "Lỗi", { timeOut: 2500 });
        return;
    }

    var heLop = {
        MaHeLop: maHeLopAdd,
        TenHeLop: tenHeLop,
    };
    if (maHeLopEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: { heLop: heLop, heSo: heSo },
            url: '/he-lop/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    table_HeLop.row.add(response.data).draw(false);
                    toastr.success("Thêm hệ lớp thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddHeLop').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#maHeLop").focus();
                        toastr.error("Mã hệ lớp đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenHeLop").focus();
                        toastr.error("Tên hệ lớp đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Thêm hệ lớp thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
            data: { maHeLop: maHeLop, model: heLop, heSo: heSo },
            url: '/he-lop/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    //   var heLopFull = { MaHeLop: maHeLopAdd, TenHeLop: tenHeLop, HeSo: heSo, NgayApDung: response.data };
                    toastr.success("Chỉnh sửa hệ lớp thành công", "Thông báo", { timeOut: 2500 });
                    row.data(response.data);
                    $('#modalAddHeLop').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#maHeLop").focus();
                        toastr.error("Mã hệ lớp đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenHeLop").focus();
                        toastr.error("Tên hệ lớp đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Chỉnh sửa hệ lớp thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
        url: '/loading/he-lop',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingHeLop").modal('show');
                setTimeout(function () {
                    $("#modalLoadingHeLop").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_HeLop(showAll) {
    table_HeLop = $("#table_HeLop").DataTable();
    table_HeLop.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { all: showAll },
        url: '/he-lop/ds-he-lop-full',
        success: function (response) {
            console.log(response);
            table_HeLop = $('#table_HeLop').DataTable({
                "drawCallback": function () {
                    $('.paginate_button.next', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddHeLop").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddHeLop").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                    $('.paginate_button', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddHeLop").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddHeLop").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                },
                "data": $.parseJSON(response),
                "rowId": 'MaHeLop'.trim(),
                "columns": [{
                    'data': 'MaHeLop',
                },
                {
                    'data': 'TenHeLop',
                }, {
                    'data': 'HeSo',
                },
                {
                    'data': 'NgayApDung',
                    'render': function (data, type, row) {
                        var date = data.split('T')[0];
                        var ngayApDung = date.split("-");
                        var ret = ngayApDung[2] + "/" + ngayApDung[1] + "/" + ngayApDung[0];
                        return ret;
                    }
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
                $("#btnAddHeLop").attr("disabled", "disabled");
                canEdit = false;
                $.each(listBtnEditDelete, function (i, item) {
                    item.setAttribute("disabled", "disabled");
                });
            }
            else {
                $("#btnAddHeLop").removeAttr("disabled");
                canEdit = true;
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function clearForm() {
    $("#maHeLop").val("");
    $("#tenHeLop").val("");
    $("#heSo").val(null);
}
function showAllHeLop() {
    var checkBox = document.getElementById("showAll");
    if (checkBox.checked == true) {
        document.getElementById("notify").style.display = "inline";
        init_table_HeLop(1);
    }
    else {
        document.getElementById("notify").style.display = "none";
        init_table_HeLop(0);
    }
}