package it.unibo.tecweb.servlets;

import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * Servlet implementation class StatisticheServlet
 */
public class StatisticheServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		//@TODO Calcolare le statistiche e passarle alla JSP
	    
		// passo il controllo alla JSP
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/statistics.jsp");
		dispatcher.forward(req, resp);
		
	}

}
