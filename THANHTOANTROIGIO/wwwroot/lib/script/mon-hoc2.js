var table_MonHoc_rowIndex = 0;
var maMonHoc = "";
var tenMonHoc = "";
var maMonHocEdit = "";
var table_Khoa, table_MonHoc;
var row;
$(document).ready(function () {
    table_MonHoc = $("#table_MonHoc").DataTable();
   /* loading();*/
    $(document).on('shown.bs.modal', '#modalAddMonHoc', function () {
        $('#maMonHoc').focus();
    })
     document.getElementById("title").innerHTML = "Môn học";
   
    init_Table_MonHoc();
    $('#table_MonHoc tbody').on('click', 'tr', function () {
        var index = table_MonHoc.row(this).index();
        if ($(this).hasClass('selected') && table_MonHoc_rowIndex != index) {
            $(this).removeClass('selected');
            table_MonHoc_rowIndex = index;
        }
        else {
            table_MonHoc.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_MonHoc_rowIndex = index;
        }
    });

    $('#table_MonHoc').on('click', 'td.editor-edit', function (e) {
        $("#titleAddMonHoc").html("Chỉnh sửa môn học");
        row = table_MonHoc.row(this);
        maMonHoc = table_MonHoc.cell(this, 0).data().trim();
        var tietLT = table_MonHoc.cell(this, 2).data();
        var tietBT = table_MonHoc.cell(this, 3).data();
        var tietTH = table_MonHoc.cell(this, 4).data();
        var tenMonHoc = table_MonHoc.cell(this, 1).data().trim();
        maMonHocEdit = maMonHoc;
        $('#maMonHoc').val(maMonHoc);
        $('#tenMonHoc').val(tenMonHoc);
        $('#tietLT').val(tietLT);
        $('#tietBT').val(tietBT);
        $('#tietTH').val(tietTH);
        $("#modalAddMonHoc").modal("show");
        $("#titleAddBoMon").html("Chỉnh sửa môn học");
        document.getElementById("btnSaveMonHoc").style.display = "none";
    });

    $('#table_MonHoc').on('click', 'td.editor-delete', function () {
        maMonHoc = table_MonHoc.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa chức vụ này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_MonHoc.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maMonHoc: maMonHoc },
                    url: '/mon-hoc/delete',
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
    $("#btnAddMonHoc").click(function () {
        maMonHocEdit = "";
        $("#titleAddBoMon").html("Thêm môn học");
        document.getElementById("btnSaveMonHoc").style.display = "inline";
        clearForm();
        $("#modalAddMonHoc").modal('show');
    });

    // Close modal on button click
    $("#btnCloseMonHoc").click(function () {
        $("#modalAddMonHoc").modal('hide');
    });

  
});
function saveMonHoc(close) {
    var maMonHocAdd = $("#maMonHoc").val().trim();
    var tenMonHoc = $("#tenMonHoc").val().trim();
    var tietLT = $("#tietLT").val();
    var tietBT = $("#tietBT").val();
    var tietTH = $("#tietTH").val();
    if (maMonHocAdd == "") {
        $("#maMonHoc").focus();
        toastr.error("Vui lòng nhập mã môn học", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tenMonHoc == "") {
        $("#tenMonHoc").focus();
        toastr.error("Vui lòng nhập tên môn học", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tietLT.toString() == "") {
        $("#tietLT").focus();
        toastr.error("Vui lòng nhập số tiết lý thuyết", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tietBT.toString() == "") {
        $("#tietBT").focus();
        toastr.error("Vui lòng nhập số tiết bài tập", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tietTH.toString() == "") {
        $("#tietTH").focus();
        toastr.error("Vui lòng nhập số tiết thực hành", "Lỗi", { timeOut: 2500 });
        return;
    }
    var monHoc = {
        MaMonHoc: maMonHocAdd,
        TenMonHoc: tenMonHoc,
        TietLT: tietLT,
        TietBT: tietBT,
        TietTH: tietTH
    };
    if (maMonHocEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: monHoc,
            url: '/mon-hoc/add',
            success: function (response) {
                if (response.success == true) {
                    table_MonHoc.row.add(monHoc).draw(false);
                    toastr.success("Thêm môn học thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddMonHoc').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#maMonHoc").focus();
                        toastr.error("Mã môn học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenMonHoc").focus();
                        toastr.error("Tên môn học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Thêm môn học thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
            data: { maMonHoc: maMonHoc, model: monHoc },
            url: '/mon-hoc/edit',
            success: function (response) {
                if (response.success == true) {
                    toastr.success("Chỉnh sửa môn học thành công", "Thông báo", { timeOut: 2500 });
                    //  init_table_MonHoc();
                    console.log("Mon hoc: " + JSON.stringify(monHoc));
                    row.data(monHoc);
                    $('#modalAddMonHoc').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#maMonHoc").focus();
                        toastr.error("Mã môn học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenMonHoc").focus();
                        toastr.error("Tên môn học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Thêm môn học thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
        url: '/loading/mon-hoc',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingMonHoc").modal('show');
                setTimeout(function () {
                    $("#modalLoadingMonHoc").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Table_MonHoc() {
    table_MonHoc.destroy();
    $.ajax({
        async: false,
        type: 'POST',
        data: "",
        url: '/mon-hoc/ds-mon-hoc',
        success: function (response) {
            console.log(response);
            table_MonHoc = $('#table_MonHoc').DataTable({
                "data": $.parseJSON(response),
                "rowId": 'MaMonHoc'.trim(),
                "columns": [{
                    'data': 'MaMonHoc',
                },
                {
                    'data': 'TenMonHoc',
                }, {
                    'data': 'TietLT',
                }, {
                    'data': 'TietBT',
                }, {
                    'data': 'TietTH',
                }, {
                    'targets': 5,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button><i class="fa fa-pencil" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 6,
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
    $("#maMonHoc").val("");
    $("#tenMonHoc").val("");
    $("#tietLT").val(null);
    $("#tietBT").val(null);
    $("#tietTH").val(null);
}