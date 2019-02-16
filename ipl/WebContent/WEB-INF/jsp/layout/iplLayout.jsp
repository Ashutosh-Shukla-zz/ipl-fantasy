<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
  <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title><tiles:insertAttribute name="title" ignore="true" /></title>  
</head>
<body>
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="navigation" />
		<tiles:insertAttribute name="body" />
		<tiles:insertAttribute name="footer" />
</body>

</html>


