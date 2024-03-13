const formatter = new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND'
});

function validateForm() {
    var emailPaypal = document.getElementById("pay-by-email-paypal").value;
    var carNumber = document.getElementById("cardNumberVisa").value;
    var numberPattern = /^[0-9]*$/;
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    var optionPaypal = document.getElementById("flexRadioDefault1");
    var optionVisa = document.getElementById("flexRadioDefault");
    var numberDate = document.getElementById("numberDate").value;
    var numberCVV = document.getElementById("cvv").value;
    var checkDate = /^(0[1-9]|1[0-2])\/\d{2}$/;
}

function showVisaForm() {
    var form = document.getElementById('visaForm');
    var option = document.getElementById('flexRadioDefault');
    var option1 = document.getElementById('flexRadioDefault1');
    if (option.checked) {
        form.style.display = 'block';
        document.getElementById('paypalForm').style.display = 'none';
    } else if (option1.checked) {
        document.getElementById('paypalForm').style.display = 'block';
        form.style.display = 'none';
    } else {
        form.style.display = 'none';
        document.getElementById('paypalForm').style.display = 'none';

    }
}


