<%@LANGUAGE="vbscript" CODEPAGE="65001"%>

<%
Dim connStr
connStr = Application("CONNECTION_STRING")
' confirm connection:  
Dim fname, lname, uname, userEmail, pwEntry1, pwEntry2, submitted

fname = Request.Form("fname")
lname = Request.Form("lname")
uname = Request.Form("uname")
userEmail = Request.Form("userEmail")
pwEntry1 = Request.Form("pwEntry1")
pwEntry2 = Request.Form("pwEntry2")
submitted = Request.Form("SubmitForm")


'add parameters for each name after testing.   
Function displayData()
    If submitted <> "" Then 
        response.write("<p>" & fname & "" & lname & "" & uname & "" & userEmail)
            If pwEntry1 <> pwEntry2 Then 
                response.write("Passwords Don't match!")
                Response.End 
            End If 
    End If 
End Function

%>

<html>
    <head> 
        <title>Register</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="resources/styles.css">
    </head>


<body>
    <div class = "headingSection">
        <h1>Register Form</h1>
    </div>


    <div class = "registerFormContent">

        <form name="registerForm" method="POST" action="Register.asp" autocomplete="off" id="regForm">
            <table border="1px solid black" style="background:lightgrey;"> 
                <th style="color: #22d1ee; font-size: 2em;">Register</th>
                <tr>
                    <td>First Name: <input type="text" name="fname"></td>
                </tr>
                <tr>
                    <td>LastName: <input type="text" name="lname"></td>
                </tr>
                <tr>
                    <td>User Name: <input type="text" name="uname"></td>
                </tr>
                <tr>
                    <td>Email: <input type ="email" name="userEmail"></td> 
                </tr>
                <tr>
                    <td>Password: <input type="password" name="pwEntry1"></td>
                </tr>
                <tr>
                    <td>Confirm Password <input type="password" name="pwEntry2"></td>
                </tr>
                <tr>
                    <td><input type="submit" name="SubmitForm" value="Click to submit..." onclick="<%displayData%>"></td>
                </tr>
            </table> 
        </form>
    </div>

</body>
</html>

