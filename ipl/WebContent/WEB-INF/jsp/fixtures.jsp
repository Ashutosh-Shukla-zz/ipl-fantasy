<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- MIDDLE -->
<section id="middle">

<!-- get Current system Date and time -->
<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate value="${now}" pattern="yyyy/MM/dd" timeZone="IST" var="currentDate"/>
	
<div id="content" class="padding-20">
<form action="selectPlayers" method="post">		
<div class="row">

		<c:forEach items="${staticDataBean.matchFixturesBean}" var="fixtures">
			
			<fmt:parseDate value="${fixtures.matchDateTime}" pattern="yyyy-MM-dd HH:mm:ss" var="fixturesDate"/>
			<fmt:formatDate value="${fixturesDate}" pattern="yyyy/MM/dd" var="currentFixtureDate" />
			
			<div class="col-md-12 col-sm-12">
				<h5 class="page-header"><fmt:formatDate pattern="EEEE, dd MMMM yyyy" value="${fixturesDate}" /></h5>
			</div>

			<!-- Feedback Box -->
			<div class="col-md-12 col-sm-12">

				<!-- BOX -->
				<div class="panel panel-clean"><!-- default, danger, warning, info, success -->
					
								<div class=" box-title text-center panel-heading">

									<span class="elipsis"><!-- panel title  MATCH 2 4:00PM IST (2:30PM GMT) -->
										<strong>Match ${fixtures.matchFixturesId} :  <fmt:formatDate pattern="hh:mm a" value="${fixturesDate}" /> IST</strong>
									</span>

									<!-- right options -->
									<ul class="options pull-right list-inline">
										<li><a href="#" class="opt panel_colapse plus" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Colapse"></a></li>
										<!-- <li><a href="#" class="opt panel_fullscreen hidden-xs" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Fullscreen"><i class="fa fa-expand"></i></a></li>
										<li><a href="#" class="opt panel_close" data-confirm-title="Confirm" data-confirm-message="Are you sure you want to remove this panel?" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Close"><i class="fa fa-times"></i></a></li> -->
									</ul>
									<!-- /right options -->

								</div>
					
					<c:set var="displayBlockNone" value="none"/>
					
					
					<c:if test="${currentDate == currentFixtureDate}">
						<c:set var="displayBlockNone" value="block"/>
					</c:if>
					
					<div class="box-body text-center matchBox venue-7 padding-3 my-box panel-body" style="display: ${displayBlockNone};">
					
					<c:forEach items="${staticDataBean.teamBean}" var="teams">
						<c:if test="${teams.teamCode == fixtures.teamOneCode}">
							<c:set var="teamOneName" value="${teams.teamName}"/>	
						</c:if>
						
						<c:if test="${teams.teamCode == fixtures.teamTwoCode}">
							<c:set var="teamTwoName" value="${teams.teamName}"/>	
						</c:if>
					</c:forEach>
						<div class="col-md-5 col-sm-5 col-xs-5">
							<strong>${teamOneName}</strong>
							<div class="tLogo70x ${fixtures.teamOneCode}"></div>
						</div>
						
						<div class="col-md-2 col-sm-2 col-xs-2 padding-6 text-center">
						VS
						</div>
						
						<div class="col-md-5 col-sm-5 col-xs-5">
							<strong>${teamTwoName}</strong>
							<div class="tLogo70x ${fixtures.teamTwoCode}"></div>
						</div>
						
						<div class="col-xs-12 margin-top-10">
						 <strong class="color-grey">${fixtures.venueName}, ${fixtures.venueCity}</strong>
						 </div>
						 
						 
						<c:set var="buttonValue" value="Select Players"/>
						<c:set var="buttonclass" value="primary"/>
						 
						 <c:forEach items="${userFixtureIdVoteList}" var="fixtureId">
						 	<c:if test="${fixtureId == fixtures.matchFixturesId}">
								<c:set var="buttonValue" value="Update Players"/>
								<c:set var="buttonclass" value="success"/>
							</c:if>
						 </c:forEach>
						 <div class="col-xs-12 margin-top-10 margin-bottom-10">
						 <input type="button" class="btn btn-${buttonclass}" id="replacable-btn${fixtures.matchFixturesId}" value="${buttonValue}" onclick="selectPlayers(${fixtures.matchFixturesId})">
						</div>
					</div>

				</div>
				<!-- /BOX -->

			</div>
	</c:forEach>

</div>
<input type="hidden" name="matchId" id="matchId" value="">
<input type="hidden" name="comingFrom" id="comingFrom" value="fixturePage">
</form>
</div>
</section>

		<a style="display: none" href="#" id="message-lnk" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="${messageToDisplay}"></a>
<!-- /MIDDLE -->

<script>
$( document ).ready(function(){
	
	var message = '${messageToDisplay}';
	
	if(message!='' || message!=undefined){
		$('.toastr-notify').attr('data-message',message);
		$('#message-lnk').click();
		//document.getElementById("message-lnk").click();
	}
	
	//document.getElementById("replacable-btn65").focus();
});

function selectPlayers(matchId){
	
	document.getElementById("matchId").value=matchId;
	
	document.forms[0].submit();
}

</script>