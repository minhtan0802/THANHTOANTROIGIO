var table_ChucVu_rowIndex = 0;
var maChucVu = "";
var tenChucVu = "";
var maChucVuEdit = "";
var table_ChucVu;
var row;
$(document).ready(function () {
    table_ChucVu = $("#table_ChucVu").DataTable();
    init_table_ChucVu();
    $(document).on('shown.bs.modal', '#modalAddChucVu', function () {
        $('#maChucVu').focus();
    })
     document.getElementById("title").innerHTML = "Chức vụ";
   
    
    $('#table_ChucVu tbody').on('click', 'tr', function () {
        var index = table_ChucVu.row(this).index();
        if ($(this).hasClass('selected') && table_ChucVu_rowIndex != index) {
            $(this).removeClass('selected');
            table_ChucVu_rowIndex = index;
        }
        else {
            table_ChucVu.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_ChucVu_rowIndex = index;
        }
    });

    $('#table_ChucVu').on('click', 'td.editor-edit', function (e) {
        $("#titleAddMonHoc").html("Chỉnh sửa chức vụ");
        row = table_ChucVu.row(this);
        maChucVu = table_ChucVu.cell(this, 0).data().trim();
        var dinhMucGiam = table_ChucVu.cell(this, 2).data();
        var tenChucVu = table_ChucVu.cell(this, 1).data().trim();
        maChucVuEdit = maChucVu;
        $('#maChucVu').val(maChucVu);
        $('#tenChucVu').val(tenChucVu);
        $('#dinhMucGiam').val(dinhMucGiam);
        $("#modalAddChucVu").modal("show");
        $("#titleAddChucVu").html("Chỉnh sửa chức vụ");
        document.getElementById("btnSaveChucVu").style.display = "none";
    });

    $('#table_ChucVu').on('click', 'td.editor-delete', function () {
        maChucVu = table_ChucVu.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa chức vụ này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_ChucVu.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maChucVu: maChucVu },
                    url: '/chuc-vu/delete',
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
    // Open modal on page load
    $("#btnAddChucVu").click(function () {
        maChucVuEdit = "";
        $("#titleAddChucVu").html("Thêm chức vụ");
        document.getElementById("btnSaveChucVu").style.display = "inline";
        clearForm();
        $("#modalAddChucVu").modal('show');
    });

    // Close modal on button click
    $("#btnCloseChucVu").click(function () {
        $("#modalAddChucVu").modal('hide');
    });

  
});
function saveChucVu(close) {
    var maChucVuAdd = $("#maChucVu").val().trim();
    var tenChucVu = $("#tenChucVu").val().trim();
    var dinhMucGiam = $("#dinhMucGiam").val();
    if (maChucVuAdd == "") {
        $("#maChucVu").focus();
        toastr.error("Vui lòng nhập mã chức vụ", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tenChucVu == "") {
        $("#tenChucVu").focus();
        toastr.error("Vui lòng nhập tên chức vụ", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (dinhMucGiam.toString() == "") {
        $("#dinhMucGiam").focus();
        toastr.error("Vui lòng nhập định mức giảm", "Lỗi", { timeOut: 2500 });
        return;
    }

    var chucVu = {
        MaChucVu: maChucVuAdd,
        TenChucVu: tenChucVu,
        DinhMucGiam: dinhMucGiam
    };
    if (maChucVuEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: chucVu,
            url: '/chuc-vu/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    table_ChucVu.row.add(response.data).draw(false);
                    toastr.success("Thêm chức vụ thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddChucVu').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#maChucVu").focus();
                        toastr.error("Mã chức vụ đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenChucVu").focus();
                        toastr.error("Tên chức vụ đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Thêm chức vụ thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
            data: { maChucVu: maChucVu, model: chucVu },
            url: '/chuc-vu/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success("Chỉnh sửa chức vụ thành công", "Thông báo", { timeOut: 2500 });
                    //  init_table_ChucVu();
                    row.data(response.data);
                    $('#modalAddChucVu').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#maChucVu").focus();
                        toastr.error("Mã chức vụ đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenChucVu").focus();
                        toastr.error("Tên chức vụ đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Chỉnh sửa chức vụ thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
        url: '/loading/chuc-vu',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingChucVu").modal('show');
                setTimeout(function () {
                    $("#modalLoadingChucVu").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_ChucVu() {
    table_ChucVu.destroy();
    $.ajax({
        async: false,
        type: 'POST',
        data: "",
        url: '/chuc-vu/ds-chuc-vu',
        success: function (response) {
            console.log(response);
            table_ChucVu = $('#table_ChucVu').DataTable({
                "data": $.parseJSON(response),
                "rowId": 'MaChucVu'.trim(),
                "columns": [{
                    'data': 'MaChucVu',
                },
                {
                    'data': 'TenChucVu',
                    }, {
                        'data': 'DinhMucGiam',
                    },
               {
                    'targets': 3,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button><i class="fa fa-pencil" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 4,
                    'className': "dt-center editor-delete",
                    'defaultContent': '<button><i class="fa fa-trash"/></button>',
                    'orderable': false,
                    'searchable': false
                }
                ]
            }
            );

        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function clearForm() {
    $("#maChucVu").val("");
    $("#tenChucVu").val("");
    $("#dinhMucGiam").val(null);
}