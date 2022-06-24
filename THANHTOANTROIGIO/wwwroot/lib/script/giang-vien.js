//   document.getElementById("professor").setAttribute("class", "active");
//   document.getElementById("edu").setAttribute("class", "");
var modal = document.getElementById("formAddGV");
var table_Khoa_rowIndex = 0;
var table_GV_rowIndex = 0;
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
$(document).ready(function () {
    document.getElementById("title").innerHTML = "Nhập dữ liệu - GIẢNG VIÊN";
    $("#select_ChucDanh").prop("selectedIndex", 0);
    table_Khoa = $("#table_Khoa").DataTable();
    $("#modalLoading").modal('show')
    setTimeout(function () {
        $("#modalLoading").modal('hide')
    }, 2500)
    init_Table_Khoa();

    table_GV = $('#table_GV').DataTable({
        "createdRow": function (row, data, dataIndex) {
            if (data[10] == true) {
                $(row).find("input[type='checkbox']")
                    .attr('checked', 'checked');
            }
        },
        'columnDefs': [{
            'targets': 10,
            'searchable': false,
            'orderable': false,
            'className': 'dt-body-center',
            'render': function (data, type, full, meta) {
                return '<input type="checkbox" name="id[]" onclick="return false;" value=" ' + $('<div/>').text(data).html() + '">';
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
    document.getElementById('select_BoMon').addEventListener('change', function () {
        maBoMon = this.value;
        tenBoMon = this.text;
        init_Table_GV();
    });
    init_Select_HocVi();
    init_Select_ChucVu()
    table_Khoa.columns(0).visible(false);
    table_GV.columns(0).visible(false);

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
    table_GV.clear().draw();
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
        maGVEdit = maGV;
        var ten = table_GV.cell(this, 2).data();
        var ho = table_GV.cell(this, 1).data();
        var chucDanh = table_GV.cell(this, 5).data();

        if ((table_GV.cell(this, 6).data().trim()) == "Nam") {
            document.getElementById("select_GioiTinh").value = true;
        }
        else {
            document.getElementById("select_GioiTinh").value = false;
        }
        var ngaySinh = (table_GV.cell(this, 7).data()).split('T')[0];
        var diaChi = table_GV.cell(this, 8).data();
        var sdt = table_GV.cell(this, 9).data();
        var gvCoHuu = true;
        if (table_GV.cell(this, 10).data()) {
            $("#gvCoHuu").attr('checked', 'checked');
            maLoaiGV = true;
        }
        else {
            $("#gvCoHuu").attr('checked', false);
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
                console.log(response);
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
                console.log(response);
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
                console.log("Chức danh: " + response);
            },
            error: function () {
                toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
                console.log(response);
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
                console.log(response);
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
        alert(maGV);
        var gv = {
            MaGiangVien: maGV, Ho: "", Ten: "", HocVi: "", ChucDanh: "", GioiTinh: true, NgaySinh: "1970-1-1",
            DiaChi: "", Sdt: "", GVCoHuu: true, MaBoMon: "", ChucVu: "", TrangThaiXoa: true
        };
        console.log(JSON.stringify(gv));
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
                        if (response.result == true) {
                            toastr.success(response.data, "Thông báo", { timeOut: 3000 });
                            init_Table_GV();
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
    table_GV.clear().draw();
    var boMon = {
        MaBoMon: maBoMon, TenBoMon: tenBoMon
    };
    $.ajax({
        async: true,
        type: 'POST',
        data: boMon,
        url: '/giangvien/ds-giang-vien',
        success: function (response) {
            response = $.parseJSON(response);
            var rowCount = 0;
            $.each(response, function (i, item) {
                table_GV.row.add([item.MaGiangVien, item.Ho, item.Ten, item.HocVi, item.ChucVu, item.ChucDanh, item.GioiTinh, item.NgaySinh.split('T')[0], item.DiaChi, item.Sdt, item.GVCoHuu]).draw(false);
                if (item.GioiTinh == 1) {
                    table_GV.cell(rowCount, 6).data("Nam");
                }
                else {
                    table_GV.cell(rowCount, 6).data("Nữ");
                }
                if (item.ChucDanh.trim() == "GV") {
                    table_GV.cell(rowCount, 5).data("Giảng viên");
                }
                else if (item.ChucDanh.trim() == "GVC") {
                    table_GV.cell(rowCount, 5).data("Giảng viên chính");
                }
                else {
                    table_GV.cell(rowCount, 5).data("Giảng viên cao cấp");

                }
                rowCount++;
            });

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
            if (response.result == true) {
                toastr.success("Thêm thành công", "Thông báo", { timeOut: 3000 });
                init_Table_GV();
                $('#modalAddGV').modal('hide');
                //      var Modal = document.getElementsByClassName("modal-backdrop fade in");
                //      Modal[0].style.display = "none";
                //    Modal[1].style.display = "none";
                //   var form = document.getElementsById("formAddGV");
                // form.style.display = "none";
                //       var ModalDialog = document.getElementsByClassName("modal-dialog");
                //     ModalDialog.style.display = "none !important";




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
    var chucVu = $("#select_ChucVu").val();
    if (chucVu.trim() == maChucVu.trim()) {
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
            if (response.result == true) {
                toastr.success(response.data, "Thông báo", { timeOut: 3000 });
                init_Table_GV();
                $('#modalAddGV').modal('hide');
                $("#select_ChuyenBoMon").empty();
                $("#checkbox_ChuyenBoMon").prop("checked", false);
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
function myFunction() {
    document.getElementById("ngaySinh").defaultValue = "1970/1/1";
}
function init_Select_HocVi() {
    $("#select_HocVi").empty();
    $.ajax({
        async: true,
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