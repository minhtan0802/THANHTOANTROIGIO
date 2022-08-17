var u;
$(document).ready(function () { $("#btnLogin").click(function () {login(); }); });
function login() {
    var username = $("#username").val();
    var password = $("#password").val();
    if (username.toString().trim() == null) {
        toastr.error("Không được để trống username", "Lỗi", { timeOut: 3000 });
        $("#username").focus();
        return;
    }
    if (password.toString().trim() == null) {
        toastr.error("Không được để trống password", "Lỗi", { timeOut: 3000 });
        $("#password").focus();
        return;
    }
    $.ajax({
        async: true,
        type: 'POST',
        data: { username: username, password: password },
        url: '/login/validate',
        success: function (response) {
            if (response.success == true) {
              //  toastr.success("Đăng nhập thành công!", "Thông báo", { timeOut: 1000 });
                window.location.href = "/"; //will redirect to product (an ex: blog.html)

            };
            if (response.success == false) {
                console.log("In ra lỗi: " + response.message);
                toastr.error(response.message, "Đăng nhập thất bại", { timeOut: 3000 });
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }
    });
}