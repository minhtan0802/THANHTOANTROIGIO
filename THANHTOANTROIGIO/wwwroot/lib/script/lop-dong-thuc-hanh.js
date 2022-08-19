var table_LDTH_rowIndex = 0;
var maLDTH = "";
var tenLDTH = "";
var flagEdit=false;
var table_LDTH;
var row;
$(document).ready(function () {
    /* loading();*/
    init_table_LDTH();
    $(document).on('shown.bs.modal', '#modalAddLDTH', function () {
        $('#siSoMin').focus();
    })
    document.getElementById("title").innerHTML = "LỚP ĐÔNG THỰC HÀNH";


    $('#table_LDTH tbody').on('click', 'tr', function () {
        var index = table_LDTH.row(this).index();
        if ($(this).hasClass('selected') && table_LDTH_rowIndex != index) {
            $(this).removeClass('selected');
            table_LDTH_rowIndex = index;
        }
        else {
            table_LDTH.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_LDTH_rowIndex = index;
        }
    });

    $('#table_LDTH').on('click', 'td.editor-edit', function (e) {
        if (canEdit) {
            $("#titleAddMonHoc").html("Chỉnh sửa lớp đông thực hành");
            row = table_LDTH.row(this);
            flagEdit = true;
            var siSoMin = table_LDTH.cell(this, 0).data();
            var siSoMax = table_LDTH.cell(this, 1).data();
            var heSo = table_LDTH.cell(this, 2).data();
            $('#siSoMin').val(siSoMin);
            $('#siSoMax').val(siSoMax);
            $('#heSo').val(heSo);
            $("#modalAddLDTH").modal("show");
            $("#titleAddLDTH").html("Chỉnh sửa lớp đông thực hành");
            document.getElementById("btnSaveLDTH").style.display = "none";
        }
        else {
            return;
        }

    });

    $('#table_LDTH').on('click', 'td.editor-delete', function () {
        if (canEdit) {
            var siSoMin = table_LDTH.cell(this, 0).data();
            var siSoMax = table_LDTH.cell(this, 1).data();
            var heSo = table_LDTH.cell(this, 2).data();
            var ldth = {
                SiSoMin: siSoMin,
                SiSoMax: siSoMax,
                HSLopDong: heSo,
                NgayApDung:'2022-01-01'
            }
            swal({
                title: "Xác nhận",
                text: "Bạn có chắc chắn muốn xóa lớp đông thực hành này?",
                type: 'warning',
                buttons: true,
                dangerMode: true
            }).then((willDelete) => {
                if (willDelete) {
                    var row = table_LDTH.row(this);
                    $.ajax({
                        async: true,
                        type: 'POST',
                        data: { model: ldth },
                        url: '/lop-dong-thuc-hanh/delete',
                        success: function (response) {
                            response = $.parseJSON(response);
                            if (response.success == true) {
                                toastr.success("Xóa lớp đông thực hành thành công", "Thông báo", { timeOut: 3000 });
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
    $("#btnAddLDTH").click(function () {
        flagEdit = "";
        $("#titleAddLDTH").html("Thêm lớp đông thực hành");
        document.getElementById("btnSaveLDTH").style.display = "inline";
        clearForm();
        $("#modalAddLDTH").modal('show');
    });

    // Close modal on button click
    $("#btnCloseLDTH").click(function () {
        $("#modalAddLDTH").modal('hide');
    });


});
function saveLDTH(close) {
    var siSoMin = $("#siSoMin").val();
    var siSoMax = $("#siSoMax").val();
    var heSo = $("#heSo").val();
    if (siSoMin==null) {
        $("#siSoMin").focus();
        toastr.error("Vui lòng nhập Sỉ Số Min", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (siSoMax==null) {
        $("#siSoMax").focus();
        toastr.error("Vui lòng nhập Sỉ Số Max", "Lỗi", { timeOut: 2500 });
        return;
    }
    if (heSo==null) {
        $("#heSo").focus();
        toastr.error("Vui lòng nhập hệ số", "Lỗi", { timeOut: 2500 });
        return;
    }

    var ldth = {
        SiSoMin: siSoMin,
        SiSoMax: siSoMax,
        HSLopDong: heSo
    };
    if (!flagEdit) {
        $.ajax({
            async: true,
            type: 'POST',
            data: { model: ldth },
            url: '/lop-dong-thuc-hanh/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    // var ldthFull = { MaLDTH: maLDTHAdd, TenLDTH: tenLDTH, DonGia: donGia };
                    table_LDTH.row.add(response.data).draw(false);
                    toastr.success("Thêm lớp đông thực hành thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddLDTH').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#siSoMin").focus();
                        toastr.error("Lớp đông thực hành nàyđã tồn tại", "Thêm lớp đông thực hành thất bại", { timeOut: 2500 });
                        return;
                    }
                    toastr.error(response.message, "Thêm lớp đông thực hành thất bại", { timeOut: 2500 });
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
            data: {model: ldth },
            url: '/lop-dong-thuc-hanh/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success("Chỉnh sửa lớp đông thực hành thành công", "Thông báo", { timeOut: 2500 });
                    row.data(response.data);
                    $('#modalAddLDTH').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#siSoMin").focus();
                        toastr.error("Lớp đông thực hành này đã tồn tại", "Chỉnh sửa lớp đông thực hành thất bại: ", { timeOut: 2500 });
                        return;
                    }
                    toastr.error(response.message, "Chỉnh sửa lớp đông thực hành thất bại: ", { timeOut: 2500 });
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
                $("#modalLoadingLDTH").modal('show');
                setTimeout(function () {
                    $("#modalLoadingLDTH").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_LDTH(showAll) {
    table_LDTH = $("#table_LDTH").DataTable();
    table_LDTH.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { all: showAll },
        url: '/lop-dong-thuc-hanh/ds',
        success: function (response) {
            console.log(response);
            table_LDTH = $('#table_LDTH').DataTable({
                "drawCallback": function () {
                    $('.paginate_button.next', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");
                           
                            if (showAll == 1) {
                                $("#btnAddLDTH").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddLDTH").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                    $('.paginate_button', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");
                           
                            if (showAll == 1) {
                                $("#btnAddLDTH").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddLDTH").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                },
                "data": $.parseJSON(response).data,
                "columns": [{
                    'data': 'SiSoMin',
                },
                {
                    'data': 'SiSoMax',
                }, {
                    'data': 'HSLopDong'
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
                    'defaultContent': '<button class="edit"><i class="fa fa-pencil" aria-hidden="true"/></button>',
                    'orderable': false,
                    'searchable': false
                },
                {
                    'targets': 5,
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
                $("#btnAddLDTH").attr("disabled", "disabled");
                canEdit = false;
                $.each(listBtnEditDelete, function (i, item) {
                    item.setAttribute("disabled", "disabled");
                });
            }
            else {
                $("#btnAddLDTH").removeAttr("disabled");
                canEdit = true;
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function clearForm() {
    $("#siSoMin").val(null);
    $("#siSoMax").val("");
    $("#heSo").val(null);
}
function showAllLDTH() {
    var checkBox = document.getElementById("showAll");
    if (checkBox.checked == true) {
        document.getElementById("notify").style.display = "inline";
        init_table_LDTH(1);
    }
    else {
        document.getElementById("notify").style.display = "none";
        init_table_LDTH(0);
    }
}