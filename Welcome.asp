<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Dim user
user = Request.QueryString("username")
%>

<html>
    <p>Hey there <%=user%>.  Thanks for registering!  Your details are now on the system, and as soon as we got more pages.. You'll be able to log in!</p>  
</html> 