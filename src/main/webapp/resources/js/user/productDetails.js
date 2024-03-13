
var price = 0;
// document.getElementById('tamtinh').textContent=price+'₫';
var items = document.querySelectorAll(".imageOrder img");
var preview = document.getElementById("image-main");
var elements = document.querySelectorAll('.mau .hinhanh img');
items.forEach(item => {
    item.addEventListener("click", e => {
        preview.src = e.target.src
    })
})
elements.forEach(itemss => {
    itemss.addEventListener("click", e => {
        preview.src = e.target.src
    })
})

items.forEach(item => {
    item.addEventListener("mouseover", e => {
        preview.src = e.target.src
    })
})
//     function aaddBorder(element) {
//         // Remove border from all elements with class "hinhanh"
//         var elements = document.querySelectorAll('.hinhanh');
//         elements.forEach(function(el) {
//             el.classList.remove('selected');
//         });
//
//         // Add border to the clicked element
//         element.classList.add('selected');
// }
// document.addEventListener('DOMContentLoaded', function() {
//
//     const btnPlus = document.querySelector('.btn-plus');
//     const btnMinus = document.querySelector('.btn-minus');
//     const quantityInput = document.querySelector('.quantity-input');
//     var totalPriceElement = document.getElementById('tamtinh');
//     var originalValue = parseFloat(totalPriceElement.textContent.replace(/[^\d.]/g, ''));
//
//     btnPlus.addEventListener('click', function() {
//         let currentValue = parseInt(quantityInput.value);
//         quantityInput.value = currentValue + 1;
//         let newValue = price * quantityInput.value;
//         totalPriceElement.textContent = newValue.toLocaleString('en-US')+'₫';
//     });
//
//     btnMinus.addEventListener('click', function() {
//         let currentValue = parseInt(quantityInput.value);
//         if (currentValue > 1) {
//             quantityInput.value = currentValue - 1;
//             let newValue = price * quantityInput.value;
//             totalPriceElement.textContent = newValue.toLocaleString('en-US')+'₫';
//         }
//     });
// });
//
//
// // function changePrice(newPrice) {
// //     document.getElementById("price").innerText = newPrice;
// // }
// function changeColorAndPrice(price, color) {
//     document.getElementById('soluong').value = 1;
//     changePrice(price);
// }
//
// function changeCapacity(capacity) {
//
//
//     // Get the selected color
//     const selectedColor = document.querySelector('.hinhanh.active')?.innerText.trim();
//
//     // Set different prices based on selected capacity and color
//     switch (selectedColor) {
//         case 'Xanh':
//             switch (capacity) {
//                 case '64GB':
//                     price = 50000000; // Set the price for 64GB - Xanh
//                     break;
//                 case '128GB':
//                     price = 70000000; // Set the price for 128GB - Xanh
//                     break;
//                 case '256GB':
//                     price = 90000000; // Set the price for 256GB - Xanh
//                     break;
//                 default:
//                     price = 0;
//             }
//             break;
//         case 'Đỏ':
//             switch (capacity) {
//                 case '64GB':
//                     price = 60000000; // Set the price for 64GB - Đỏ
//                     break;
//                 case '128GB':
//                     price = 80000000; // Set the price for 128GB - Đỏ
//                     break;
//                 case '256GB':
//                     price = 100000000; // Set the price for 256GB - Đỏ
//                     break;
//                 default:
//                     price = 0;
//             }
//             break;
//         default:
//             price = 0;
//     }
//
//     changePrice(`${price.toLocaleString()}₫`);
// }
//
// function changePrice(newPrice) {
//     const priceDisplay = document.getElementById('price');
//     var totalPriceElement = document.getElementById('tamtinh');
//     priceDisplay.textContent = ` ${newPrice}`;
//     totalPriceElement.textContent =` ${newPrice}`;
//
// }
//
// // Function to add or remove 'active' class on color selection
// function addBorder(element) {
//     const elements = document.querySelectorAll('.hinhanh');
//     elements.forEach(el => el.classList.remove('active'));
//     element.classList.add('active');
//
//
//     elements.forEach(function(el) {
//         el.classList.remove('selected');
//     });
//
//
//     // Add border to the clicked element
//     element.classList.add('selected');
// }
// document.addEventListener('DOMContentLoaded', function() {
//     const defaultChoice = document.querySelector('.hinhanh:first-child'); // Chọn mục đầu tiên
//     addBorder(defaultChoice); // Thêm lớp 'active' khi trang được tải
//     defaultChoice.classList.add('selected'); // Thêm lớp 'selected' khi trang được tải
// });

