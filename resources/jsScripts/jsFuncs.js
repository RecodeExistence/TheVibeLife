function addError(strError, ele){
    alert(strError); 
    ele.forEach(errorElement => errorElement.style.background="pink"); 
    return false; 
}

function confirmThis(e) { 
    let bMissingFields = false; 
    let bHasErrors = false;
    let strErrorString = ""; 
    let arrErrorElements = []; 
    const elements = e.elements;
    const pass1 = elements["password1"].value; 
    const pass2 = elements["password2"].value; 

//=============================================================================================
//Handle missing fields. 
    for(let i = 0; i < elements.length;i++) {
        if(!elements[i].value.length) {
            if(bMissingFields === false) {
                bMissingFields = true;
            }  
            arrErrorElements.push(e.elements[i]); 
        }
    }
    if(bMissingFields) {
        strErrorString += `\nYou have missed some fields.  Ensure all are filled out before submitting.`;<%=vbcrlf%>
    }
//==============================================================================================
//Handle incorrect data types.  
    if(elements["username"].value.length === 0) {
        strErrorString += `You haven't entered a username!`;<%=vbNewLine%>
        bHasErrors = true;  
    }
    if(typeof elements["username"].value != "string") { 
        strErrorString += `Your chosen username cannot contain special characters or numbers.`;<%=vbcrlf%>
        arrErrorElements.push(elements["username"]);
        bHasErrors = true; 
    }
    if(typeof elements["emailAddress"].value != "string") {
        strErrorString = strErrorString + `\nYour entered email address is invalid.  Check and enter again.`;<%=vbcrlf%>
        arrErrorElements.push(elements["emailAddress"]); 
        bHasErrors = true;  
    }
//===============================================================================================
// Handle passwords not matching.  
    if(pass1 !== pass2 || (!pass1.length || !pass2.length)) {
        strErrorString += `Your passwords do not match.  Check and enter again.`;<%=vbcrlf%> 
        arrErrorElements.push(elements["password1"]); 
        arrErrorElements.push(elements["password2"]);
        bHasErrors = true; 
    }
    
    if(bHasErrors) {
        addError(strErrorString, arrErrorElements);
        return false;
    }             
}