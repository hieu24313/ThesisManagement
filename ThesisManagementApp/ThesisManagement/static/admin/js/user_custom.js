window.onload = () => {
// Tạo một thẻ li mới
var newLi = document.createElement("li");

// Tạo một thẻ a bên trong thẻ li mới
var newLink = document.createElement("a");
newLink.setAttribute("href", "/admin/add-more-users/");
newLink.setAttribute("class", "addlink");
newLink.textContent = "Add user by excel file";

// Thêm thẻ a vào thẻ li mới
newLi.appendChild(newLink);

// Lấy ra danh sách ul có class là "object-tools"
var ulObjectTools = document.querySelector("#content-main .object-tools");

// Thêm thẻ li mới vào danh sách ulObjectTools
ulObjectTools.appendChild(newLi);
}