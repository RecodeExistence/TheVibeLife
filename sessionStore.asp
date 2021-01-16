<%
    Dim objConn
    CONST SiteDomain = "localhost"

    ' Open objConn for use on other pages.  
    Set objConn = Server.CreateObject("ADODB.Connection")
    objConn.Open(Application("DATABASE_CONNECTION_STRING"))

    Function redirect(vStrPageDestination)
        redirect = Server.URLEncode(vStrPageDestination)
    End Function 
%>