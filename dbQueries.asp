<%@Language="vbscript" codepage="65001"%>
<% 
Dim objConn, connStr, strSql 
Dim name, pass, addBtn
  connStr = "Driver={ODBC Driver 17 for SQL Server};Server=localhost;Database=userDataColl;Trusted_Connection=yes;"
  name = Request.Form("username")
  pass = Request.Form("password")
  addBtn = Request.Form("addBtn") ' gave the submit button a name attribute and grabbed it on server code.  
  removeBtn = Request.Form("removeBtn")
  lookupBtn = Request.Form("lookupBtn")

Function insertUser()
If addBtn <> "" Then ' new logic here to ensure that the button has actually been pressed before carrying out the ADO operations.  
    strSql = "INSERT INTO dbo.userLogins (userName, passW) VALUES (" & "'" & name & "', " & "'" & pass & "'" & ")"
      If name <> "" AND pass <> "" Then 
        Set objConn = Server.CreateObject("ADODB.Connection")
          objConn.Open(connstr)
          objConn.Execute strSql, , adCmdText
          objConn.Close 
        Set objConn = Nothing
    Else 
      strError = "alert(Something went wrong!)"
      response.write(strError)
    End If
  End If ' end of new logic encapsulation.  
End Function

Function deleteUser()
If removeBtn <> "" Then  
  strSql = "DELETE FROM dbo.userLogins WHERE userName =" & "'" & name & "'"

  Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open(connstr)
    objConn.Execute strSql, , adCmdText
    objConn.Close
    Set objConn = Nothing
End If 
End Function

Function lookUpUser()
strSql = "Select * FROM dbo.userLogins"
  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open(connStr)

  Set rs = Server.CreateObject("ADODB.Recordset")
  rs.Open strSql, objConn

  for each x in rs.fields
    response.write(x.name)
  next
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
    <td>UserName: <input name="username"></td>
    <td>Password: <input name="password"></td>
    <td><input name="addBtn" type="Submit" value="Add User" onsubmit="<%=insertUser%>"></td>
    <td><input style="background:red;" name="removeBtn" type="Submit" value="Remove User" onsubmit="<%=deleteUser%>"></td>
    <td><input name="lookupBtn" type="Submit" value="Lookup User" onSubmit="<%=lookUpUser%>">
  </tr>
</form>

<script type="text/javascript">
function preventDef(ele) {
  event.preventDefault(); 
}
</script>
</body>
</html>

