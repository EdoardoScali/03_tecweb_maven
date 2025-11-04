<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="it.unibo.tecweb.beans.Catalogue"%>
<%@ page import="it.unibo.tecweb.beans.Item"%>
<%@ page import="java.util.Map"%>

<%@ page import="it.unibo.tecweb.beans.Cart" %>

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
			<jsp:useBean id="cart" class="it.unibo.tecweb.beans.Cart" scope="session"></jsp:useBean>
			
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
					else if ( request.getParameter("addCart") != null && request.getParameter("addCart").equals("ok") ) {
						// catalogue.emptyItem(id);
						Item item = new Item();
						item.setId(request.getParameter("id"));
						
						if(catalogue.getQuantity(item) > 0){
							int cartQuantity = cart.getQuantity(item);						
							cart.put(item, cartQuantity + 1);

							int catalogueQuantity = catalogue.getQuantity(item) - 1;
							catalogue.emptyItem(item);
							catalogue.addItem(item, catalogueQuantity);
							
						}
						
						
					}
					
				}
			%>
			
			<div id="right" style="float: right; width: 48%; border-right: 1px solid grey">

				<p>Items in the chart:</p>
				<table class=formdata>
					<tr>
						<th style="width: 33%">Name</th>
						<th style="width: 33%">Price</th>
						<th style="width: 33%">Quantity</th> 
					</tr>
					<%
					for(Item item: cart.getItems()){
					%>
						<tr>
							<td><%= item.getId() %></td>
							<td><%= item.getPrice() %> &#8364;</td>
							<td><%= cart.getQuantity(item) %></td>
							
						</tr>
					<%
					}
					%>
					
				</table>
		
			</div>
			
			<div id="left" style="float: left; width: 48%">

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
								<a href="?addCart=ok&id=<%= anItem.getId() %>">
								<button>Add to chart</button></a>
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