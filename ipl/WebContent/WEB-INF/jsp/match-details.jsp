<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- MIDDLE -->
<style type="text/css">
option.opt1 {
	font-weight: bold;
}
select option[playerrole="xyz"] {
background-image:url(assets/images/flags/in.png);
background-repeat: no-repeat;
background-position: right;
}
/* #selectedPlayerTable > thead > tr > th{
background-color: ;
color: white;
background-color: rgba(0, 72, 72, 1);
}
 */
 </style>
<section id="middle">
<form action="votePlayers" method="post">
	<div id="content" class="padding-20">
		<div class="row">
			
			<c:forEach items="${staticDataBean.matchFixturesBean}" var="fixtures">
			
			<c:forEach items="${staticDataBean.teamBean}" var="teams">
				<c:if test="${teams.teamCode == fixtures.teamOneCode}">
					<c:set var="teamOneName" value="${teams.teamName}"/>	
				</c:if>
						
				<c:if test="${teams.teamCode == fixtures.teamTwoCode}">
					<c:set var="teamTwoName" value="${teams.teamName}"/>	
				</c:if>
			</c:forEach>
			
			<c:if test="${matchId == fixtures.matchFixturesId}">
				<div class="col-md-12 col-sm-12 " >
						<h5 class="page-header bold text-center">Match ${fixtures.matchFixturesId} : ${teamOneName} vs ${teamTwoName}
							 <strong class="color-grey" style="display: block">at ${fixtures.venueName}, ${fixtures.venueCity}</strong>
						</h5>
						
						<fmt:parseDate value="${fixtures.matchDateTime}" pattern="yyyy-MM-dd HH:mm:ss" var="fixturesDate"/>
						<fmt:formatDate value="${fixturesDate}" pattern="yyyy/MM/dd HH:mm:ss" var="currentFixtureDateTime"/>
						
						<div style="color:red;font-weight: bold;" class="countdown simple countdownId text-center padding-10 " id="countdownId" data-date="<c:out value="${currentFixtureDateTime}" />"></div>
				</div>
			<div class="col-md-1 col-sm-12"></div>
			<div class="col-md-10 col-sm-12">

				<!-- BOX -->
				<div class="panel panel-clean"><!-- default, danger, warning, info, success -->
					

				<div class="box-body text-center matchBox padding-15 my-box panel-body venue ${fixtures.venueCity}">
					
					<div class="alert alert-success margin-bottom-10"><!-- SUCCESS -->
						<button type="button" class="close" data-dismiss="alert">
							<span aria-hidden="true">?</span>
							<span class="sr-only">Close</span>
						</button>
						<c:if test="${fixtures.matchFixturesId>56}">
						<strong class=""><i class="glyphicon glyphicon-info-sign" style="color:red; font-size: 16px;vertical-align: bottom;"></i>Select any 7 players</strong>
						</c:if>
						<c:if test="${fixtures.matchFixturesId<56}">
						<strong class=""><i class="glyphicon glyphicon-info-sign" style="color:red; font-size: 16px;vertical-align: bottom;"></i> Select ${systemParametersMap.BatsmenCount} Batsmen, ${systemParametersMap.BowlerCount} Bowler, ${systemParametersMap.AllRounderCount} All-rounder</strong>
						</c:if>
						 
					</div>
					
					<c:if test="${not empty playingXIMap}">
						<span style="text-align: center;color: red;font-weight: bold">Playing XI</span><br>
						<div class="alert alert-info margin-bottom-10 text-left"><!-- INFO -->
							<button type="button" class="close" data-dismiss="alert">
								<span aria-hidden="true">?</span>
								<span class="sr-only">Close</span>
							</button>
							
							<div class="text-center padding-3" style="font-weight: bold;color:red">Toss : ${playingXIMap['Toss']}</div>
							
							<c:forEach var="playingXI" items="${playingXIMap}">
								<c:if test="${playingXI.key != 'Toss'}">
							   		<span style="text-align: center;font-weight: bold">${playingXI.key}</span>: ${playingXI.value}<br>
							   	</c:if>
							</c:forEach>
						</div>
					</c:if>
					
					<c:set var="teamOnePlayXI" value="${playingXIMap[fixtures.teamOneCode]}" />
					<c:set var="teamTwoPlayXI" value="${playingXIMap[fixtures.teamTwoCode]}" />
					
					
					<div class="col-md-5 col-sm-5 col-xs-12">
						
							<strong class="padding-10">${teamOneName}</strong>
							<div class="tLogo70x ${fixtures.teamOneCode}"></div>
							<div class="col-md-2 col-sm-2 col-xs-1"></div>
							<div class="col-md-8 col-sm-8 col-xs-10">
								<div class="form-group">
									<select class="form-control" id="teamOnePlayers" onchange="moveSelected('teamOnePlayers', 'selectedTeamPlayers')">
									  <option value="-1" class="opt1" selected>Select your ${fixtures.teamOneCode} Player</option>
									  <c:forEach items="${staticDataBean.teamBean}" var="teamBean">
									  	  <c:if test="${teamBean.teamId == fixtures.teamOneId}">
									  	  	<c:forEach items="${teamBean.playerBean}" var="playerBean">
										  		<option value="${playerBean.playerId}" playerName="${playerBean.firstName} ${playerBean.lastName}" selectName="teamOnePlayers" playerRole="${playerBean.role}" playerCategory="${playerBean.category}" playerTeam ="${fixtures.teamOneCode}">
										  		${playerBean.firstName} ${playerBean.lastName}&nbsp;&nbsp;&nbsp;(${playerBean.role})
										  		</option>
										  	</c:forEach>
										  </c:if>
									  </c:forEach>
									</select>
								</div>
							</div>
						<div class="col-md-2 col-sm-8 col-xs-1"></div>
						</div>
						
						<div class="col-md-2 col-sm-2 col-xs-12 padding-5 text-center">
						VS
						</div>
						
						<div class="col-md-5 col-sm-5 col-xs-12">
							<strong class="padding-10">${teamTwoName}</strong>
							<div class="tLogo70x ${fixtures.teamTwoCode}"></div>
							<div class="col-md-2 col-sm-2 col-xs-1"></div>
							<div class="col-md-8 col-sm-8 col-xs-10">
								<div class="form-group">
									<select class="form-control" id="teamTwoPlayers" onchange="moveSelected('teamTwoPlayers', 'selectedTeamPlayers')">
									  <option value="-1" selected class="opt1">Select your ${fixtures.teamTwoCode} Player</option>
									  <c:forEach items="${staticDataBean.teamBean}" var="teamBean">
									  	  <c:if test="${teamBean.teamId == fixtures.teamTwoId}">
									  	  	<c:forEach items="${teamBean.playerBean}" var="playerBean">
										  		<option value="${playerBean.playerId}" playerName="${playerBean.firstName} ${playerBean.lastName}" selectName="teamTwoPlayers" playerRole="${playerBean.role}" playerCategory="${playerBean.category}" playerTeam ="${fixtures.teamTwoCode}">
										  		${playerBean.firstName} ${playerBean.lastName}&nbsp;(${playerBean.role})</option>
										  	</c:forEach>
										  </c:if>
									  </c:forEach>
									</select>
								</div>
							</div>
						<div class="col-md-2 col-sm-8 col-xs-1"></div>
						</div>
						
					<hr/>
					<div class="col-md-12 col-sm-12 col-xs-12" style="padding : 0px">
							<div class="col-md-3 col-sm-2 col-xs-0"></div>
							<div class="col-md-6 col-sm-8 col-xs-12" style="padding : 0px">
								<div class="form-group">
									<select required style="display: none" class="form-control" id="selectedTeamPlayers" size = "8" ondblclick="moveSelected('selectedTeamPlayers',this.options[this.selectedIndex].getAttribute('selectName'))">
									</select>
								</div>
								<div class="table-responsive nomargin"  style="height: 260px;overflow: auto">
									<table class="table table-condensed nomargin" id="selectedPlayerTable">
										<thead>
											<tr>
												<th colspan="3" style="text-align: center;"><strong class="padding-10" style="color:red;font-weight: bold;">Selected Players</strong></th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
								</div>
								
							</div>
						<div class="col-md-3 col-sm-2 col-xs-0"></div>
					</div>
					
					<div class="col-md-12 col-sm-12 col-xs-12">
					<hr>
						<div class="col-md-6 col-sm-6 col-xs-6">
								<strong>Power Player</strong>
								<div class="form-group">
										<select class="form-control" id="playerMom" name="playerMom" required>
										  <option value="-1"></option>
										</select>
								</div>
						</div>
							
						<div class="col-md-6 col-sm-6 col-xs-6">
								<strong>Select Team</strong>
								<div class="form-group">
										<select class="form-control" id="winTeam" name="winTeam" required>
										  <option value="-1"></option>
										  <option value="${fixtures.teamOneId}">${teamOneName}</option>
										  <option value="${fixtures.teamTwoId}">${teamTwoName}</option>
										</select>
								</div>
						</div>
					
					
					 <div class="col-xs-12 margin-top-10 margin-bottom-10">
					 <div id="vote-submit">
						 <c:if test="${user.isActive}">
							<input type="button" class="btn btn-primary my-btn" id="replacable-btn" value="Vote" onclick="validateVote()">
						 </c:if>
						 <c:if test="${not user.isActive}">
							<span class="label label-danger" style="font-size: 15px;">Wait for Admin authorization to vote</span>
						 </c:if>
					</div>
					</div>
						
					</div>
						 
					</div>

				</div>
				<!-- /BOX -->

			</div>
			<div class="col-md-1 col-sm-12"></div>			
				
	</c:if>		
	</c:forEach>		

		</div>
	</div>
	<input type="hidden" name="selectedPlayersIds" id="selectedPlayersIds">
	<input type="hidden" name="matchId" id="matchId" value="${matchId}">
	<input type="hidden" name="comingFrom" id="comingFrom" value="${comingFrom}">
</form>

<a href="#" style="display: none" class="btn btn-danger toastr-notify" data-progressBar="true" data-timeOut="3000" data-position="top-full-width" data-notifyType="error" data-message="Error! Please try again!">Show Error</a>
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<fmt:formatDate value="${now}" pattern="yyyy/MM/dd HH:mm:ss" timeZone="IST" var="currentDateTime"/>
</section>
<fmt:parseNumber var="BatsmenCount" type="number" value="${systemParametersMap.BatsmenCount}" />
<fmt:parseNumber var="BowlerCount" type="number" value="${systemParametersMap.BowlerCount}" />
<fmt:parseNumber var="AllRounderCount" type="number" value="${systemParametersMap.AllRounderCount}" />

<c:set var="totalSelectionAllowed" value="${BatsmenCount + BowlerCount + AllRounderCount }"/>

<!-- /MIDDLE -->
<script type="text/javascript" src="assets/js/jquery.countdown.min.js"></script>
<script>
var testmy1 =1;
$(window).load(function(){
		
	
		var countdown = document.getElementById("countdownId");
		var endDate = countdown.getAttribute("data-date");

		$('#countdownId').countdowntimer({
			startDate : '${currentDateTime}',
            dateAndTime : endDate,
            timeUp : countdownTimeUp
		});
		
		if(testmy1 == 0){
			var replace = $('#vote-submit').html('<div class="alert alert-danger"><strong>Voting Closed</strong> </div>');
		}
	
		var playerMomId = '${userSelectionBean.playerMomId}';
		var winTeamId = '${userSelectionBean.winTeamId}';
		var selectedPlayersIds = '${userSelectionBean.selectedPlayersIds}';
		var selectedPlayersIdAarray = selectedPlayersIds.split("|");
		var teamOnePlayXIArray = '${teamOnePlayXI}'.replace('[','').replace(']','').split(",");
		for (var i = 0, l = teamOnePlayXIArray.length; i < l; ++i) {
			teamOnePlayXIArray[i] = $.trim(teamOnePlayXIArray[i]);
		}
		var teamTwoPlayXIArray = '${teamTwoPlayXI}'.replace('[','').replace(']','').split(",");
		for (var i = 0, l = teamTwoPlayXIArray.length; i < l; ++i) {
			teamTwoPlayXIArray[i] = $.trim(teamTwoPlayXIArray[i]);
		}
		//	alert(teamTwoPlayXIArray.length);
		
		$('select#teamOnePlayers option').each(function(){
			
			var isSelected = false;
			if($.inArray($(this).val(), selectedPlayersIdAarray) != -1){
				//alert($(this).val());
				$(this).attr("selected", 'selected');
				moveSelected('teamOnePlayers', 'selectedTeamPlayers');
				isSelected = true;
			}
			if(teamOnePlayXIArray.length > 2 && isSelected == false && $.inArray($(this).attr('playerName'), teamOnePlayXIArray) == -1 && $(this).attr('playerName') != undefined){
				//alert($(this).attr('playerName'));
				$(this).remove()
			}
		});
		
		$('select#teamTwoPlayers option').each(function(){
			
			var isSelected = false;
			if($.inArray($(this).val(), selectedPlayersIdAarray) != -1){
				//alert($(this).val());
				$(this).attr("selected", 'selected');
				moveSelected('teamTwoPlayers', 'selectedTeamPlayers');
				isSelected = true;
			}
			if(teamTwoPlayXIArray.length > 2 && isSelected == false && $.inArray($(this).attr('playerName'), teamTwoPlayXIArray) == -1 && $(this).attr('playerName') != undefined){
				//alert($(this).attr('playerName'));
				$(this).remove()
			}

		});
		
		$("#playerMom").find('option').removeAttr("selected");
		
		$("#playerMom option[value='${userSelectionBean.playerMomId}']").attr("selected", 'selected');
		$("#winTeam option[value='${userSelectionBean.winTeamId}']").attr("selected", 'selected')
		
		document.getElementById('selectedTeamPlayers').focus();
		
		
	});
	
	function countdownTimeUp(){
		testmy1 =0;
		var replace = $('#vote-submit').html('<div class="alert alert-danger"><strong>Voting Closed</strong> </div>');
	}
	
	function moveSelected(from, to) {
		if( $('#'+from+' option:selected').val()!=-1){
       		$('#'+from+' option:selected').remove().appendTo('#'+to);
		}
		$('#playerMom option').remove();
		$('#selectedTeamPlayers option').clone().appendTo('#playerMom');
		
		$("<option value='-1' selected></option>").insertBefore("select#playerMom option:nth-child(1)");
		$('#teamOnePlayers').val('-1');
		$('#teamTwoPlayers').val('-1');
		
		//$("#playerMom option").eq(1).before($("<option></option>").val('-1').html(''));
		
		//$("#playerMom option[value='-1']").attr("disabled", false).attr("selected", 'selected').html('');
		
		
		var selectedTeamPlayers =  $('select#selectedTeamPlayers option');
		$("#selectedPlayerTable > tbody").html("");
		$(selectedTeamPlayers).each(function()
				{
					if($(this).val() !=-1){
						
						//alert($(this).val() +' '+$(this).attr('playername')); 
						var playerRole = $(this).attr('playerRole');
						var playerName = $(this).attr('playerName');
						var playerTeam = $(this).attr('playerTeam');
						
						var labelType = 'primary';
						
						if (playerRole == 'Batsmen') {
							labelType = 'warning';
							playerRole = 'Bat';
						}
						if (playerRole == 'Bowler') {
							labelType = 'primary';
							playerRole = 'Bowl';
						} 
						else if (playerRole == 'All Rounder') {
							labelType = 'danger';
							playerRole = 'All';
						}
						
						$('#selectedPlayerTable tbody').append('<tr><td style="float:left"><div class="tLogo16x30 '+playerTeam+'"></div></td><td style="float:left">'+playerName+'</td><td><span class="label label-'+labelType+'" style="font-size: 11px;float:right">'+playerRole+'<span></td><td style="width:30px;"><a onclick="removeSelected('+$(this).val()+')" class="btn btn-primary btn-xs btn-block" style="width:20px;"><i class="fa fa-times"></i></a></td></tr>');
					}
				});

    }
	
	function removeSelected(index){
		
		$("#selectedTeamPlayers").find('option').removeAttr("selected");
		$('#selectedTeamPlayers').val(index);
		moveSelected('selectedTeamPlayers', $('#selectedTeamPlayers option:selected').attr('selectname'));
	}
	
	function validateVote(){
		
		if(testmy1 == 0){
			var replace = $('#vote-submit').html('<div class="alert alert-danger"><strong>Voting Closed</strong> </div>');
			alert("Voting Closed");
			return false;
		}
	
		var selectedTeamPlayers =  $('select#selectedTeamPlayers option');
		var playerMom = document.getElementById('playerMom');
		var winTeam = document.getElementById('winTeam');

		if(selectedTeamPlayers.length != '${totalSelectionAllowed}'){
			$('.toastr-notify').attr('data-message','Please Select ${totalSelectionAllowed} Players');
			$('.toastr-notify').click();
			return false;
		}
		var selectedArr = [];
		var batsmenCount = 0;
		var bowlerCount = 0;
		var allRounderCount = 0;
		
		$(selectedTeamPlayers).each(function()
			{
				if($(this).val() !=-1){
					
					if($(this).attr('playerRole') == 'Batsmen')
						batsmenCount++;
					if($(this).attr('playerRole') == 'Bowler')
						bowlerCount++;
					if($(this).attr('playerRole') == 'All Rounder')
						allRounderCount++;
					
					selectedArr.push($(this).val());
				}
			});
		
		/*if(batsmenCount > '${BatsmenCount}'){
			
			$('.toastr-notify').attr('data-message','Only ${BatsmenCount} batsmen Allowed');
			$('.toastr-notify').click();
			return false;
		}
		else if(bowlerCount > '${BowlerCount}'){
			$('.toastr-notify').attr('data-message','Only ${BowlerCount} Bowler Allowed');
			$('.toastr-notify').click();
			return false;
		}
		else if(allRounderCount> '${AllRounderCount}'){
			$('.toastr-notify').attr('data-message','Only ${AllRounderCount} All Rounder Allowed');
			$('.toastr-notify').click();
			return false;
		}*/
		document.getElementById('selectedPlayersIds').value = selectedArr.join("|");
		
		if(playerMom.value =='-1'){
			$('.toastr-notify').attr('data-message','Please Select your Power Player');
			$('.toastr-notify').click();
			return false;
		}
		
		if(winTeam.value =='-1'){
			$('.toastr-notify').attr('data-message','Please predict winner team');
			$('.toastr-notify').click();
			return false;
		}
	

		document.forms[0].submit();
	}
</script>