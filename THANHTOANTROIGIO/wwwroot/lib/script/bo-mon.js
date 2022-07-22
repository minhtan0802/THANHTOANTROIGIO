
var table_Khoa_rowIndex = 0;
var table_BoMon_rowIndex = 0;
var maKhoa = "";
var tenKhoa = "";
var maBoMon = "";
var tenBoMon = "";
var maBoMonEdit = "";
var table_Khoa, table_BoMon;
$(document).ready(function () {
    loading();
    $(document).on('shown.bs.modal', '#modalAddBoMon', function () {
        $('#maBoMon').focus();
    })
    /* document.getElementById("title").innerHTML = "Nhập dữ liệu - BỘ MÔN";*/
    table_Khoa = $("#table_Khoa").DataTable();
    table_BoMon = $("#table_BoMon").DataTable({
        'columnDefs': [{
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
    });
    init_Table_Khoa();
    $('#table_Khoa tbody').on('click', 'tr', function () {
        var index = table_Khoa.row(this).index();
        if ($(this).hasClass('selected') && table_Khoa_rowIndex != index) {
            $(this).removeClass('selected');
            table_Khoa_rowIndex = index;
            //   alert('Row index: ' + table_Khoa.row(this).index());
        }
        else {
            table_Khoa.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_Khoa_rowIndex = index;
            //   alert('Row index: ' + table_Khoa.row(this).index());
        }
    });
    $('#table_BoMon tbody').on('click', 'tr', function () {
        var index = table_BoMon.row(this).index();
        if ($(this).hasClass('selected') && table_BoMon_rowIndex != index) {
            $(this).removeClass('selected');
            table_BoMon_rowIndex = index;
        }
        else {
            table_BoMon.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_BoMon_rowIndex = index;
        }
    });

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
    $('#table_Khoa tbody').on('click', 'td', function () {
        var index = table_Khoa.row(this).index();
        if (index != table_Khoa_rowIndex) {
            $("#TenKhoa").val(table_Khoa.cell(this, 1).data());
            $("#MaKhoa").val(table_Khoa.cell(this, 0).data());
            tenKhoa = table_Khoa.cell(this, 1).data();
            maKhoa = table_Khoa.cell(this, 0).data();
            init_Table_BoMon();
        }

    });
    $('#table_BoMon').on('click', 'td.editor-edit', function (e) {
        $("#titleAddBoMon").html("Chỉnh sửa bộ môn");
        document.getElementById("btnSaveBoMon").style.display = "none";
        maBoMon = table_BoMon.cell(this, 0).data().trim();
        var tenBoMon = table_BoMon.cell(this, 1).data().trim();
        maBoMonEdit = maBoMon;
        $('#maBoMon').val(maBoMon);
        $('#tenBoMon').val(tenBoMon);
        $("#modalAddBoMon").modal("show");
    });

    $('#table_BoMon').on('click', 'td.editor-delete', function () {
        maBoMon = table_BoMon.cell(this, 0).data();
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa bộ môn này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                var row = table_BoMon.row(this);
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
    $("#btnAddBoMon").click(function () {
        maBoMonEdit = "";
        clearFormAdd();
        $("#titleAddBoMon").html("Thêm bộ môn");
        $("#modalAddBoMon").modal('show');
    });

    // Close modal on button click
    $("#btnCloseBoMon").click(function () {
        $("#modalAddBoMon").modal('hide');
    });
   
});
function editBoMon() {
    var maBoMonEdit = $("#maBoMon").val().trim();
    var tenBoMon = $("#tenBoMon").val().trim();
    if (maBoMonEdit == "") {
        $("#maBoMon").focus();
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
              //  init_Table_BoMon();
                table_BoMon.cell(this, 0).data(boMon.MaBoMon);
                table_BoMon.cell(this, 1).data(boMon.TenBoMon);
                $('#modalAddBoMon').modal('hide');
                document.getElementById("btnSaveBoMon").style.display = "inline";
                return;
            }
            else {
                if (response.message == "pk") {
                    $("#maBoMon").focus();
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
}
function onChangeSelect(event) {
    maBoMon = $("#select_BoMon option:selected").val();
    tenBoMon = $("#select_BoMon option:selected").text();
    init_table_BoMon();
}
function init_Table_Khoa() {
    $.ajax({
        async: true,
        type: 'GET',
        url: '/khoa/ds-khoa',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                table_Khoa.row.add([item.MaKhoa, item.TenKhoa]).draw(false);
            });
            $("#TenKhoa").val(table_Khoa.cell(0, 1).data());
            $("#MaKhoa").val(table_Khoa.cell(0, 0).data());
            maKhoa = table_Khoa.cell(0, 0).data();
            tenKhoa = table_Khoa.cell(0, 1).data();
            table_Khoa.rows(0).nodes().to$().addClass('selected');
            
            init_Table_BoMon();
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
        url: '/loading/bo-mon',
        success: function (response) {
            response = $.parseJSON(response);
            if (response == 1) {
                $("#modalLoadingBoMon").modal('show');
                setTimeout(function () {
                    $("#modalLoadingBoMon").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Table_BoMon() {
    var khoa = {
        MaKhoa: maKhoa, TenKhoa: ""
    };
    table_BoMon.clear().draw();
    $.ajax({
        async: true,
        type: 'POST',
        data: khoa,
        url: '/bo-mon/ds-bo-mon',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                table_BoMon.row.add([item.MaBoMon, item.TenBoMon]).draw(false);
            });
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function saveBoMon(flag) {
    if (maBoMonEdit != "") {
        editBoMon();
        return;
    }
    var maBoMon = $("#maBoMon").val().trim();
    var tenBoMon = $("#tenBoMon").val().trim();
    if (maBoMon == "") {
        $("#maBoMon").focus();
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
                table_BoMon.row.add([boMon.MaBoMon, boMon.TenBoMon]).draw(false);
                toastr.success("Thêm bộ môn thành công", "Thông báo", { timeOut: 2500 });
                if (flag == true) {
                    $('#modalAddBoMon').modal('hide');
                }
            }
            else {
                if (response.message == "pk") {
                    $("#maBoMon").focus();
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
            clearFormAdd();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }

    });
}
function clearFormAdd() {
    $("#maBoMon").val("");
    $("#tenBoMon").val("");
}