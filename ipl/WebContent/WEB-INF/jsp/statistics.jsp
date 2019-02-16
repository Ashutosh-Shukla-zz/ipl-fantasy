<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.table>thead>tr>th {
	background-color:;
	color: white;
	background-color: rgb(1, 25, 66) !important;
}
</style>

<!-- MIDDLE -->
<section id="middle">

	<div id="content" class="padding-20">

		<div class="row">

			<div class="col-md-12 col-sm-12">

				<!-- BOX -->
				<div class="box danger">
					<!-- default, danger, warning, info, success -->

					<div class="box-title">
						<!-- add .noborder class if box-body is removed -->
						<span class="title elipsis"> <strong>Player
								Statistics</strong> <!-- panel title -->
						</span> <i class="fa fa-bar-chart-o"></i>
					</div>

					<div class="box-body text-center"></div>

				</div>
				<!-- /BOX -->

			</div>
			
			<c:forEach items="${playerStatsMap}" var="playerStats">
				<div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
	
					<div class="panel panel-clean">
						<div class=" box-title text-center panel-heading"  style="background-color: #ebebeb !important;">
							<span class="title elipsis"> <strong>${playerStats.key}</strong> <!-- panel title -->
							</span>
	
							<!-- right options -->
							<ul class="options pull-right list-inline">
								<li><a href="#" class="opt panel_colapse"
									data-toggle="tooltip" title="Colapse" data-placement="bottom"></a></li>
								<!-- <li><a href="#" class="opt panel_fullscreen hidden-xs" data-toggle="tooltip" title="Fullscreen" data-placement="bottom"><i class="fa fa-expand"></i></a></li>
									<li><a href="#" class="opt panel_close" data-confirm-title="Confirm" data-confirm-message="Are you sure you want to remove this panel?" data-toggle="tooltip" title="Close" data-placement="bottom"><i class="fa fa-times"></i></a></li> -->
							</ul>
							</div>
							<div class="box-body matchBox venue-7 padding-4 my-box panel-body">
							
									<div class="table-responsive nomargin">
										<table class="table table-condensed nomargin">
											<thead>
												<tr>
													<th style="text-align: center;">Player Name</th>
													<th style="text-align: center;">Role</th>
													<th style="text-align: center;">Points</th>
												</tr>
											</thead>
											<tbody>
												<c:set var="count" value="0" scope="page" />
												<c:forEach items="${playerStats.value}" var="playerStatsList">
												 <c:set var="count" value="${count + 1}" scope="page"/>
												 <c:set var="labelType" value="primary"/>
															<c:if test="${playerStatsList.playerRole == 'Batsmen'}">
																<c:set var="labelType" value="warning"/>	
																<c:set var="playerRole" value="Bat"/>																
															</c:if>
															<c:if test="${playerStatsList.playerRole == 'Bowler'}">
																<c:set var="labelType" value="primary"/>
																<c:set var="playerRole" value="Bowl"/>	
															</c:if>
															<c:if test="${playerStatsList.playerRole == 'All Rounder'}">
																<c:set var="labelType" value="danger"/>	
																<c:set var="playerRole" value="All"/>
															</c:if>
												 <c:if test="${count lt 14}">
													<tr>
														<td>${playerStatsList.playerName}</td>
														<td style="text-align: right;"><span class="label label-${labelType}" style="font-size: 10px">${playerRole}</span></td>
														<td style="text-align: center;">${playerStatsList.totalPoints}</td>
													</tr>
												</c:if>
												</c:forEach>
											</tbody>
										</table>
	
									</div>
	
								</div>
							
							<!-- /right options -->
	
						</div>
					</div>
				</c:forEach>
				
				
				
				<!-- panel content -->
				<div class="panel-body"></div>
				<!-- /panel content -->
			</div>

		</div>
</section>
<!-- /MIDDLE -->





<script>
	$(window).load(function() {

	});
</script>