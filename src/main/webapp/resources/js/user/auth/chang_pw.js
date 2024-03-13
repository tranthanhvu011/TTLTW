// let new_pw = document.getElementById("new_pw");
// let old_pw = document.getElementById("old_pw");
// let re_new_pw = document.getElementById("re_new_pw");
// let er_opw = document.getElementById("er_opw");
// let er_npw = document.getElementById("er_npw");
// let er_re_npw = document.getElementById("er_re_npw");
//
// let btn_chang_pw = document.getElementById("form_change_pw");
//
// btn_chang_pw.addEventListener("submit", function (e) {
//     e.preventDefault();
//
//     var isValidate = validateOldPassword() && validateNewPassword() && validateReNewPassword();
//     if(isValidate){
//         alert("Đổi mật khẩu thành công");
//     }
// });
//
// // create minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
// function validatePassword(pass) {
//     const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
//     return String(pass.value).match(re);
// }
//
// function validateOldPassword() {
//     if (old_pw.value !== "123") {
//         er_opw.innerHTML = "Mật khẩu không chính xác";
//         return false;
//     } else {
//         er_opw.innerHTML = "";
//         return true;
//     }
// }
//
// function validateNewPassword() {
//     if (new_pw.value === old_pw.value) {
//         er_npw.innerHTML = "Mật khẩu mới không được trùng với mật khẩu cũ";
//         return false;
//     } else if (validatePassword(new_pw) === null) {
//         er_npw.innerHTML = "Mật khẩu mới phải có ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt";
//         return false;
//     } else {
//         er_npw.innerHTML = "";
//         return true;
//     }
// }
//
// function validateReNewPassword() {
//     if (re_new_pw.value !== new_pw.value) {
//         er_re_npw.innerHTML = "Mật khẩu không trùng khớp";
//         return false;
//     } else {
//         er_re_npw.innerHTML = "";
//         return true;
//     }
// }
<<<<<<< HEAD
//
=======

>>>>>>> 6079202f0e2cd5ac581dfadad11b7a093f51f987
