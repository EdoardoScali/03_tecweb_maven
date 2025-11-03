<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="it.unibo.tecweb.beans.Catalogue"%>
<%@ page import="it.unibo.tecweb.beans.Item"%>
<%@ page import="java.util.Map"%>

<!-- codice html restituito al client -->
<html>
	<head>
		<title>Catalogue JSP</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/default.css" type="text/css"/>
	</head>

	<body>	

		<%@ include file="../fragments/header.jsp" %>
		<%@ include file="../fragments/menu.jsp" %>
	
		<div id="main" class="clear">

			<jsp:useBean id="catalogue" class="it.unibo.tecweb.beans.Catalogue" scope="application" />
			
			<%
				String id = request.getParameter("id");
	
				if ( id != null && ! id.equals("") ) {

					if ( id.contains(" ") ) {
						throw new Exception("Blanks are not allowed in the description field!"); 					
					}
					
					if ( request.getParameter("add") != null && request.getParameter("add").equals("submit item") ) {
						Item item = new Item();
						item.setId( id );
						item.setPrice( Double.parseDouble( request.getParameter("price") ) );
						Integer quantity =  Integer.parseInt(request.getParameter("quantity") );
						catalogue.addItem(item, quantity);
					}
					else if ( request.getParameter("remove") != null && request.getParameter("remove").equals("ok") ) {
						catalogue.emptyItem(id);
					}
					
				}
			%>
			
			<div id="left" style="float: left; width: 48%; border-right: 1px solid grey">
			
				<p>Add an item to the catalogue:</p>
				<form>
					<table>
						<tr><td>
							<label for="desc">Name:</label>
						</td><td>
							<input type="text" name="id"/>
						</td></tr>
						<tr><td>
							<label for="price">Price (&#8364;):</label>
						</td><td>
							<input type="text" name="price"/>
						</td></tr>
						<tr><td>
							<label for="price">Quantity:</label>
						</td><td>
							<input type="text" name="quantity"/>
						</td></tr>
						<tr><td colspan="2">
							<input type="submit" name="add" value="submit item" style="width:100%"/>
						</td></tr>
					</table>
				</form>
		
			</div>
			
			<div id="right" style="float: right; width: 48%">

				<p>Current catalogue:</p>
				<table class="formdata">
					<tr>
						<th style="width: 31%">Name</th>
						<th style="width: 31%">Price</th>
						<th style="width: 31%">Available quantity</th>
						<th style="width: 7%"></th>
					</tr>
					<% 
					for( Item anItem : catalogue.getItems() ){  
					%> 
						<tr>
							<td><%= anItem.getId() %></td>
							<td><%= anItem.getPrice() %> &#8364;</td>
							<td><%= catalogue.getQuantity(anItem) %></td>
							<td>
								<a href="?remove=ok&id=<%= anItem.getId() %>">
								<img src="../images/remove.gif" alt="remove"/></a>
							</td>
						</tr>
					<% } %>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>			
			</div>
		
			<div class="clear">
				<p>&nbsp;</p>
			</div>
			
		</div>
	
		<%@ include file="../fragments/footer.jsp" %>

	</body>
</html>

<!-- ciao -->