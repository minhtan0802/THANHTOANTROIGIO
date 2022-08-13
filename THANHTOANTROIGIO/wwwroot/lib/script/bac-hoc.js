var table_BacHoc_rowIndex = 0;
var maBacHoc = "";
var tenBacHoc = "";
var maBacHocEdit = "";
var table_BacHoc;
var row;
$(document).ready(function () {
   /* loading();*/
    init_table_BacHoc();
    $(document).on('shown.bs.modal', '#modalAddBacHoc', function () {
        $('#maBacHoc').focus();
    })
    document.getElementById("title").innerHTML = "bậc học";


    $('#table_BacHoc tbody').on('click', 'tr', function () {
        var index = table_BacHoc.row(this).index();
        if ($(this).hasClass('selected') && table_BacHoc_rowIndex != index) {
            $(this).removeClass('selected');
            table_BacHoc_rowIndex = index;
        }
        else {
            table_BacHoc.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_BacHoc_rowIndex = index;
        }
    });

    $('#table_BacHoc').on('click', 'td.editor-edit', function (e) {
        $("#titleAddMonHoc").html("Chỉnh sửa bậc học");
        row = table_BacHoc.row(this);
        maBacHoc = table_BacHoc.cell(this, 0).data().trim();
        var heSo = table_BacHoc.cell(this, 2).data();
        var tenBacHoc = table_BacHoc.cell(this, 1).data().trim();
        maBacHocEdit = maBacHoc;
        $('#maBacHoc').val(maBacHoc);
        $('#tenBacHoc').val(tenBacHoc);
        $('#heSo').val(heSo);
        $("#modalAddBacHoc").modal("show");
        $("#titleAddBacHoc").html("Chỉnh sửa bậc học");
        document.getElementById("btnSaveBacHoc").style.display = "none";
    });

    $('#table_BacHoc').on('click', 'td.editor-delete', function () {
        maBacHoc = table_BacHoc.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa bậc học này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_BacHoc.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maBac: maBacHoc },
                    url: '/bac-hoc/delete',
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
    $("#btnAddBacHoc").click(function () {
        maBacHocEdit = "";
        $("#titleAddBacHoc").html("Thêm bậc học");
        document.getElementById("btnSaveBacHoc").style.display = "inline";
        clearForm();
        $("#modalAddBacHoc").modal('show');
    });

    // Close modal on button click
    $("#btnCloseBacHoc").click(function () {
        $("#modalAddBacHoc").modal('hide');
    });


});
function saveBacHoc(close) {
    var maBacHocAdd = $("#maBacHoc").val().trim();
    var tenBacHoc = $("#tenBacHoc").val().trim();
    var heSo = $("#heSo").val();
    if (maBacHocAdd == "") {
        $("#maBacHoc").focus();
        toastr.error("Vui lòng nhập mã bậc học", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tenBacHoc == "") {
        $("#tenBacHoc").focus();
        toastr.error("Vui lòng nhập tên bậc học", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (heSo.toString() == "") {
        $("#heSo").focus();
        toastr.error("Vui lòng nhập hệ số", "Lỗi", { timeOut: 2500 });
        return;
    }

    var bacHoc = {
        MaBac: maBacHocAdd,
        TenBac: tenBacHoc,
    };
    if (maBacHocEdit == "") {
        $.ajax({
            async: true,
            type: 'POST',
            data: { bacHoc: bacHoc, heSo: heSo },
            url: '/bac-hoc/add',
            success: function (response) {
                if (response.success == true) {
                    var bacHocFull = { MaBac: maBacHocAdd, TenBac: tenBacHoc, HeSo: heSo };
                    table_BacHoc.row.add(bacHocFull).draw(false);
                    toastr.success("Thêm bậc học thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddBacHoc').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#maBacHoc").focus();
                        toastr.error("Mã bậc học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenBacHoc").focus();
                        toastr.error("Tên bậc học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Thêm bậc học thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
            data: { maBacHoc: maBacHoc, model: bacHoc, heSo: heSo },
            url: '/bac-hoc/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    var bacHocFull = { MaBac: maBacHocAdd, TenBac: tenBacHoc, HeSo: heSo, NgayApDung: response.data };
                    toastr.success("Chỉnh sửa bậc học thành công", "Thông báo", { timeOut: 2500 });
                    row.data(bacHocFull);
                    $('#modalAddBacHoc').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#maBacHoc").focus();
                        toastr.error("Mã bậc học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenBacHoc").focus();
                        toastr.error("Tên bậc học đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Chỉnh sửa bậc học thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
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
                $("#modalLoadingBacHoc").modal('show');
                setTimeout(function () {
                    $("#modalLoadingBacHoc").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_BacHoc(showAll) {
    table_BacHoc = $("#table_BacHoc").DataTable();
    table_BacHoc.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: {all:showAll},
        url: '/bac-hoc/ds-bac-hoc-full',
        success: function (response) {
            console.log(response);
            table_BacHoc = $('#table_BacHoc').DataTable({
                "data": $.parseJSON(response),
                "rowId": 'MaBac'.trim(),
                "columns": [{
                    'data': 'MaBac',
                },
                {
                    'data': 'TenBac',
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
                    'targets': 4,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button><i class="fa fa-pencil" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 5,
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
    $("#maBacHoc").val("");
    $("#tenBacHoc").val("");
    $("#heSo").val(null);
}
function showAllBacHoc() {
    var checkBox = document.getElementById("showAll");
    if (checkBox.checked == true) {
        init_table_BacHoc(1);
    }
    else {
        init_table_BacHoc(0);
    }
}