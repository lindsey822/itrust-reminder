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
<%@page import="edu.ncsu.csc.itrust.beans.ApptBean"%>
<%@page import="edu.ncsu.csc.itrust.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPersonnelAction"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.PersonnelDAO"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.PatientDAO"%>
<%@page import="edu.ncsu.csc.itrust.dao.mysql.MessageDAO"%>

<%@page import="edu.ncsu.csc.itrust.action.ViewMyMessagesAction"%>
<%@page import="edu.ncsu.csc.itrust.action.SendMessageAction"%>

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
   						ApptDAO apptDAO = DAOFactory.getProductionInstance().getApptDAO();
   						list = apptDAO.getAllAppts();
   						
   						//iterate thru list, for each ApptBean, check if within num days
   						//if so, needs a reminder message
   						//grab patient id, doctor id, date, 
   						//and create a messagebean with sender=="admin"
   						//for each patient id, grab email address and send a fake email
   						//for each doctor id, grad doctor's name
   						//Lingzi's part
   						for (ApptBean appt : list) {
   							//check date(if will happen within num days)
   							Timestampt dateTS = appt.getDate();
   							String date = dateTS.toString();
   							Calendar calendar = Calendar.getInstance();
   							Date now = calendar.getTime();
   							Timestamp current = new Timestamp(now.getTime());
   							
   							//find number of days from now
   							boolean negative = false;

   					      GregorianCalendar cal = new GregorianCalendar();
   					      cal.setTime(current);
   					      cal.set(Calendar.HOUR_OF_DAY, 0);
   					      cal.set(Calendar.MINUTE, 0);
   					      cal.set(Calendar.SECOND, 0);
   					      cal.set(Calendar.MILLISECOND, 0);

   					      GregorianCalendar calEnd = new GregorianCalendar();
   					      calEnd.setTime(dateTS);
   					      calEnd.set(Calendar.HOUR_OF_DAY, 0);
   					      calEnd.set(Calendar.MINUTE, 0);
   					      calEnd.set(Calendar.SECOND, 0);
   					      calEnd.set(Calendar.MILLISECOND, 0);


   					      if (cal.get(Calendar.YEAR) == calEnd.get(Calendar.YEAR))   {
   					          if (negative)
   					               return (calEnd.get(Calendar.DAY_OF_YEAR) - cal.get(Calendar.DAY_OF_YEAR)) * -1;
   					          return calEnd.get(Calendar.DAY_OF_YEAR) - cal.get(Calendar.DAY_OF_YEAR);
   					      }

   					      int days = 0;
   					      while (calEnd.after(cal))    {
   					          cal.add (Calendar.DAY_OF_YEAR, 1);
   					          days++;
   					      }
   					      
   							//end
   							
   							
   							if(days <= num){
	   							long patientid = appt.getPatient();
	   							long hcpid = appt.getHcp();
	   							
	   							PersonnelDAO hcpDAO = DAOFactory.getProductionInstance().getPersonnelDAO();
	   							String hcpName = hcpDAO.getName(hcpid);
	   							
	   							PatientDAO patientDAO = DAOFactory.getProductionInstance().getPatientDAO();
	   							PatientBean patientBean = patientDAO.getPatient(patientid);
	   							String patientEmail = patientBean.getEmail();
	   							
	   							
	   							//send message
	   							SendMessageAction action = new SendMessageAction(prodDAO, loggedInMID);
	   							MessageBean messageNew = new MessageBean();
	   							
	   							String body = "You have an appointment on ";
	   							body .= date;
	   							body .= " with Dr. ";
	   							body .= hcpName;
	   							console.log(body);
	   							
	   							int N = 0;
	   							//N is num of days between appt date and current date
	   							//do something to calculate N
	   							
	   							String subject = "Reminder: upcoming appointment in ";
	   							subject .= N;
	   							subject .=" day(s)";
	   							console.log(subject);
	   							
	   							messageNew.setBody(body);
	   							messageNew.setFrom(loggedInMID);
	   							messageNew.setTo(patientid);
	   							messageNew.setSubject(subject);
	   							messageNew.setRead(0);
	   							
	   							action.sendMessage(messageNew);
	   							
	   							//send fake email
	   							FakeEmailDAODAO emailDAO = DAOFactory.getProductionInstance().getFakeEmailDAO();
	   							Email emailNew = new Email();
	   							List<String> toList;
	   							toList.add(patientEmail);
	   							emailNew.setToList(toList);
	   							emailNew.setFrom("");//what is admin's email address???
	   							emailNew.setSubject(subject);
	   							emailNew.setBody(body);
	   							emailNew.setTimeAdded(curr_date);
	   							
	   							emailDAO.sendEmailRecord(email);
   							}
   						}
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