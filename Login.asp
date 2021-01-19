<%@LANGUAGE="vbscript" CODEPAGE="65001"%><!--#include file="sessionStore.asp"-->
<%
Session.Abandon
Dim strUserName, strPassW, btnSubmit
CONST eUserID = 0

strUserName = Request.Form("userName")
strPassW = Request.Form("usersPassword")
btnSubmit = Request.Form("btnSubmit")
iCommandId = Request.Form("cmdID")

SELECT CASE iCommandID
    Case 1
    LoadUsers
End SELECT 

Sub LoadUsers
If iCommandId = 1 AND btnSubmit <> "" Then 
    Dim objRs, strSql, arrResults, bHasResults, stUname
    strSql = "SELECT userIdNum FROM dbo.tbl_Users WHERE userName=" + "'" + strUserName + "'" & "and userPassHash=" & "'" & strPassW & "'"  
    Set objRs = objConn.Execute(strSql, ,adCmdText)
       If NOT objRs.EOF Then 
           bHasResults = True
           arrResults = objRs.GetRows
           iResults = UBound(arrResults, 2)
           If iResults = 0 Then
                Response.write("<p>Success! UserId: " & arrResults(eUserID, iResults) & "</p>")
            Else 
                Response.write("<p>No user Found by that name.</p>")
           End If
        objRs.Close
    Set objRs = Nothing
    End If 
End If
End Sub
%>
<script type="text/javascript">
    function updateCmd(ele) {
        ele.cmdID.value = 1; 
    }

</script>

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
                <input type="hidden" name="cmdID" id="cmdID" value="0">
                <table>
                        <tr><td><label for="userName">Username or Email Address<input type="text" name="userName"/></label></td></tr>
                        <tr><td><label for="Password">Password<input type="password" name="usersPassword"/></label></td></tr>
                        <tr><td><label for="btnSubmit"><input type="submit" name="btnSubmit" class="btnSubmit" value="Login now" onclick="updateCmd(this.form)"/></label></td></tr>
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