var tenNienKhoa = "";
var maHocKy = "";
var maKhoa = "";
var listSubject;
var listGV;
var nodeTree = null;
var table_LTC;
$(document).ready(function () {
    $("#select_Khoa").select2();
    init_Select_NienKhoa();
    init_Select_Khoa();
    init_Tree_GV();
    table_LTC = $("#table_LTC").DataTable();
    /* document.querySelector(".list-group-item").addEventListener('click', function () { alert("Hello") }, false);*/
/*    list = document.getElementsByClassName("list-group-item");
    list.forEach(myFunction);

    function myFunction(item) {
        item.addEventListener('click', (event) => {
            console.log('Hi!');
        });
    }*/
   
});
////Onchange
function onChange_Select_NienKhoa(event) {
    tenNienKhoa = $("#select_NienKhoa option:selected").val();
    init_Select_HocKy();
}
function onChange_Select_Khoa(event) {
    maKhoa = $("#select_Khoa option:selected").val();
    init_Tree_GV();
}

/////
function init_Select_HocKy() {
    $("#select_HocKy").empty();
    var nienKhoa = {
        MaNKHK: "", TenNienKhoa: tenNienKhoa, TenHocKy: ""
    };
    console.log(JSON.stringify(nienKhoa));
    $.ajax({
        async: true,
        type: 'POST',
        data: nienKhoa,
        url: '/nien-khoa-hoc-ky/hoc-ky',
        success: function (response) {
            console.log(JSON.stringify(response));
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_HocKy').append($('<option>', {
                    value: item.MaNKHK,
                    text: item.TenHocKy
                }));
            });
            $("#select_HocKy").prop("selectedIndex", 0);
            maHocKy = $("#select_HocKy option:selected").val();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Select_Khoa() {
    $("#select_Khoa").empty();
    $.ajax({
        async: false,
        type: 'GET',
        url: '/khoa/ds-khoa',
        success: function (response) {
            console.log(JSON.stringify(response));
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_Khoa').append($('<option>', {
                    value: item.MaKhoa,
                    text: item.TenKhoa
                }));
            });
            $("#select_Khoa").prop("selectedIndex", 0);
            $('#select_Khoa').trigger('change'); 
            maKhoa = $("#select_Khoa option:selected").val();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}

function init_Select_NienKhoa() {
    $("#select_NienKhoa").empty();
    $.ajax({
        async: true,
        type: 'GET',
        url: '/nien-khoa-hoc-ky/nien-khoa',
        success: function (response) {
            console.log(JSON.stringify(response));
            response = $.parseJSON(response);
            $.each(response, function (i, item) {
                $('#select_NienKhoa').append($('<option>', {
                    value: item.TenNienKhoa,
                    text: item.TenNienKhoa
                }));
            });
            $("#select_NienKhoa").prop("selectedIndex", 0);
            tenNienKhoa = $("#select_NienKhoa option:selected").val();
            init_Select_HocKy();
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}
function init_Tree_GV() {
    $("#tree_GV").remove();
    $("#label_GV").after("<div class='form-control' id='tree_GV'></div>");
    var khoa = {
        MaKhoa: maKhoa, TenKhoa: ""
    };
    $.ajax({
        async: true,
        type: 'POST',
        data:khoa,
        url: '/giangvien/ds-gv-by-khoa',
        success: function (response) {
            console.log(JSON.stringify(response));
            response = $.parseJSON(response);
            $('#tree_GV').bstreeview({
               data: response,
                expandIcon: 'fa fa-angle-down fa-fw',
                collapseIcon: 'fa fa-angle-right fa-fw',
                indent: 1.25,
                parentsMarginLeft: '1.25rem',
                openNodeLinkOnNewTab: true
            });
            listGV = document.querySelectorAll('[aria-level="2"]');
            $.each(listGV, function (i, item) {
                console.log(JSON.stringify(item));
            });

            $.each(listGV, function (i, item) {
                item.addEventListener('click', function (e) {
                    nodeCurrent = item;

                    if (nodeTree != nodeCurrent) {
                        document.getElementById("titleLTC").innerHTML = "Danh sách lớp tín chỉ của GIẢNG VIÊN: " + item.innerHTML;
                        nodeCurrent.style.background = "#ccc";
                        console.log('Click happened for: ' + item.id);
                        if (nodeTree != null) {
                            nodeTree.style.background = "#ffffff"
                            nodeTree = item;
                        }
                        nodeTree = item;   
                    }
                    else {

                    }
                });
            });
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}