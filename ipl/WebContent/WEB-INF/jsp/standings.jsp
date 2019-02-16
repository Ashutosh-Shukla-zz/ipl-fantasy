<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.table > thead > tr > th{
background-color: ;
color: white !important;
background-color: rgb(1, 25, 66) !important
}
.table {
overflow-x:hidden !important; 
}
</style>

<!-- MIDDLE -->
<section id="middle">




	<div id="content" class="padding-20">
	
		<div id="panel-1" class="panel panel-default">
						<div class="panel-heading">
							<span class="title elipsis">
								<strong>User Standing</strong> <!-- panel title -->
							</span>

							<!-- right options -->
							<ul class="options pull-right list-inline">
								<li><a href="#" class="opt panel_colapse" data-toggle="tooltip" title="Colapse" data-placement="bottom"></a></li>
								<!-- <li><a href="#" class="opt panel_fullscreen hidden-xs" data-toggle="tooltip" title="Fullscreen" data-placement="bottom"><i class="fa fa-expand"></i></a></li>
								<li><a href="#" class="opt panel_close" data-confirm-title="Confirm" data-confirm-message="Are you sure you want to remove this panel?" data-toggle="tooltip" title="Close" data-placement="bottom"><i class="fa fa-times"></i></a></li> -->
							</ul>
							<!-- /right options -->

						</div>

						<!-- panel content -->
						<div class="panel-body">

							<div class="table-responsive">
								<table class="table table-bordered table-vertical-middle nomargin" id="datatable_sample" >
									<thead>
										<tr>
											<!-- <th class="width-30"></th> -->
											<th>#</th>
											<th>User</th>
											<!-- <th>Played</th> -->
											<th>Points</th>
											<th>Wins</th>
											<th>Lost</th>
											<th>Draw</th>
											
										</tr>
									</thead>
									<tbody>
										<c:set var="count" value="0" scope="page" />
                                        <c:forEach items="${pointsList}" var="pointsList">
                                        <c:set var="count" value="${count + 1}" scope="page"/>
                                            <tr>
                                            	<td><c:out value="${count}"></c:out></td>
                                                <td><a onclick="openHistory('${pointsList.userId}')">
                                                <c:choose>
	                                                <c:when test="${user.userId == pointsList.userId}">
	                                                	<span style="color:#003a3a;font-weight: bold;font-size: 18px">
	                                                </c:when>
	                                                <c:otherwise><span></c:otherwise>
                                                </c:choose>
												<c:out value="${pointsList.userName}"/></span></a>
                                                <%-- <a style="text-decoration: underline;" href="<c:url value="?userid=${pointsList.userId}"></c:url>"><c:out value="${pointsList.userId}"/>
                                                </a> --%>
                                                </td>
                                               <%--  <td>${pointsList.played}</td> --%>
                                               <td>${pointsList.userPoints}</td>
                                                <td>${pointsList.wonCount}</td>
                                                <td>${pointsList.lostCount}</td>
                                                <td>${pointsList.drawCount}</td>
                                                
                                                
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                                                   
									
								</table>
							</div>

						</div>
						<!-- /panel content -->
					</div>
					
	
	</div>
</section>
<!-- /MIDDLE -->

</div>



<script>
	$(window).load(function() {
		loadScript("assets/plugins/datatables/js/jquery.dataTables.min.js", function(){
			loadScript("assets/plugins/datatables/dataTables.bootstrap.js", function(){
				 $('#datatable_sample').dataTable({
					 	"bPaginate": false,
					    "bLengthChange": false,
					    "bFilter": true,
						    "bInfo": false
				 });
				
			});
		});
	});
			
	 function openHistory(userId){
     	var f = document.createElement("form");
     	f.setAttribute('method',"post");
     	f.setAttribute('action',"history");
     	f.setAttribute('id','myHistory');

     	var i = document.createElement("input"); //input element, text
     	i.setAttribute('type',"hidden");
     	i.setAttribute('name',"userId");
     	i.setAttribute('value',userId);
     	f.appendChild(i);
     	document.getElementsByTagName('body')[0].appendChild(f);
     	document.getElementById("myHistory").submit();
     	
     }
</script>