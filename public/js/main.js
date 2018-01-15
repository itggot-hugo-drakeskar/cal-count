function functionName() {
    var request = new XMLHttpRequest();
    var newData = new FormData();
    newData.append("params_name", document.getElementById("ID").value);
    request.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            //recieved information from server
        }
    };
    request.open("POST", "/post_name", true);
    request.send(newData);
};

function add_cal() {
    document.getElementById("id_food").value = document.getElementById("foods").value;
    document.getElementById("amount_food").value = document.getElementById("amount").value;
    document.getElementById("food_form").submit();
    console.log("test")
}