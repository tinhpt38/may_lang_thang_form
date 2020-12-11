function alertMessage(text, callback) {
    
    Email.send({
 	Host: "smtp.gmail.com",
 	Username : "tinhpt.38@gmail.com",
 	Password : "bvochkfeuruehsiv",
	 To : 'maylangthang.contact@gmail.com',
	// To : 'tinhpt.contact@gmail.com',
 	From : "tinhpt.38@gmail.com",
 	Subject : "Email đặt chỗ ngồi show diễn tại Mây Lang Thang",
 	Body : text,
 	}).then(
         message => callback()
    );
}

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}