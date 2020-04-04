function round(value, precision) {
	if (Number.isInteger(precision)) {
	  var shift = Math.pow(10, precision);
	  return Math.round(value * shift) / shift;
	} else {
	  return Math.round(value);
	}
} 

window.addEventListener('message', function (event) {
    var item = event.data;
	
		
    if (item.clear == true) {
        $(".items").empty();
    }
    if (item !== undefined && item.display == true) {
		
		var xhr = new XMLHttpRequest();
		xhr.responseType = "text";
		xhr.open('GET', event.data.steamid, true);
		xhr.send();
		xhr.onreadystatechange = processRequest;
		function processRequest(e) {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var string = xhr.responseText.toString();
				var array = string.split("avatarfull");
				var array2 = array[1].toString().split('"');
				$('#avatar').attr('src', array2[2].toString());
			}
		}
		
		$('#playerid').text(event.data.playerid);
		$('#hovaten').text(event.data.name);
		$('#gioitinh').text(event.data.sex);
		$('#chieucao').text(event.data.height);
		$('#ngaysinh').text(event.data.dateofbirth);
		$('#congviec').text(event.data.job);
		$('#sodienthoai').text(event.data.phone_number);
		$('#sotienmat').text(event.data.money);
		$('#nganhang').text(event.data.bank);
		$('#sotienban').text(event.data.black_money);
		/*
		$('#solanditu').text(event.data.solanditu);
		$('#solandilaodong').text(event.data.solandilaodong);
		*/
			
		var stamina_elem = document.getElementById("staminaBar"); 
		var stamina_elem_info = document.getElementById("staminaInfo"); 
		var strength_elem = document.getElementById("strengthBar"); 
		var strength_elem_info = document.getElementById("strengthInfo"); 
		var shooting_elem = document.getElementById("shootingBar"); 
		var shooting_elem_info = document.getElementById("shootingInfo"); 
		var driving_elem = document.getElementById("drivingBar"); 
		var driving_elem_info = document.getElementById("drivingInfo"); 
		var fishing_elem = document.getElementById("fishingBar"); 
		var fishing_elem_info = document.getElementById("fishingInfo"); 
		var drugs_elem = document.getElementById("drugsBar"); 
		var drugs_elem_info = document.getElementById("drugsInfo"); 
		   
		  
		if (event.data.stamina !== undefined && event.data.stamina <= 100) {
			stamina_elem_info.innerHTML = round(event.data.stamina, 2) + '%';
			stamina_elem.style.width = event.data.stamina + '%'; 
			stamina_elem_info.value = event.data.stamina + '%';
		}
		else
		{
			stamina_elem_info.innerHTML = '100%';
			stamina_elem.style.width = '100%'; 
			stamina_elem_info.value = '100%';
		}
		
		if (event.data.strength !== undefined && event.data.strength <= 100) {
			strength_elem_info.innerHTML = round(event.data.strength, 2) + '%';
			strength_elem.style.width = event.data.strength + '%'; 
			strength_elem_info.value = event.data.strength + '%';
		}
		else
		{
			strength_elem_info.innerHTML = '100%';
			strength_elem.style.width = '100%'; 
			strength_elem_info.value = '100%';
		}
		
		if (event.data.driving !== undefined && event.data.driving <= 100) {
			driving_elem_info.innerHTML = round(event.data.driving, 2) + '%';
			driving_elem.style.width = event.data.driving + '%'; 
			driving_elem_info.value = event.data.driving + '%';
		}
		else
		{
			driving_elem_info.innerHTML = '100%';
			driving_elem.style.width = '100%'; 
			driving_elem_info.value = '100%';
		}
		
		
		if (event.data.shooting !== undefined && event.data.shooting <= 100) {
			shooting_elem_info.innerHTML = round(event.data.shooting, 2) + '%';
			shooting_elem.style.width = event.data.shooting + '%'; 
			shooting_elem_info.value = event.data.shooting + '%';
		}
		else
		{
			shooting_elem_info.innerHTML = '100%';
			shooting_elem.style.width = '100%'; 
			shooting_elem_info.value = '100%';
		}
		
		if (event.data.fishing !== undefined && event.data.fishing <= 100) {
			fishing_elem_info.innerHTML = round(event.data.fishing, 2) + '%';
			fishing_elem.style.width = event.data.fishing + '%'; 
			fishing_elem_info.value = event.data.fishing + '%';
		}
		else
		{
			fishing_elem_info.innerHTML = '100%';
			fishing_elem.style.width = '100%'; 
			fishing_elem_info.value = '100%';
		}
		
	   if (event.data.drugs !== undefined && event.data.drugs <= 100) {
			drugs_elem_info.innerHTML = round(event.data.drugs, 2) + '%';
			drugs_elem.style.width = event.data.drugs + '%'; 
			drugs_elem_info.value = event.data.drugs + '%';
		}
        else
		{
			drugs_elem_info.innerHTML = '100%';
			drugs_elem.style.width = '100%'; 
			drugs_elem_info.value = '100%';
		} 
		
        $(".container").fadeIn(100);
		return;
    }
    if (item.display == false) {
        $(".container").fadeOut(100);
    }
});

document.addEventListener('DOMContentLoaded', function () {
    $(".container").hide();
});
