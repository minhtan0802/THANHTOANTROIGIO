$(document).ready(function () {
    $.ajax({
        async: true,
        type: 'GET',
        data: "",
        url: '/login/user',
        success: function (response) {
            if (response.success == true) {
                document.getElementById("user").innerHTML = response.data;
            }
        },
        error: function () {
            toastr.error('Lỗi rồi', 'Error Alert', { timeOut: 3000 });
        }

    });
});
