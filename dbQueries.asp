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

If Request.Form("commandID").Count > 0 Then 
  iCommandID = CLng(Request.Form("commandID"))
ElseIf Request.QueryString("commandID").Count > 0 Then 
  iCommandID = Clng(Request.QueryString("commandID"))
Else 
  iCommandID = 0
End If 

SELECT Case iCommandID
    Case 0
    ' Default load of data.
    loadData  
    Case 1
    ' Insert data
    addUser
    Case 2
    ' Update data
    editUser
    Case 4
    ' Delete data
    deleteUser
    Case 6 
    ' other functions or routes into the page.  
End Select 

Sub loadData()
  Set objConn = Server.CreateObject("ADODB.Connection")
  objConn.Open

  strSql = "SELECT userID, userName, hashPass FROM dbo.userLogins"
  Set objRs = Server.CreateObject("ADODB.Recordset")
  objRs.Open strSql, objConn
    arrResults = objRs.GetRows
    If NOT objRs.EOF Then 
      bHasResults = True
      iResults = Ubound(objRs)
    End If 
  objRs.Close
  objConn.Close
  Set objRs = Nothing 
  Set objConn = Nothing
End Sub 

Sub addUser()
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
      insertUser = response.write(strError)
    End If
  End If ' end of new logic encapsulation.  
End Sub

Sub deleteUser()
If removeBtn <> "" Then  
  strSql = "DELETE FROM dbo.userLogins WHERE userName =" & "'" & name & "'"

  Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open(connstr)
    objConn.Execute strSql, , adCmdText
    objConn.Close
    Set objConn = Nothing
End If 
End Sub

Function lookupUser()
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
End Function
%>

<html>
<head>
  <title>DataBase Queries</title>
</head>
<body>

<table> 
<%Do While NOT objRs.EOF%> 
  ' TODO: SPEAK TO STEVEN OR READ CODE ON HOW TO POPULATE TABLE FROM RECORDSET. 
<%Loop%>

</table> 

<form method="post" action="dbQueries.asp">
<table>
  <tr><th>User Controls</th></tr>
  <tr>
    <td>UserName: <input name="username"></td>
    <td>Password: <input name="password"></td>
    <td><input name="addBtn" type="submit" value="Add User" onsubmit=""></td>
    <td><input style="background:red;" name="removeBtn" type="Submit" value="Remove User" onsubmit="<%=deleteUser%>"></td>
    <td><input name="lookupBtn" type="Submit" value="Lookup User">
  </tr>
  <input type ="hidden" id="commandID" value="1">
</form>

</body>
</html>

