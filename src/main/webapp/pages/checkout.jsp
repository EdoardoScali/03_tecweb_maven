<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="it.unibo.tecweb.beans.Catalogue"%>
<%@ page import="it.unibo.tecweb.beans.Cart"%>
<%@ page import="it.unibo.tecweb.beans.Item"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.IOException"%>

<%! 
    private static final Object fileLock = new Object(); 
   
	private Double getItemTotPrice(Item item, Integer quantity){
		return item.getPrice() * quantity;
	}
	
	private Double total(Map<Item, Integer> items) {
		double total = 0;
		for ( Item item : items.keySet() ) {
			total += item.getPrice() * items.get(item);
		}
		return total;
	}
	
	private void logSales(Map<Item, Integer> items, String filename){
		synchronized (fileLock) {
			//e.g., "1758469269970 15.50 mela:2 banana:1"
			StringBuilder logLine = new StringBuilder();
			logLine.append(System.currentTimeMillis()); 
			logLine.append(" ").append(total(items));
			for (Map.Entry<Item, Integer> entry : items.entrySet()) {
			    logLine.append(" ").append(entry.getKey().getId()).append(":").append(entry.getValue());
			}
			
			try (PrintWriter writer = new PrintWriter(new FileWriter(filename, true))) {
	            writer.println(logLine);
	            writer.flush();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	}
%>

<html>
	<head>
		<title>Checkout JSP</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/default.css" type="text/css"/>
	</head>

	<body>	

		<%@ include file="../fragments/header.jsp" %>
		<%@ include file="../fragments/menu.jsp" %>
	
		<div id="main" class="clear">

			Completare Checkout:
				<ul>
				  <li>Mostrare a sinistra il carrello e permettere all'utente di finalizzare l'ordine premendo un apposito bottone</li>
				  <li>In caso di ordine finalizzato: loggare la vendita su file e svuotare il carrello</li>
				  <li>In caso di ordine finalizzato: mostrare a destra il riepilogo con spesa per ogni prodotto e spesa totale</li>
				</ul>

		</div>
	
		<%@ include file="../fragments/footer.jsp" %>

	</body>
</html>