<%@LANGUAGE="vbscript" CODEPAGE="65001"%>

<%
    
%>

<html>
    <head> 
        <title>Register</title>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="./styles.css">
    </head>


<body>
    <div class = "headingSection">
        <h1>Register Form</h1>
    </div>

    <!-- Messy, but we can tidy up the form layout later once we get the data moving. -->
    <div class = "registerFormContent">
        <table border="1px solid black" style="background:lightgrey;"> 
            <th>test</th>
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
                <td>Confirm Password <input type="password" name="pwEntry2"</td>
            </tr>
            <tr>
                <td>Submit <input type="submit" name="SubmitForm"</td>
            </tr>
        </table> 
    </div>
</body
</html>

