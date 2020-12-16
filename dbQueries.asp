<%@Language="vbscript" codepage="65001"%>
<% 
Dim objConn, objRs, connStr, strSql
Dim name, pass, addBtn, removeBtn, lookupBtn
Dim bHasResults, iResults, arrResults
Dim commandID

CONST eUserID = 0 
CONST eUserName = 1
CONST ePassW = 2

connStr = Application("CONNECTION_STRING")
name = Request.Form("username")
pass = Request.Form("password")
addBtn = Request.Form("addBtn")  
removeBtn = Request.Form("removeBtn")
lookupBtn = Request.Form("lookupBtn")

If Request.Form("cmdID").Count > 0 Then 
  iCommandID = CLng(Request.Form("cmdID"))
ElseIf Request.QueryString("cmdID").Count > 0 Then 
  iCommandID = Clng(Request.QueryString("cmdID"))
Else 
  iCommandID = 0
End If 
response.write(iCommandID)

SELECT Case iCommandID
    Case 0
    ' Default load of data.
     loadData  
    response.write("data loaded.")
    Case 1
    ' Insert data
    addUser
    loadData
    Case 2
    ' Update data
    editUser
    Case 4
    ' Delete data
    deleteUser
    Case 6 
    ' a lookup, in our testing case will redirect to a logged in page and set session variables.  
    searchUser 
End Select 

Sub loadData ' TODO: DO some RESEARCH ON THIS TO MAKE SURE I'M USING IT RIGHT. 
  strSql = "SELECT userName, passW FROM dbo.userLogins"
  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open connStr

  Set objRs = Server.CreateObject("ADODB.Recordset")
  objRs.Open  strSql, objConn 
End Sub 

Sub addUser
If addBtn <> "" Then ' new logic here to ensure that the button has actually been pressed before carrying out the ADO operations.  
    strSql = "INSERT INTO dbo.userLogins (userName, passW) VALUES (" & "'" & name & "', " & "'" & pass & "'" & ")"
      If name <> "" AND pass <> "" Then 
        Set objConn = Server.CreateObject("ADODB.Connection")
          objConn.Open(connstr)
          objConn.Execute strSql, , adCmdText
          objConn.Close 
        Set objConn = Nothing
        iCommandID=0
        loadData
    Else 
      strError = "alert(Something went wrong!)"
      insertUser = response.write(strError)
    End If
  End If ' end of new logic encapsulation.  
End Sub

'Sub editUser
  'TODO: Create data to update current user record by values from the form. 
  ' Set objConn = Server.CreateObject("ADODB.Connection")
 ' 'strSql = "UPDATE dbo.userLogins WHERE userName =" & "'" & username & "'" & " AND passW =" & "'" & password & "'" & _
           ' '"SET userName = "
' End Sub 

Sub deleteUser
If removeBtn <> "" Then  
  strSql = "DELETE FROM dbo.userLogins WHERE userName =" & "'" & name & "'"

  Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open(connstr)
    objConn.Execute strSql, , adCmdText
    objConn.Close
    Set objConn = Nothing
    iCommandID=0
    loadData
End If 
End Sub

Sub searchUser
If lookupBtn <> "" Then 

  strSql = "Select * FROM dbo.userLogins WHERE userName = " & "'" & name & "'" & "AND passW =" & "'" & pass & "'"
  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open(connstr)
    Set objRs = objConn.Execute(strSql, , adCmdText)
      
      If objRs.EOF Then 
        response.write("<p>User Not Found.</p>")
      Else 
        Session("loggedIn") = True
        Session("userName") = objRs("userName")
        Session("passw") = objRs("passW")
        Response.Redirect("./LoggedIn.asp")
      End If 
    objRs.Close
  Set objRs = Nothing
End If 
End Sub
%>
<script type="text/javascript">
function setCmd(inputField, submittedForm) {
  switch(inputField.name) {
    case "addBtn":
      submittedForm.cmdID.value=1
      break; 
    // case "editBtn": TODO: create edit form.   
     //  submittedForm.cmdID.value=2
     //  break;  
    case "removeBtn": 
      submittedForm.cmdID.value=4; 
      break; 
    case "lookupBtn": 
      submittedForm.cmdID.value=6;
      break;

    default: 
      submittedForm.cmdID.value=0
  }

  
}
</script>
<html>
<head>
  <title>DataBase Queries</title>
</head>
<body>


<%If iCommandID = 0 Then %> 
  <table border="1px solid black" align="center">
  <tr> 
   <% DO Until objRs.EOF
      
    For Each Val in objrs.Fields%>
      <tr><th><%=val.name%></th>
        <td><%=val.value%></td>
      </tr>
    <%
    Next 
    objrs.MoveNext
    loop
    objRs.Close
    objConn.Close
    %>
  </tr> 
</table> 
<%End If%>

<!--TODO: Check to see how to update command ids appropriately depending on interaction or required actions.-->
<form method="post" action="dbQueries.asp">
<table>
  <tr><th>User Controls</th></tr>
  <tr>
    <td>UserName: <input name="username"></td>
    <td>Password: <input name="password"></td>
    <td><input name="addBtn" type="submit" value="Add User" onclick="setCmd(this, this.form)"></td>
    <td><input style="background:red;" name="removeBtn" type="Submit" value="Remove User" onclick="setCmd(this, this.form)"></td>
    <td><input name="lookupBtn" type="Submit" value="Lookup User" onclick="setCmd(this, this.form)">
  </tr>
  <input type ="hidden" name="cmdID" id="cmdID" value="">
</form>

</body>
</html>

