const price1 = 3990000;
const price2 = 33490000;
var quantity1 = 1;
var quantity2 = 1;
var totalPrice = 0;
const formatter = new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND'
});

function increaseQuantity(elementId, quantity) {
    quantity++;
    if (elementId === "quantity1") {
        quantity1 = quantity;
    } else if (elementId === "quantity2") {
        quantity2 = quantity;
    }
    document.getElementById(elementId).value = quantity;
}

function decreaseQuantity(elementId, quantity) {
    if (quantity > 1) {
        quantity--;
        if (elementId === "quantity1") {
            quantity1 = quantity;
        } else {
            quantity2 = quantity;
        }
        document.getElementById(elementId).value = quantity;
    }
}


function totalPrice1(price, quantity) {
    var element1 = document.getElementById("check1");

    if (element1.checked) {
        let total1 = price * quantity;
        totalPrice += total1;
        document.getElementById("total1").innerHTML = formatter.format(totalPrice);
    } else {
        console.log(element1.checked)
        totalPrice = totalPrice - (price * quantity);
        if (totalPrice >= 0) {
            document.getElementById("total1").innerHTML = formatter.format(totalPrice);
        } else {
            document.getElementById("total1").innerHTML = formatter.format(0);
        }
    }
}


function totalPrice2(price, quantity) {
    var element2 = document.getElementById("check2");

    if (element2.checked) {
        let total1 = price * quantity;
        totalPrice += total1;
        document.getElementById("total1").innerHTML = formatter.format(totalPrice);
    } else {
        totalPrice = totalPrice - (price * quantity);
        if (totalPrice > 0) {
            document.getElementById("total1").innerHTML = formatter.format(totalPrice);
        } else {
            document.getElementById("total1").innerHTML = formatter.format(0);
        }
    }
}

