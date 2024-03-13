let f_name = document.getElementById("f_name");
let l_name = document.getElementById("l-name");
let dob = document.getElementById("dob");
let email = document.getElementById("email");
let phone = document.getElementById("phone");
let pass = document.getElementById("pass");
let repass = document.getElementById("re-pass");
let address = document.getElementById("address");
let er_f_name = document.getElementById("er-f-name");
let er_l_name = document.getElementById("er-l-name")
let er_dob = document.getElementById("er-dob");
let er_email = document.getElementById("er-email");
let er_phone = document.getElementById("er-phone");
let er_pass = document.getElementById("er-pass");
let er_repass = document.getElementById("er-re-pass");
let er_address = document.getElementById("er-address");
let er_login = document.getElementById("er-login");
const elements = [f_name, l_name, dob, address];
const er_elements = [er_f_name, er_l_name, er_dob, er_address];

// create function validate register
function validateRegister() {
    for (var i = 0; i < elements.length; i++) {
        if (validateTextEmpty(elements[i])) {
            showError(er_elements[i], "Vui lòng không để trống thông tin!");
        } else {
            er_elements[i].innerHTML = "";
        }
    }

    if (validateEmail(email) === null) {
        showError(er_email, "Email không hợp lệ!");
    } else {
        er_email.innerHTML = "";
    }

    if (validatePassword(pass) === null) {
        showError(er_pass, "Mật khẩu phải có ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường và 1 số và 1 ký tự đặc biệt!");
    } else {
        er_pass.innerHTML = "";
    }

    if (validatePhoneNumberVN(phone) === null) {
        showError(er_phone, "Số điện thoại không hợp lệ!");
    } else {
        er_phone.innerHTML = "";
    }

    if (!validateRePassword(pass, repass)) {
        showError(er_repass, "Mật khẩu không trùng khớp!");
    } else {
        er_repass.innerHTML = "";
    }
}

// create function validate text empty
function validateTextEmpty(element) {
    return element.value === "";

}

// create function show error
function showError(element, mess) {
    element.innerHTML = mess;
}

//create function validate email
function validateEmail(email) {
    const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return String(email.value).toLowerCase().match(re);
}

// create minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
function validatePassword(pass) {
    const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    return String(pass.value).match(re);
}

// create function validate phone number in vietnam include start with 84 or 0
function validatePhoneNumberVN(phone) {
    const re = /^(84|0[3|5|7|8|9])+([0-9]{8})$/;
    return String(phone.value).match(re);
}

function validateRePassword(pass, repass) {
    if (pass.value === repass.value) return true;
    return false;
}

// check register to redirect to login page
function confirmRegister(event) {
    event.preventDefault();
    validateRegister();
}

function setValueToGender(x) {
    selectedButton.value = x;
    if (x === 1) {
        nam.style.backgroundColor = "greenyellow";
        nu.style.backgroundColor = "white";
    } else {
        nu.style.backgroundColor = "greenyellow";
        nam.style.backgroundColor = "white";
    }
    console.log(selectedButton.value)
}


document.getElementById("onSubmit").addEventListener('submit', confirmRegister);