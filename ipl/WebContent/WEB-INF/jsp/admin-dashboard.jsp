<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- MIDDLE -->
<section id="middle">


	
	<div id="content" class="padding-20">
		
		
		<div id="panel-misc-portlet-color-r1" class="panel panel-clean">

								<div class="panel-heading text-center">
									<span class="title elipsis"> <strong style="color:red">Update Match details</strong></span>
								</div>
								<div class="panel-body" style="display: block;">
									<div class="col-md-12 col-xs-12 pull-left" >
									
									<div class="col-md-4 col-xs-12" >
										<form action="showMatchDetailsForUpdate" method="post" style="margin-bottom :0px">
										<div class="fancy-form fancy-form-select"><!-- select2 -->
										
										<select class="form-control select2" id="matchId" name="matchId">
											<option value="">Match ID</option>
												<c:forEach items="${staticDataBean.matchFixturesBean}" var="matchFixture">
												${matchFixture.matchStatus}
												<c:if test="${matchFixture.matchStatus == 0}">
													<option value="${matchFixture.matchFixturesId}">${matchFixture.matchFixturesId}</option>
												</c:if>
											</c:forEach>
										</select>
										
										<i class="fancy-arrow-double"></i>
										</div><!-- /select2 -->
										</form>
									</div>
									
									<c:if test="${not empty matchFixturesBean}">
										<div class="col-md-8 col-xs-12 padding-6" >
											<span class="elipsis"><!-- panel title -->
												<strong> Match No: ${matchFixturesBean.matchFixturesId} :: ${matchFixturesBean.teamOneCode } VS ${matchFixturesBean.teamTwoCode }</strong>
											</span>
										</div>
										
										<div class="col-md-12 col-xs-12 padding-6 text-center" >
											<input type="button" class="btn btn-danger my-btn" id="replacable-btn" value="Jodi Lagao" onclick="generateUserFixture()">
											<input type="button" class="btn btn-danger my-btn" id="replacable-btn" value="Jaaaaaduuu" onclick="getMatchResult()">
										</div>
									</c:if>
									
									</div>
									
									<div class="col-md-6 col-xs-12  padding-6" >
										<c:if test="${not empty matchFixturesBean}">
										
										<div class="fancy-form fancy-form-select"><!-- select -->
											<select class="form-control" id="matchWinner" name="matchWinner">
												<option value="-1">---Match Winner ---</option>
												<option value="${matchFixturesBean.teamOneId }">${matchFixturesBean.teamOneCode }</option>
												<option value="${matchFixturesBean.teamTwoId }">${matchFixturesBean.teamTwoCode }</option>
											</select>

									<i class="fancy-arrow"></i>
								</div>
									</c:if>
									</div>
									
									
									<div class="col-md-6 col-xs-12 padding-6" >
										<c:if test="${not empty teamOne}">
										
										<div class="fancy-form fancy-form-select"><!-- select2 -->
										<select class="form-control select2" id="manOfTheMatch" name="manOfTheMatch">
											<option value="-1">--Man Of the Match--</option>
												<c:forEach items="${teamOne.playerBean }" var="player">
													<option value="${player.playerId}">${player.firstName} ${player.lastName}</option>
												</c:forEach>
												<c:forEach items="${teamTwo.playerBean }" var="playerTwo">
													<option value="${playerTwo.playerId}">${playerTwo.firstName} ${playerTwo.lastName}</option>
												</c:forEach>
										</select>
										
										<i class="fancy-arrow-double"></i>
									</div>
									</c:if>
									</div>
									
									<div class="col-md-12 col-xs-12  padding-6 text-center" >
										<c:if test="${not empty matchFixturesBean}">
										
										<span class="elipsis"><!-- panel title -->
											<input type="button" class="btn btn-danger my-btn" id="replacable-btn" value="Launch Missile" onclick="launchMissile()">
										</span>
									</c:if>
									</div>

									<!-- right options -->
									<!-- <ul class="options pull-right list-inline">
										<li><a href="#" class="opt panel_colapse" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Colapse"></a></li>
										<li><a href="#" class="opt panel_fullscreen hidden-xs" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Fullscreen"><i class="fa fa-expand"></i></a></li>
										<li><a href="#" class="opt panel_close" data-confirm-title="Confirm" data-confirm-message="Are you sure you want to remove this panel?" data-toggle="tooltip" title="" data-placement="bottom" data-original-title="Close"><i class="fa fa-times"></i></a></li>
									</ul> -->
									<!-- /right options --><div class="fancy-form fancy-form-select"><!-- select2 -->
										
										</div>

								</div>
								<%-- <c:if test="${not empty teamOne}">
								<!-- panel content -->
								<div class="panel-body">
									<span class="title elipsis">
										<strong>${teamOne.teamName }</strong> <!-- panel title -->
									</span>
									<div class="table-responsive">
										<table class="table table-condensed nomargin">
											<thead>
												<tr>
													<th>Player Name</th>
													<th>Runs</th>
													<th>Wickets</th>
													<th>Run-outs</th>
													<th>Catches</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${teamOne.playerBean }" var="player">
												<tr>
													<td>${player.firstName } ${player.lastName }</td>
													<td><input type="number" name="${player.playerId }-runs" id="${player.playerId }-runs"></td>
													<td><input type="number" name="${player.playerId }-wickets" id="${player.playerId }-wickets"></td>
													<td><input type="number" name="${player.playerId }-runOuts" id="${player.playerId }-runOuts"></td>
													<td><input type="number" name="${player.playerId }-catches" id="${player.playerId }-catches"></td>
													<td><button onclick="savePlayerData('${player.playerId }')" class="label label-success">Save </button></td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>
									
									<hr>
									<span class="title elipsis">
										<strong>${teamTwo.teamName }</strong> <!-- panel title -->
									</span>
									<div class="table-responsive">
										<table class="table table-condensed nomargin">
											<thead>
												<tr>
													<th>Player Name</th>
													<th>Runs</th>
													<th>Wickets</th>
													<th>Run-outs</th>
													<th>Catches</th>
													<th>Action</th>
												</tr>
											</thead>
											<tbody>
											<c:forEach items="${teamTwo.playerBean }" var="playerTwo">
												<tr>
													<td>${playerTwo.firstName } ${playerTwo.lastName }</td>
													<td><input type="number" name="${playerTwo.playerId }-runs" id="${playerTwo.playerId }-runs"></td>
													<td><input type="number" name="${playerTwo.playerId }-wickets" id="${playerTwo.playerId }-wickets"></td>
													<td><input type="number" name="${playerTwo.playerId }-runOuts" id="${playerTwo.playerId }-runOuts"></td>
													<td><input type="number" name="${playerTwo.playerId }-catches" id="${playerTwo.playerId }-catches"></td>
													<td><button onclick="savePlayerData('${playerTwo.playerId }')" class="label label-success">Save </button></td>
												</tr>
											</c:forEach>
											</tbody>
										</table>
									</div>

								</div>
								</c:if> --%>
								<!-- /panel content -->
				
							</div>
							
							
							<div id="panel-misc-portlet-color-r1" class="panel panel-clean">

								<div class="panel-heading text-center">
									<span class="title elipsis"> <strong style="color:red">Update System Parameters</strong></span>
								</div>
								
								<div class="" style="width: 300px;margin: 0px auto"><!-- select2 -->
										
										<select class="form-control select2" id="sysParam" name="sysParam">
											<option value="">System Parameters</option>
												<c:forEach items="${staticDataBean.matchFixturesBean}" var="matchFixture">
												${matchFixture.matchStatus}
												<c:if test="${matchFixture.matchStatus == 0}">
													<option value="${matchFixture.matchFixturesId}">${matchFixture.matchFixturesId}</option>
												</c:if>
											</c:forEach>
										</select>
										
										<i class="fancy-arrow-double"></i>
								</div>
								
								<div class="panel-body" style="display: block;">
									<div class="fancy-form">
										<textarea rows="5" id="dashBoardMsg" class="form-control word-count" data-maxlength="200" data-info="textarea-words-info" placeholder="System Parameters Value"></textarea>
									
										<i class="fa fa-envelope"><!-- icon --></i>
									
									</div>
									<div class="col-md-12 col-xs-12  padding-6 text-center" >
										
										<span class="elipsis"><!-- panel title -->
											<input type="button" class="btn btn-danger my-btn" id="replacable-btn" value="Update Value" onclick="updateMessage()">
										</span>
									</div>
								</div>
								<!-- /panel content -->
				
							</div>
	
	</div>
</section>
<!-- /MIDDLE -->

</div>
	<a style="display: none" href="#" id="update-link" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="Data updatation successful"></a>
	<a style="display: none" href="#" id="update-fixture" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="Data updatation successful"></a>
	<a style="display: none" href="#" id="update-missile" class="btn btn-default toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="success" data-message="Data updatation successful"></a>
	<a style="display: none" href="#" id="update-link-fail" class="btn btn-danger toastr-notify" data-progressBar="true" data-position="top-right" data-notifyType="error" data-message="Data updatation failed"></a>

<script>



jQuery(document).ready(
   		function($) {
	
	$('#matchId').change(function() {
	    var data = "";
	    var matchId = $(this).val();
	    document.forms[0].submit();    
	    
	});
	
	$('#manOfTheMatch').change(function() {
		var matchIdMom  ='${matchId}';
		var playerId = $(this).val();
		if(matchIdMom!=-1)
		$.ajax({
	             type: "POST",
	             url: "updateManOftheMatch",
	             data: "matchIdMom="+matchIdMom+"&playerId=" +playerId,
	             success: function (response) {
	            	 data=response;
	            	 if(data=="true"){
	            		 $('#update-link').click();
	            	 }
	             },
	             error: function (response) {
	            	 $('#update-link-fail').click();
	             }
		});
	});
	
	$('#matchWinner').change(function() {
		var matchIdWin  ='${matchId}';
		var teamId = $(this).val();
		if(matchIdWin!=-1)
		$.ajax({
	             type: "POST",
	             url: "updateMatchWinner",
	             data: "matchIdWin="+matchIdWin+"&teamId=" +teamId,
	             success: function (response) {
	            	 data=response;
	            	 if(data=="true"){
	            		 $('#update-link').click();
	            	 }
	             },
	             error: function (response) {
	            	 $('#update-link-fail').click();
	             }
		});
	});
	
   });
   
	function savePlayerData(playerId){
		var macthIdStat  ='${matchId}';
		var playerRun = $('#'+playerId+'-runs').val();
		var playerWickets = $('#'+playerId+'-wickets').val();
		var playerRunOuts = $('#'+playerId+'-runOuts').val();
		var catches = $('#'+playerId+'-catches').val();
		var data;
		$.ajax({
	             type: "POST",
	             url: "updatePlayerStats",
	             data: "matchId="+macthIdStat+"&playerId=" +playerId +"&runs="+playerRun +"&wickets="+playerWickets +"&runOuts="+playerRunOuts +"&catches="+catches,
	             success: function (response) {
	            	 data=response;
	            	 if(data=="true"){
	            		 $('#update-link').click();
	            	 }
	             },
	             error: function (response) {
	            	 $('#update-link-fail').click();
	             }
		});
	}
	
	
	function launchMissile(){
		var matchId  ='${matchId}';
		var data;
		$.ajax({
	             type: "POST",
	             url: "launchMissile",
	             data: "matchId="+matchId,
	             success: function (response) {
	            	 data=response;
						if(data!=null){
	    	        		 $('#update-missile').attr('data-message','Missile Launched Successfully');
		            		 $('#update-missile').click();
		            	 }
						else{
		            		 $('#update-link-fail').click();
		            	 }
	             },
	             error: function (response) {
	            	 $('#update-link-fail').click();
	             }
		});
		
	}
	
	function generateUserFixture(){
		var matchId  ='${matchId}';
		var data;
		$.ajax({
	             type: "POST",
	             url: "generateUserFixture",
	             data: "matchId="+matchId,
	             success: function (response) {
	            	 data=response;
	            	 if(data!=null){
	            		 
	            		 $('#update-fixture').attr('data-message',data);
	            		 $('#update-fixture').click();
	            	 }
	            	 else{
	            		 $('#update-link-fail').click();
	            	 }
	             },
	             error: function (response) {
	            	 $('#update-link-fail').click();
	             }
		});
	}
	function getMatchResult(){
		var matchId  ='${matchId}';
		var data;
		$.ajax({
	             type: "POST",
	             url: "getMatchResult",
	             data: "matchId="+matchId,
	             success: function (response) {
	            	 data=response;
	            	 if(data=="done"){
	            		 $('#update-link').click();
	            	 }
	            	 else{
	            		 $('#update-link-fail').click();
	            	 }
	             },
	             error: function (response) {
	            	 $('#update-link-fail').click();
	             }
		});
	}
	
	function updateMessage(){
		var dashBoardMsg  =$('#dashBoardMsg').val();
		if(dashBoardMsg == ''){
			$('#update-link-fail').attr('data-message','Message Toh Add Kar');
			$('#dashBoardMsg').focus();
			$('#update-link-fail').click();
			return false;
		}
		
		var data;
		$.ajax({
	             type: "POST",
	             url: "updateDashBoardMsg",
	             data: "dashBoardMsg="+dashBoardMsg,
	             success: function (response) {
	            	 data=response;
	            	 if(data=="done"){
	            		 $('#update-link').click();
	            	 }
	            	 else{
	            		 $('#update-link-fail').click();
	            	 }
	             },
	             error: function (response) {
	            	 $('#update-link-fail').click();
	             }
		});
	}
</script>