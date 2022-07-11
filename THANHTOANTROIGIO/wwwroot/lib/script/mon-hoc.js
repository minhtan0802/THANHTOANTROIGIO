var table_MonHoc_rowIndex = 0;
var maMonHoc = "";
var tenMonHoc = "";
var maMonHocEdit = "";
var table_Khoa, table_MonHoc;
$(document).ready(function () {
    loading();
    $(document).on('shown.bs.modal', '#modalAddMonHoc', function () {
        $('#maMonHoc').focus();
    })
    /* document.getElementById("title").innerHTML = "Nhập dữ liệu - BỘ MÔN";*/
    table_MonHoc=$("#table_MonHoc").DataTable();
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

/*    $('#table_MonHoc').on('click', 'td.editor-edit', function (e) {
        $("#titleAddBoMon").html("Chỉnh sửa bộ môn");
        maMonHoc = table_MonHoc.cell(this, 0).data().trim();
        var tenMonHoc = table_MonHoc.cell(this, 1).data().trim();
        maMonHocEdit = maBoMon;
        $('#maMonHoc').val(maBoMon);
        $('#tenBoMon').val(tenBoMon);
        $("#modalAddMonHoc").modal("show");
    });*/

    $('#table_MonHoc').on('click', 'td.editor-delete', function () {
        maBoMon = table_MonHoc.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa môn học này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_MonHoc.row(this);
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: { maBoMon: maBoMon },
                    url: '/bo-mon/delete',
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
        $("#titleAddBoMon").html("Thêm bộ môn");
        $("#modalAddMonHoc").modal('show');
    });

    // Close modal on button click
    $("#btnCloseBoMon").click(function () {
        $("#modalAddMonHoc").modal('hide');
    });
    $("#btnSaveBoMon").click(function (e) {
        if (maBoMonEdit != "") {
            editBoMon();
            return;
        }
        var maBoMon = $("#maMonHoc").val().trim();
        var tenBoMon = $("#tenBoMon").val().trim();
        if (maBoMon == "") {
            $("#maMonHoc").focus();
            toastr.error("Vui lòng nhập mã bộ môn", "Lỗi", { timeOut: 2500 });
            return;
        }
        if (tenBoMon == "") {
            $("#tenBoMon").focus();
            toastr.error("Vui lòng nhập tên bộ môn", "Lỗi", { timeOut: 2500 });
            return;
        }
        var boMon = {
            MaBoMon: maBoMon,
            TenBoMon: tenBoMon,
            MaKhoa: maKhoa
        };
        $.ajax({
            async: true,
            type: 'POST',
            data: boMon,
            url: '/bo-mon/add',
            success: function (response) {
                if (response.success == true) {
                    console.log("Bộ môn: " + boMon);
                    table_MonHoc.row.add([boMon.MaBoMon, boMon.TenBoMon]).draw(false);
                    toastr.success("Thêm bộ môn thành công", "Thông báo", { timeOut: 2500 });
                    $('#modalAddMonHoc').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#maMonHoc").focus();
                        toastr.error("Mã bộ môn đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    if (response.message == "name") {
                        $("#tenBoMon").focus();
                        toastr.error("Tên bộ môn đã tồn tại", "Lỗi", { timeOut: 2500 });
                        return;
                    }
                    toastr.error("Thêm bộ môn thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
                }
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }

        });
    });
});
/*function editBoMon() {
    var maBoMonEdit = $("#maMonHoc").val().trim();
    var tenBoMon = $("#tenBoMon").val().trim();
    if (maBoMonEdit == "") {
        $("#maMonHoc").focus();
        toastr.error("Vui lòng nhập mã bộ môn", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (tenBoMon == "") {
        $("#tenBoMon").focus();
        toastr.error("Vui lòng nhập tên bộ môn", "Lỗi", { timeOut: 2500 });
        return;
    }
    var boMon = {
        MaBoMon: maBoMonEdit,
        TenBoMon: tenBoMon,
        MaKhoa: maKhoa
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: { maBoMon: maBoMon, model: boMon },
        url: '/bo-mon/edit',
        success: function (response) {
            if (response.success == true) {
                toastr.success("Chỉnh sửa bộ môn thành công", "Thông báo", { timeOut: 2500 });
              //  init_table_MonHoc();
                table_MonHoc.cell(this, 0).data(boMon.MaBoMon);
                table_MonHoc.cell(this, 1).data(boMon.TenBoMon);
                $('#modalAddMonHoc').modal('hide');
                return;
            }
            else {
                if (response.message == "pk") {
                    $("#maMonHoc").focus();
                    toastr.error("Mã bộ môn đã tồn tại", "Lỗi", { timeOut: 2500 });
                    return;
                }
                if (response.message == "name") {
                    $("#tenBoMon").focus();
                    toastr.error("Tên bộ môn đã tồn tại", "Lỗi", { timeOut: 2500 });
                    return;
                }
                toastr.error("Thêm bộ môn thất bại: " + response.message, "Lỗi", { timeOut: 2500 });
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }

    });
    //toastr.success("Chỉnh sửa nè", "Thông báo", { timeOut: 2500 });
}*/
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
                    'defaultContent': '<button><i class="fa fa-pencil" onclick="editFunction()" aria-hidden="true"/></button>',
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