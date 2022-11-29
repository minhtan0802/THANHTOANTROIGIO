var table_Khoa_rowIndex = 0;
var maKhoa = "";
var tenKhoa = "";
var maKhoaEdit = "";
var table_Khoa;
var row;
$(document).ready(function () {
    table_Khoa = $("#table_Khoa").DataTable();
    init_table_Khoa();
 /*   loading();*/
    $(document).on('shown.bs.modal', '#modalAddKhoa', function () {
        $('#maKhoa').focus();
    })
     document.getElementById("title").innerHTML = "Khoa";
   
    
    $('#table_Khoa tbody').on('click', 'tr', function () {
        var index = table_Khoa.row(this).index();
        if ($(this).hasClass('selected') && table_Khoa_rowIndex != index) {
            $(this).removeClass('selected');
            table_Khoa_rowIndex = index;
        }
        else {
            table_Khoa.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_Khoa_rowIndex = index;
        }
    });

    $('#table_Khoa').on('click', 'td.editor-edit', function (e) {
        $("#titleAddKhoa").html("Chỉnh sửa khoa");
        row = table_Khoa.row(this);
        maKhoa = table_Khoa.cell(this, 0).data().trim();
        var dinhMucGiam = table_Khoa.cell(this, 2).data();
        var tenKhoa = table_Khoa.cell(this, 1).data().trim();
        maKhoaEdit = maKhoa;
        $('#maKhoa').val(maKhoa);
        $('#tenKhoa').val(tenKhoa);
        $('#dinhMucGiam').val(dinhMucGiam);
        $("#modalAddKhoa").modal("show");
        $("#titleAddKhoa").html("Chỉnh sửa khoa");
        document.getElementById("btnSaveKhoa").style.display = "none";
    });

    $('#table_Khoa').on('click', 'td.editor-delete', function () {
        maKhoa = table_Khoa.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa khoa này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_Khoa.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maKhoa: maKhoa },
                    url: '/khoa/delete',
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
    $("#btnAddKhoa").click(function () {
        maKhoaEdit = "";
        $("#titleAddKhoa").html("Thêm khoa");
        document.getElementById("btnSaveKhoa").style.display = "inline";
        clearForm();
        $("#modalAddKhoa").modal('show');
    });

    // Close modal on button click
    $("#btnCloseKhoa").click(function () {
        $("#modalAddKhoa").modal('hide');
    });

  
});
function saveKhoa(close) {
    var maKhoaAdd = $("#maKhoa").val().trim();
    var tenKhoa = $("#tenKhoa").val().trim();
    var dinhMucGiam = $("#dinhMucGiam").val();
    if (maKhoaAdd == "") {
        $("#maKhoa").focus();
        toastr.error("Vui lòng nhập mã khoa", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tenKhoa == "") {
        $("#tenKhoa").focus();
        toastr.error("Vui lòng nhập tên khoa", "Lỗi", { timeOut: 2500 });
        return;
    }

    var chucVu = {
        MaKhoa: maKhoaAdd,
        TenKhoa: tenKhoa,
        DinhMucGiam: dinhMucGiam
    };
    if (maKhoaEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: chucVu,
            url: '/khoa/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    table_Khoa.row.add(response.data).draw(false);
                    toastr.success("Thêm khoa thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddKhoa').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#maKhoa").focus();
                        toastr.error("Mã khoa đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenKhoa").focus();
                        toastr.error("Tên khoa đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Thêm khoa thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
            data: { maKhoa: maKhoa, model: chucVu },
            url: '/khoa/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success("Chỉnh sửa khoa thành công", "Thông báo", { timeOut: 2500 });
                    //  init_table_Khoa();
                    row.data(response.data);
                    $('#modalAddKhoa').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#maKhoa").focus();
                        toastr.error("Mã khoa đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenKhoa").focus();
                        toastr.error("Tên khoa đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Chỉnh sửa khoa thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
                }
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }

        });
    }
}
function init_table_Khoa() {
    table_Khoa.destroy();
    $.ajax({
        async: false,
        type: 'GET',
        data: "",
        url: '/khoa/ds-khoa',
        success: function (response) {
            console.log(response);
            table_Khoa = $('#table_Khoa').DataTable({
                "data": $.parseJSON(response),
                "rowId": 'MaKhoa'.trim(),
                "columns": [{
                    'data': 'MaKhoa',
                },
                {
                    'data': 'TenKhoa',
                    }, 
               {
                    'targets': 2,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button><i class="fa fa-pencil" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 3,
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
    $("#maKhoa").val("");
    $("#tenKhoa").val("");
}