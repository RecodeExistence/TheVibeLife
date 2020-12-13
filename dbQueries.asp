<%@Language="vbscript" codepage="65001"%>
<% 
Dim objConn, connStr, strSql 
Dim name, pass, addBtn
  connStr = "Driver={ODBC Driver 17 for SQL Server};Server=localhost;Database=userDataColl;Trusted_Connection=yes;"
  name = Request.Form("username")
  pass = Request.Form("password")
  addBtn = Request.Form("addBtn") ' gave the submit button a name attribute and grabbed it on server code.  
  removeBtn = Request.Form("removeBtn")

Function insertUser()
If addBtn <> "" Then ' new logic here to ensure that the button has actually been pressed before carrying out the ADO operations.  
    strSql = "INSERT INTO dbo.userLogins (userName, passW) VALUES (" & "'" & name & "', " & "'" & pass & "'" & ")"
    
    Set objConn = Server.CreateObject("ADODB.Connection")
      objConn.Open(connstr)
      objConn.Execute strSql, , adCmdText
      objConn.Close 
    Set objConn = Nothing
  End If ' end of new logic encapsulation.  
End Function

Function deleteUser()
If removeBtn <> "" Then  
  strSql = "DELETE FROM dbo.userLogins WHERE userName =" & "'" & name & "'"

  Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open(connstr)
    objConn.Execute strsql, , adCmdText
    objConn.Close
    Set objConn = Nothing
End If 
End Function
%>


<!DOCTYPE html>
<html>
<head>
  <title>DataBase Queries</title>
</head>
<body>
<form method="post" action="dbQueries.asp">
<table>
  <tr><th>User Controls</th></tr>
  <tr>
    <td><input name="username"></td>
    <td><input name="password"></td>
    <td><input name = "addBtn" type = "Submit" value = "Add User" onsubmit="<%=insertUser%>"></td>
    <td><input name ="removeBtn" type="Submit" value = "Remove User" onsubmit="<%=deleteUser%>"></td>
  </tr>
</form>
</body>
</html>

