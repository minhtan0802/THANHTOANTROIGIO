var table_LDLT_rowIndex = 0;
var maLDLT = "";
var tenLDLT = "";
var flagEdit=false;
var table_LDLT;
var row;
$(document).ready(function () {
    /* loading();*/
    init_table_LDLT();
    $(document).on('shown.bs.modal', '#modalAddLDLT', function () {
        $('#siSoMin').focus();
    })
    document.getElementById("title").innerHTML = "LỚP ĐÔNG LÝ THUYẾT";


    $('#table_LDLT tbody').on('click', 'tr', function () {
        var index = table_LDLT.row(this).index();
        if ($(this).hasClass('selected') && table_LDLT_rowIndex != index) {
            $(this).removeClass('selected');
            table_LDLT_rowIndex = index;
        }
        else {
            table_LDLT.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            table_LDLT_rowIndex = index;
        }
    });

    $('#table_LDLT').on('click', 'td.editor-edit', function (e) {
        if (canEdit) {
            $("#titleAddMonHoc").html("Chỉnh sửa lớp đông lý thuyết");
            row = table_LDLT.row(this);
            flagEdit = true;
            var siSoMin = table_LDLT.cell(this, 0).data();
            var siSoMax = table_LDLT.cell(this, 1).data();
            var heSo = table_LDLT.cell(this, 2).data();
            $('#siSoMin').val(siSoMin);
            $('#siSoMax').val(siSoMax);
            $('#heSo').val(heSo);
            $("#modalAddLDLT").modal("show");
            $("#titleAddLDLT").html("Chỉnh sửa lớp đông lý thuyết");
            document.getElementById("btnSaveLDLT").style.display = "none";
        }
        else {
            return;
        }

    });

    $('#table_LDLT').on('click', 'td.editor-delete', function () {
        if (canEdit) {
            var siSoMin = table_LDLT.cell(this, 0).data();
            var siSoMax = table_LDLT.cell(this, 1).data();
            var heSo = table_LDLT.cell(this, 2).data();
            var ldlt = {
                SiSoMin: siSoMin,
                SiSoMax: siSoMax,
                HSLopDong: heSo,
                NgayApDung:'2022-01-01'
            }
            swal({
                title: "Xác nhận",
                text: "Bạn có chắc chắn muốn xóa lớp đông lý thuyết này?",
                type: 'warning',
                buttons: true,
                dangerMode: true
            }).then((willDelete) => {
                if (willDelete) {
                    var row = table_LDLT.row(this);
                    $.ajax({
                        async: true,
                        type: 'POST',
                        data: { model: ldlt },
                        url: '/lop-dong-ly-thuyet/delete',
                        success: function (response) {
                            response = $.parseJSON(response);
                            if (response.success == true) {
                                toastr.success("Xóa lớp đông lý thuyết thành công", "Thông báo", { timeOut: 3000 });
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
    $("#btnAddLDLT").click(function () {
        flagEdit = "";
        $("#titleAddLDLT").html("Thêm lớp đông lý thuyết");
        document.getElementById("btnSaveLDLT").style.display = "inline";
        clearForm();
        $("#modalAddLDLT").modal('show');
    });

    // Close modal on button click
    $("#btnCloseLDLT").click(function () {
        $("#modalAddLDLT").modal('hide');
    });


});
function saveLDLT(close) {
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

    var ldlt = {
        SiSoMin: siSoMin,
        SiSoMax: siSoMax,
        HSLopDong: heSo
    };
    if (!flagEdit) {
        $.ajax({
            async: true,
            type: 'POST',
            data: { model: ldlt },
            url: '/lop-dong-ly-thuyet/add',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    // var ldltFull = { MaLDLT: maLDLTAdd, TenLDLT: tenLDLT, DonGia: donGia };
                    table_LDLT.row.add(response.data).draw(false);
                    toastr.success("Thêm lớp đông lý thuyết thành công", "Thông báo", { timeOut: 2500 });
                    if (close) {
                        $('#modalAddLDLT').modal('hide');
                    }
                }
                else {
                    if (response.message == "pk") {
                        $("#siSoMin").focus();
                        toastr.error("Lớp đông lý thuyết nàyđã tồn tại", "Thêm lớp đông lý thuyết thất bại", { timeOut: 2500 });
                        return;
                    }
                    toastr.error(response.message, "Thêm lớp đông lý thuyết thất bại", { timeOut: 2500 });
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
            data: {model: ldlt },
            url: '/lop-dong-ly-thuyet/edit',
            success: function (response) {
                response = $.parseJSON(response);
                if (response.success == true) {
                    toastr.success("Chỉnh sửa lớp đông lý thuyết thành công", "Thông báo", { timeOut: 2500 });
                    row.data(response.data);
                    $('#modalAddLDLT').modal('hide');
                    return;
                }
                else {
                    if (response.message == "pk") {
                        $("#siSoMin").focus();
                        toastr.error("Lớp đông lý thuyết này đã tồn tại", "Chỉnh sửa lớp đông lý thuyết thất bại: ", { timeOut: 2500 });
                        return;
                    }
                    toastr.error(response.message, "Chỉnh sửa lớp đông lý thuyết thất bại: ", { timeOut: 2500 });
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
                $("#modalLoadingLDLT").modal('show');
                setTimeout(function () {
                    $("#modalLoadingLDLT").modal('hide')
                }, 2500)

            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_table_LDLT(showAll) {
    table_LDLT = $("#table_LDLT").DataTable();
    table_LDLT.destroy();
    $.ajax({
        async: true,
        type: 'GET',
        data: { all: showAll },
        url: '/lop-dong-ly-thuyet/ds',
        success: function (response) {
            console.log(response);
            table_LDLT = $('#table_LDLT').DataTable({
                "drawCallback": function () {
                    $('.paginate_button.next', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddLDLT").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddLDLT").removeAttr("disabled");
                                canEdit = true;
                            }
                        });
                    $('.paginate_button', this.api().table().container())
                        .on('click', function () {
                            var listBtnEditDelete = document.getElementsByClassName("edit");

                            if (showAll == 1) {
                                $("#btnAddLDLT").attr("disabled", "disabled");
                                canEdit = false;
                                $.each(listBtnEditDelete, function (i, item) {
                                    item.setAttribute("disabled", "disabled");
                                });
                            }
                            else {
                                $("#btnAddLDLT").removeAttr("disabled");
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
                $("#btnAddLDLT").attr("disabled", "disabled");
                canEdit = false;
                $.each(listBtnEditDelete, function (i, item) {
                    item.setAttribute("disabled", "disabled");
                });
            }
            else {
                $("#btnAddLDLT").removeAttr("disabled");
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
function showAllLDLT() {
    var checkBox = document.getElementById("showAll");
    if (checkBox.checked == true) {
        document.getElementById("notify").style.display = "inline";
        init_table_LDLT(1);
    }
    else {
        document.getElementById("notify").style.display = "none";
        init_table_LDLT(0);
    }
}