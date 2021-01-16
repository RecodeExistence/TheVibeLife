<%@Language="VBSCRIPT" CODEPAGE="65001"%><!--#include file="sessionStore.asp"-->
<%  Dim strWelcomeMessage
    Dim strSql
    Dim strUserName, strEmailAddress, strPassword1, bSubmit, iCommandID
    strUserName = CStr(Request.Form("username")) 
    strEmailAddress = CStr(Request.Form("emailAddress"))
    strPassword1 = CStr(Request.form("password1"))
    bSubmit = Request.Form("btnSubmit")

If Request.QueryString("cmdID").Count > 0 Then 
    iCommandID = CLng(Request.QueryString("cmdID"))
ElseIf Request.Form("cmdID").Count > 0 Then  
    iCommandID = CLng(Request.Form("cmdID"))
Else 
    iCommandID = 0
End If

Select Case iCommandID
    Case 0 
    LoadPage

End Select 
Response.write(iCommandID)


addUser
%> 
<script type="text/javascript"> 
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
</script> 

<html> 
<head> 
    <title>Register</title>
</head>

<body>
    <table align="center" colspan="8" style="border:1px solid black;">
    <th><h1> Welcome to TheVibeLife </h1></th>
    <tr>
        <td><p>We're glad to have you here.  If you want to join, please register below.</p></td>
    </tr>
    <tr>
        <td align="center">
            <form name="registerForm" action="Register.asp" method="POST">
            <table style="width: 200px; border: 1px solid black;" align="center;"> 
                <tr><td><label for="username">Username:</label> <input type ="text" name="username" ></td></tr>
                <tr><td><label for="emailAddress">Email Address: </label><input type ="email" name="emailAddress"></td></tr>
                <tr><td><label for="password1">Password: </label><input type ="password" name="password1"></td></tr>
                <tr><td><label for="password2">Confirm Password: </label><input type ="password" name="password2"></td></tr>
                <tr><td><input type ="Submit" name="btnSubmit" style="width:176px" align="center" onclick="return confirmThis(this.form)" value="Register Now!"></td></tr>
            </table>
            </form>
        </td>
    </tr>
</body>
</html>

<script language=vbscript runat=server>
Sub LoadPage 
    If btnSubmit = "" Then 
        strWelcomeMessage = "Welcome, please use the form below to register."
    Else 
        strWelcomeMessage = "Thank you for registering" + strUserName + ", please go ahead and login."
    End If 
End Sub

Sub addUser
Dim redirectLink
    If bSubmit <> "" Then 
        If strUserName <> "" AND strEmailAddress <> "" AND strPassword1 <> "" Then 
                strSql = "INSERT INTO dbo.tbl_Users (userName, userEmailAdd, userPassHash) VALUES (" + "'" + strUserName + "'," + "'" + strEmailAddress + "'," + "'" + strPassword1 + "'" + ")"
                objConn.Execute strSql, , adCmdText
                objConn.Close
            Set objConn = Nothing
        redirectLink = redirect("Login.asp")
        response.write("Awesome, you're all set!  Please proceed to <a href=" + redirectLink +">Login</a>, and sign in using your shiny new account details!")
        End If 
    End If 
End Sub
</script>