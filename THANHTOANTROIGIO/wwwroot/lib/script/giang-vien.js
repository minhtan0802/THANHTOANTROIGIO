var modal = document.getElementById("formAddGV");
var table_Khoa_rowIndex = 0;
var table_GV_rowIndex = 0;
var maKhoa = "";
var tenKhoa = "";
var maBoMon = "";
var tenBoMon = "";
var maGV = "";
var maGVEdit = "";
var ten = "";
var ho = "";
var editor;
var maHocVi;
var maBoMon;
var maChucVu;
var maLoaiGV;
var maChucDanh;
var init_Table_GV;
var table_Khoa, table_GV;
var row;
$(document).ready(function () {
    $(document).on('shown.bs.modal', '#modalAddGV', function () {
        $('#maGV').focus();
    })
    document.getElementById("title").innerHTML = "Nhập dữ liệu - GIẢNG VIÊN";
    $("#select_ChucDanh").prop("selectedIndex", 0);
    table_Khoa = $("#table_Khoa").DataTable();
    /*loading();*/
    init_Table_Khoa();
    table_GV = $("#table_GV").DataTable();
    document.getElementById('select_BoMon').addEventListener('change', function () {
        maBoMon = this.value;
        tenBoMon = this.text;
        init_Table_GV();
    });
    init_Select_HocVi();
    init_Select_ChucVu()
    table_Khoa.columns(0).visible(false);
    /* table_GV.columns(0).visible(false);*/

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
    $('#table_GV tbody').on('click', 'tr', function () {
        var index = table_GV.row(this).index();
        if ($(this).hasClass('selected') && table_GV_rowIndex != index) {
            $(this).removeClass('selected');
            table_GV_rowIndex = index;
        }
        else {
            table_GV.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_GV_rowIndex = index;
        }
    });
    $('#table_Khoa tbody').on('click', 'td', function () {
        var index = table_Khoa.row(this).index();
        if (index != table_Khoa_rowIndex) {
            $("#TenKhoa").val(table_Khoa.cell(this, 1).data());
            $("#MaKhoa").val(table_Khoa.cell(this, 0).data());
            tenKhoa = table_Khoa.cell(this, 1).data();
            maKhoa = table_Khoa.cell(this, 0).data();
            init_Select_BoMon();
        }
    });
    $('#table_GV').on('click', 'td.editor-edit', function (e) {
        $("#staticBackdropLabel").html("Chỉnh sửa giảng viên");
        document.getElementById("checkbox_ChuyenBoMon").style.display = "inline";
        document.getElementById("label_ChuyenBoMon").style.display = "inline";
        maGV = table_GV.cell(this, 0).data();
        row = table_GV.row(this);
        maGVEdit = maGV;
        var ten = table_GV.cell(this, 2).data();
        var ho = table_GV.cell(this, 1).data();
        var chucDanh = table_GV.cell(this, 5).data();
        var gender = table_GV.cell(this, 6).data();

        if (gender == true) {
            document.getElementById("select_GioiTinh").value = true;
        }
        else {
            document.getElementById("select_GioiTinh").value = false;
        }
        var ngaySinh;
        if (table_GV.cell(this, 7).data() != null)
        {
            ngaySinh = (table_GV.cell(this, 7).data()).split('T')[0];
        }

        var diaChi = table_GV.cell(this, 8).data();
        var sdt = table_GV.cell(this, 9).data();
        var gvCoHuu = true;
        if (table_GV.cell(this, 10).data()) {
            $("#gvCoHuu").prop('checked', 'checked');
            maLoaiGV = true;
        }
        else {
            $("#gvCoHuu").prop('checked', false);
            maLoaiGV = false;
        }

        maGVEdit = $("#maGV").val(maGV.trim());
        $("#ho").val(ho.trim());
        $("#ten").val(ten.trim());

        $("#ngaySinh").val(ngaySinh);
        $("#diaChi").val(diaChi);
        $("#sdt").val(sdt);
        var gv = {
            MaGiangVien: maGV.trim(), Ho: ho, Ten: ten, HocVi: "", ChucDanh: chucDanh, GioiTinh: 1, NgaySinh: '1970-1-1',
            DiaChi: "", Sdt: "", GVCoHuu: true, MaBoMon: maBoMon, ChucVu: "", TrangThaiXoa: false
        };
        $.ajax({
            async: true,
            type: 'POST',
            data: gv,
            url: '/hoc-vi/by-ma-gv',
            success: function (response) {
                response = $.parseJSON(response);
                document.getElementById("select_HocVi").value = response;
                $('#select_HocVi').trigger('change');
                maHocVi = response;
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });

        $.ajax({
            async: true,
            type: 'POST',
            data: gv,
            url: '/giangvien/chuc-danh',
            success: function (response) {
                response = $.parseJSON(response);
                document.getElementById("select_ChucDanh").value = response;
                $('#select_ChucDanh').trigger('change');
                maChucDanh = response;
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });

        $.ajax({
            async: true,
            type: 'POST',
            data: gv,
            url: '/chuc-vu/by-ma-gv',
            success: function (response) {
                response = $.parseJSON(response);
                document.getElementById("select_ChucVu").value = response;
                $('#select_ChucVu').trigger('change');
                maChucVu = response;
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    });
    $(document).ready(function () {
        $("#btnSave").click(function (e) {
            if (maGVEdit != "") {
                editGiangVien();
            }
            else {
                saveGiangVien();
            }

        });
        $("#btnThemGV").click(function (e) {
            $("#modalAddGV").modal("show");

        });
        $("#btnClose").click(function (e) {
            $("#modalAddGV").modal("hide");
        });
    });
    $(document).ready(function () {
        // Open modal on page load
        $("#btnAdd").click(function () {
            clearFormAddGV();
            maGVEdit = "";
            $("#staticBackdropLabel").html("Thêm giảng viên");
            document.getElementById("checkbox_ChuyenBoMon").style.display = "none";
            document.getElementById("label_ChuyenBoMon").style.display = "none";
            $("#modalAddGV").modal('show');
        });

        // Close modal on button click
        $("#btnClose").click(function () {
            $("#modalAddGV").modal('hide');
        });
    });
    $('#table_GV').on('click', 'td.editor-delete', function () {
        maGV = table_GV.cell(this, 0).data();
        var gv = {
            MaGiangVien: maGV, Ho: "", Ten: "", HocVi: "", ChucDanh: "", GioiTinh: true, NgaySinh: "1970-1-1",
            DiaChi: "", Sdt: "", GVCoHuu: true, MaBoMon: "", ChucVu: "", TrangThaiXoa: true
        };
        row = table_GV.row(this);
        swal({
            title: "Xác nhận",
            text: "Bạn có chắc chắn muốn xóa giảng viên này?",
            type: 'warning',
            buttons: true,
            dangerMode: true
        }).then((willDelete) => {
            if (willDelete) {
                $.ajax({
                    async: true,
                    type: 'POST',
                    data: gv,
                    url: '/giangvien/delete',
                    success: function (response) {
                        if (response.success == true) {
                            toastr.success(response.data, "Thông báo", { timeOut: 3000 });
                            row.remove().draw();
                        } else {
                            toastr.error(response.data, "Lỗi", { timeOut: 3000 });
                        }
                    }
                });

            };
        });
    });
    $('#select_ChucDanh').select2({
        dropdownParent: $('#modalAddGV'),
    });
    $('#select_ChucVu').select2({
        dropdownParent: $('#modalAddGV'),
    });
    $('#select_HocVi').select2({
        dropdownParent: $('#modalAddGV'),
    });
    $('#select_BoMon').select2();
    document.getElementById("select_ChuyenBoMon").style.display = "none";


});
function editFunction() {
    $("#modalAddGV").modal("show");
    $("#checkbox_ChuyenBoMon").prop("checked", false);
    document.getElementById("select_ChuyenBoMon").style.display = "none";
    document.getElementById("label_SelectCBM").style.display = "none";
}
function clearFormAddGV() {
    $("#maGV").val("");
    $("#ho").val("");
    $("#ten").val("");
    $("#select_HocVi").prop("selectedIndex", 0);
    $("#select_ChucVu").prop("selectedIndex", 0);
    $("#select_ChucDanh").prop("selectedIndex", 0);
    $("#select_GioiTinh").prop("selectedIndex", 0);
    $("#ngaySinh").val('1970-01-01');
    $("#diaChi").val("");
    var sdt = $("#sdt").val("");
    $("#gvCoHuu").attr('checked', false);
    $("#maGV").prop('readonly', false);
}
function chuyenBoMon() {
    var checkBox = document.getElementById("checkbox_ChuyenBoMon");
    if (checkBox.checked == true) {
        document.getElementById("select_ChuyenBoMon").style.display = "inline";
        document.getElementById("label_SelectCBM").style.display = "inline";
        $("#select_ChuyenBoMon").empty();
        var boMon = { MaBoMon: maBoMon, TenBoMon: "", MaKhoa: "" };
        $.ajax({
            async: true,
            type: 'POST',
            data: boMon,
            url: '/bo-mon/all-bo-mon',
            success: function (response) {
                response = $.parseJSON(response);
                $.each(response, function (i, item) {
                    $('#select_ChuyenBoMon').append($('<option>', {
                        value: item.MaBoMon,
                        text: item.TenBoMon
                    }));
                });
                $('#select_ChuyenBoMon').select2({
                    dropdownParent: $('#modalAddGV')
                });
                $("#select_ChuyenBoMon").prop("selectedIndex", 0);
                maBoMonChuyen = $("#select_ChuyenBoMon option:selected").val();
                tenBoMon = $("#select_ChuyenBoMon option:selected").text();
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
            }
        });
    }
    else {
        $('#select_ChuyenBoMon').select2('destroy');
        document.getElementById("select_ChuyenBoMon").style.display = "none";
        document.getElementById("label_SelectCBM").style.display = "none";
    }
}
function onChangeSelect(event) {
    maBoMon = $("#select_BoMon option:selected").val();
    tenBoMon = $("#select_BoMon option:selected").text();
    init_Table_GV();
}
function init_Table_GV() {
    table_GV.destroy();
    var boMon = {
        MaBoMon: maBoMon, TenBoMon: tenBoMon
    };
    $.ajax({
        async: false,
        type: 'POST',
        data: boMon,
        url: '/giangvien/ds-giang-vien',
        success: function (response) {

            table_GV = $('#table_GV').DataTable({
                "data": $.parseJSON(response),
                "rowId": 'MaGiangVien'.trim(),
                "createdRow": function (row, data, dataIndex) {
                    $(row).attr('id', data[0]);
                    if (data[10] ==true) {
                        $(row).find("input[type='checkbox']")
                            .attr('checked', 'checked');
                    }
                },
                "columns": [{
                    'data': 'MaGiangVien',
                },
                {
                    'data': 'Ho',
                }, {
                    'data': 'Ten',
                }, {
                    'data': 'HocVi',
                }, {
                    'data': 'ChucVu',
                }, {
                    'data': 'ChucDanh',
                }, {
                    'data': 'GioiTinh',
                    'render': function (data, type, row) {
                        if (data == true) {
                            return "Nam";
                        }
                        else {
                            return "Nữ";
                        }
                    }
                }, {
                    'data': 'NgaySinh',
                    'render': function (data, type, row) {
                        if (data != null) {
                            var date = data.split('T')[0];
                            var dateOfBirth = date.split("-");
                            var ret = dateOfBirth[2] + "/" + dateOfBirth[1] + "/" + dateOfBirth[0];
                            return ret;
                        }
                        return "";
                    }
                }, {
                    'data': 'DiaChi',
                }, {
                    'data': 'Sdt',
                }, {
                    'data': 'GVCoHuu',
                }
                ]
                , 'columnDefs': [{
                    'targets': 10,
                    'searchable': false,
                    'orderable': false,
                    'className': 'dt-body-center',
                    'render': function (data, type, full, meta) {
                        if (data == true) {
                            return '<input type="checkbox" name="id[]" checked onclick="return false;" value=" ' + $('<div/>').text(data).html() + '">';
                        }
                        else {
                            return '<input type="checkbox" name="id[]" onclick="return false;" value=" ' + $('<div/>').text(data).html() + '">';
                        }

                    }
                }, {
                    'targets': 11,
                    'className': "dt-center editor-edit",
                    'defaultContent': '<button><i class="fa fa-pencil" onclick="editFunction()" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 12,
                    'className': "dt-center editor-delete",
                    'defaultContent': '<button><i class="fa fa-trash"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 7,
                    'width': "20%"
                },
                {
                    'targets': 5,
                    'width': "20%"
                },
                {
                    'targets': 3,
                    'width': "20%"
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
function init_Select_ChucVu() {
    $("#select_ChucVu").empty();
    $.ajax({
        async: true,
        type: 'POST',
        url: '/chuc-vu/ds-chuc-vu',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_ChucVu').append($('<option>', {
                    value: item.MaChucVu,
                    text: item.TenChucVu
                }));
            });
            $("#select_ChucVu").prop("selectedIndex", 0);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Select_BoMon() {
    $('#select_BoMon').empty();
    var khoa = {
        MaKhoa: maKhoa, TenKhoa: tenKhoa
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: khoa,
        url: '/bo-mon/ds-bo-mon',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_BoMon').append($('<option>', {
                    value: item.MaBoMon,
                    text: item.TenBoMon
                }));
            });
            $("#select_BoMon").prop("selectedIndex", 0);
            maBoMon = $("#select_BoMon option:selected").val();
            tenBoMon = $("#select_BoMon option:selected").text();
            init_Table_GV();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
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
            init_Select_BoMon();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function saveGiangVien() {
    var ma = $("#maGV").val();
    var ho = $("#ho").val();
    var ten = $("#ten").val();
    var hocVi = $("#select_HocVi").val();
    var chucVu = $("#select_ChucVu").val();
    var chucDanh = $("#select_ChucDanh").val();
    var gioiTinh = $("#select_GioiTinh").val();
    var ngaySinh = $("#ngaySinh").val();
    var diaChi = $("#diaChi").val();
    var gvCoHuu = true;
    var sdt = $("#sdt").val();
    if ($("#gvCoHuu").prop('checked')) {
        gvCoHuu = true;
    }
    else {
        gvCoHuu = false;
    }
    var gv = {
        MaGiangVien: ma, Ho: ho, Ten: ten, HocVi: hocVi, ChucDanh: chucDanh, GioiTinh: gioiTinh, NgaySinh: ngaySinh,
        DiaChi: diaChi, Sdt: sdt, GVCoHuu: gvCoHuu, MaBoMon: maBoMon, ChucVu: chucVu, TrangThaiXoa: false
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: gv,
        url: '/giangvien/add',
        success: function (response) {
            response = $.parseJSON(response);
            if (response.result == true) {
                toastr.success("Thêm thành công", "Thông báo", { timeOut: 3000 });
                var gvAdd = response.data;

                var gioiTinh = "Nữ";
                var chucDanh = "Giảng viên";
                if (gvAdd.GioiTinh == 1) {
                    gioiTinh = "Nam";
                }
                if (gvAdd.ChucDanh == "GVC") {
                    chucDanh = "Giảng viên chính";
                }
                else if (gvAdd.ChucDanh == "GVCC") {
                    chucDanh = "Giảng viên cao cấp";
                }
                gvAdd.ChucDanh = chucDanh;
                table_GV.row.add(gvAdd).draw(false);

                $('#modalAddGV').modal('hide');



            } else {
                toastr.error(response.data, "Lỗi", { timeOut: 3000 });
                return;
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
    if (ma == null || ma == "") {
        $("#maGV").focus();
        return;
    }
    if (ho == null || ho == "") {
        $("#ho").focus();
        return;
    }
    if (ten == null || ten == "") {
        $("#ten").focus();
        return;
    }
    if (chucDanh == null || chucDanh == "") {
        $("#chucDanh").focus();
        return;
    }

}
function editGiangVien() {
    maGVEdit = $("#maGV").val().trim();
    var ho = $("#ho").val();
    var ten = $("#ten").val();
    var hocVi = $("#select_HocVi").val();
    if (hocVi.trim() == maHocVi.trim()) {
        hocVi = "false";
    }
    var chucVu = $("#select_ChucVu option:selected").val();
    if (chucVu == maChucVu) {
        chucVu = "false";
    }
    var chucDanh = $("#select_ChucDanh").val();
    var gioiTinh = $("#select_GioiTinh").val();
    var ngaySinh = $("#ngaySinh").val();
    var diaChi = $("#diaChi").val();
    var gvCoHuu = "true";
    var sdt = $("#sdt").val();
    if ($("#gvCoHuu").prop('checked')) {
        gvCoHuu = true;
    }
    else {
        gvCoHuu = false;
    }
    var checkBox = document.getElementById("checkbox_ChuyenBoMon");
    var maBoMonChuyen = "";
    if ($("#checkbox_ChuyenBoMon").prop('checked')) {
        maBoMonChuyen = $("#select_ChuyenBoMon").val();
    }
    else {
        maBoMonChuyen = maBoMon;
    }
    var gv = {
        MaGiangVien: maGV.trim() + " " + maGVEdit, Ho: ho, Ten: ten, HocVi: hocVi, ChucDanh: chucDanh, GioiTinh: gioiTinh, NgaySinh: ngaySinh,
        DiaChi: diaChi, Sdt: sdt, GVCoHuu: gvCoHuu, MaBoMon: maBoMonChuyen, ChucVu: chucVu, TrangThaiXoa: false
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: gv,
        url: '/giangvien/edit',
        success: function (response) {
            response = $.parseJSON(response);
            if (response.result == true) {
                toastr.success("Chỉnh sửa giảng viên thành công", "Thông báo", { timeOut: 3000 });
                var gvAdd = JSON.parse(JSON.stringify(response.data));
                if (maBoMon != maBoMonChuyen) {
                    row.remove().draw();
                }
                else {
                    var chucDanh = "Giảng viên";
                    if (gvAdd.ChucDanh == "GVC") {
                        chucDanh = "Giảng viên chính";
                    }
                    else if (gvAdd.ChucDanh == "GVCC") {
                        chucDanh = "Giảng viên cao cấp";
                    }
                    gvAdd.ChucDanh = chucDanh;
                    row.data(gvAdd);
                }
                $('#modalAddGV').modal('hide');
                $("#select_ChuyenBoMon").empty();
                $("#checkbox_ChuyenBoMon").prop("checked", false);
                $("#select_ChuyenBoMon").select2("destroy");
                document.getElementById("select_ChuyenBoMon").style.display = "none";
                document.getElementById("label_SelectCBM").style.display = "none";
            } else {
                toastr.error(response.data, "Lỗi", { timeOut: 3000 });
                return;
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
    if (maGVEdit == null || maGVEdit == "") {
        $("#maGV").focus();
        return;
    }
    if (ho == null || ho == "") {
        $("#ho").focus();
        return;
    }
    if (ten == null || ten == "") {
        $("#ten").focus();
        return;
    }
    if (chucDanh == null || chucDanh == "") {
        $("#chucDanh").focus();
        return;
    }

}
function myFunction() {
    document.getElementById("ngaySinh").defaultValue = "1970/1/1";
}
function init_Select_HocVi() {
    $("#select_HocVi").empty();
    $.ajax({
        async: true,
        type: 'POST',
        type: 'POST',
        data: "",
        url: '/hoc-vi/ds-hoc-vi',
        success: function (response) {
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_HocVi').append($('<option>', {
                    value: item.MaHocVi,
                    text: item.TenHocVi
                }));
            });
            $("#select_HocVi").prop("selectedIndex", 0);
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}