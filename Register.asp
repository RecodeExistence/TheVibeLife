<%@Language="VBSCRIPT" CODEPAGE="65001"%>

<html> 
<script type="text/javascript">
function addError(strError, ele){
    document.body.append(`${strError}`)
   ele.forEach(errorElement => errorElement.style.background="pink"); 
   return false; 
}


function confirmThis(e) {
    let hasErrors = false;
    let errorsArray = []; 
    let elements = e.elements;  
    for(let i = 0; i < elements.length;i++) {
            if(!e.elements[i].value.length) {
                errorsArray.push(e.elements[i]);  
            }
        }  
    if(errorsArray.length !== 0) {
        hasErrors = true; 
        console.log(errorsArray); 
    }

    if(hasErrors) {
        addError("You missed some fields.  Check the form and correct before resubmitting. ", errorsArray);
        return false;
    } else {
        alert("All checks passed"); 
    }
}

</script>
<body>
<form name="registerForm" action="Register.asp" method="POST">
<table style="width: 200px; border: 1px solid black;" align="center;"> 
    <tr><td><label for="username">Username:</label> <input type ="text" name="username"></td></tr>
    <tr><td><label for="emailAddress">Email Address: </label><input type ="text" name="emailAddress"></td></tr>
    <tr><td><label for="password1">Password: </label><input type ="password1" name="password1"></td></tr>
    <tr><td><label for="password2">Confirm Password: </label><input type ="password1" name="password2"></td></tr>
    <tr><td><input type ="Submit" name="btnSubmit" style="width:176px" align="center" onclick="return confirmThis(this.form)" value="Submit"></td></tr>
</table>
</form>

</body>
</html> 