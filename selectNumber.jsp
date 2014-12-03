<%@page import="java.text.ParseException"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="edu.ncsu.csc.itrust.beans.MessageBean"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPersonnelAction"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.PersonnelDAO"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.PatientDAO"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyMessagesAction"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPatientAction"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPersonnelAction"%>

<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>


<%@page import="edu.ncsu.csc.itrust.action.ViewMyMessagesAction"%>
<%@page import="edu.ncsu.csc.itrust.beans.MessageBean"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.PatientDAO"%>


<%@include file="/global.jsp" %>
<style>
h1{
text-align: center;
}</style>
<%
	pageTitle = "Reminder - Select Days";
%>

<%


		
%>

<%@include file="/header.jsp" %>
			<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
			<script src="/iTrust/DataTables/media/js/jquery.dataTables.min.js" type="text/javascript"></script>
			<script src="/iTrust/DataTables/media/js/jquery.dataTables.columnFilter.js" type="text/javascript"></script>
			
			
			<script type="text/javascript">
				$(document).ready(function() {
					console.log("tdfdsdsing");
					
       			})
       			

       			function sendClick(){
   				<%
   					if(request.getParameter("send") != null){
   						//logic that needs to be executed after redirection when the save button is clicked
   						String num = request.getParameter("days");
   						
   						//search for appointments that are checuled in num days
   						List<ApptBean> list = new ArrayList<MessageBean>();
   						//Aele's part
   						//end of searching
   						
   						//iterate thru list, for each ApptBean, grab patient id, doctor id, date, 
   						//and create a messagebean with sender=="admin"
   						//for each patient id, grab email address and send a fake email
   						//for each doctor id, grad doctor's name
   						//Lingzi's part
   						
   					}
   				%>
				}
       				
			</script>
<h1>Select Number of Days</h1>
<div class="selectDays">
			<div align="center">
				<form method="post" onSubmit="JavaScript:sendClick()">
					<table>
						<tr style="text-align: right;">
							<td>
								<label for="sender">Please enter the number of reminder-in-advance-days: </label>
								<input type="text" name="days" id="days" value="" />
							</td>
						</tr>
						<tr style="text-align: center;">
							<td colspan="3">
								<input type="submit" name="send" id="send" value="Send Appointment Reminder" />
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>

 
<%@include file="/footer.jsp" %>