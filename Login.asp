<%@LANGUAGE="vbscript" CODEPAGE="65001"%><!--#include file="sessionStore.asp"-->
<%
Session.Abandon
Dim strUserNameorEmail, strPassW, btnSubmit 
strUserNameorEmail = Request.Form("userNameorEmail")
strPassW = Request.Form("usersPassword")
btnSubmit = Request.Form("btnSubmit")

If Request.Form("btnSubmit") <> ""  Then 
    If strUserNameorEmail = "" Then
        Response.write("oops.  you didn't enter a username.")
    ElseIf strPassW = "" Then 
        Response.write("oops.  you didn't enter a password.")
    End If 

End If 
%>

<html> 
<head> 
    <title>Login</title> 
    <link rel="stylesheet" type="text/css" href="resources/styles.css">
</head>

<body>
    <div class="loginContainer">
        <table align="center" colspan="8" style="border:1px solid black;">
        <th><h1>TheVibeLife - Login</h1></th>
        <tr>
            <td><p>Welcome.  Have you signed up for an account yet? If not, please visit the <a href="<%=redirect("Register.asp")%>">Register Page</a></td>
        </tr>
        </tr>
        <td align="center">
            <form name="loginForm"  action="Login.asp" method="POST"> 
                <table>
                        <tr><td><label for="userName">Username or Email Address<input type="text" name="userName"/></label></td></tr>
                        <tr><td><label for="Password">Password<input type="password" name="usersPassword"/></label></td></tr>
                        <tr><td><label for="btnSubmit"><input type="submit" name="btnSubmit" class="btnSubmit" value="Login now"/></label></td></tr>
                </table>
        </form>
        </td>
        </tr>
        </table>
    </div>
</body> 
<html> 

<script language=vbscript runat=server>

</script> 