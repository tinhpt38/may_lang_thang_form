function alertMessage(text) {
    alert(text)
    Email.send({
 	Host: "smtp.gmail.com",
 	Username : "tinhpt.38@gmail.com",
 	Password : "bvochkfeuruehsiv",
 	To : 'tinhpt.contact@gmail.com',
 	From : "tinhpt.38@gmail.com",
 	Subject : "email form flutter",
 	Body : text,
 	}).then(
         message => alert("mail sent successfully")
         
    );
    // debugger;
}

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}