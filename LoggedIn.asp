<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<%
Dim bLoggedIn, user, cmdID
cmdID = Request.Form("cmdID")
user = Session("userName")
If NOT Session("loggedIn") = true Then 
    Session.Contents.RemoveAll()
    response.redirect("./dbQueries.asp")
    response.write("<p>You're not supposed to be here...go back where you came from!</p>")
Else 
    response.write("<p>Welcome, " & user & "you have logged in successfully.</p>")
End If 

Sub ClearSession()

End Sub
%> 

<input type = "button" value="clear session" onclick="<%=Session.Contents.RemoveAll()%>">