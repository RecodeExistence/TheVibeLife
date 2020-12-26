<%@LANGUAGE="vbscript" CODEPAGE="65001"%>

<%
    ' This is the ASP logic bit.  But, i'll be back in a wee moment, going to pour a coffee xD  
    Dim firstName, lastName, userName, userEmail, passWord 

    firstName = Request.Form("fname")
    lastName = Request.Form("lname")
    userName = Request.Form("userName")
    userEmail = Request.Form("userEmail")
    passWord = Request.Form("pwEntry2")
    

    If Request.Form("SubmitForm") <> "" Then ' this should sort the data loading as soon as the page loads.  waits for the submit button to actually be pressed.  
        Response.write("<p>Form Data display:  " & firstName & " " & lastName & " " & userName & " " & userEmail & " " & passWord & " </p>")
    Else 
        response.write("<p>Something went wrong...</p>")
    End If 
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

    <!-- Messy, but we can tidy up the form layout later once we get the data moving. -->
    <div class = "registerFormContent">

        <form name="registerForm" method="POST" action="Register.asp" align="center" autocomplete="off">
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
                    <td>Submit <input type="submit" name="SubmitForm"></td>
                </tr>
            </table> 
        </form>
    </div>

</body>
</html>

