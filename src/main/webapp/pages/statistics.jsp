<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- import di classi Java -->
<%@ page import="java.util.*"%>

<!-- metodi richiamati nel seguito -->
<%!//%>

<!-- codice html restituito al client -->
<%
  Integer defaultValue = 5;
  String defaultUnit = "minutes";
  String requestedValue = request.getParameter("timeValue");
  String requestedUnit = request.getParameter("timeUnit");
  if(requestedValue != null) 
	defaultValue = Integer.parseInt(requestedValue);
  if(requestedUnit != null) 
	defaultUnit = requestedUnit;
%>
<html>
	<head>
		<title>Statistics JSP</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/default.css" type="text/css"/>
	</head>

	<body>
		<%@ include file="../fragments/header.jsp" %>
		<%@ include file="../fragments/menu.jsp" %>
		
		<div id="main" class="clear">
		 	<form name="statisticheForm" action="<%= request.getContextPath() %>/statisticheServlet" method="post">
				Show statistics in the last:
				<input type="number" id="timeValue" name="timeValue" value="<%= defaultValue %>" min="1" required>
				<select id="timeUnit" name="timeUnit">
            		<option value="days" <% if ("days".equals(defaultUnit)) { out.print("selected"); } %>>days</option>
            		<option value="hours" <% if ("hours".equals(defaultUnit)) { out.print("selected"); } %>>hours</option>
            		<option value="minutes" <% if ("minutes".equals(defaultUnit)) { out.print("selected"); } %>>minutes</option>
        		</select>
				<input type="submit" name="req" value="compute"/><br />
		  	</form><br />
		
		
		<% 
        Float guadagno = (Float)request.getAttribute("guadagnoRichiestaAttuale");
		List<String> topProducts = (List<String>) request.getAttribute("topProducts");
		// mostro il risultato della ricerca appena effettuata
		if( guadagno != null ){
			%>
    		Supermarket's total revenue: <%= guadagno %><br /><br />
    		<%
		}
		if(topProducts != null && ! topProducts.isEmpty()) {
			%>
			Best seller:<br />
			<ol>
			<%
			for(String product : topProducts){
			%>
			  <li> <%= product %><br /></li>
		    <% 
			}
			%>
			</ol>
			<%
		}
		%>
		</div>
		
		<%@ include file="../fragments/footer.jsp" %>
		
		
		
		
	</body>
</html>
