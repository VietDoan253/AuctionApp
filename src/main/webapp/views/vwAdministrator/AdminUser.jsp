<%--
  Created by IntelliJ IDEA.
  User: Tri
  Date: 12/9/2021
  Time: 8:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="users" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.User>"/>

<t:manager>
     <jsp:attribute name="js">
        <script></script>
    </jsp:attribute>
    <jsp:body>
        <div class="title-box bg-danger mt-1 mb-3 w-100 justify-content-center" style="border-radius: 5px; font-family: 'Bauhaus 93'">
            <h2>Manager Bidder</h2>
        </div>
        <div class="tableFixHistory" style="cursor: pointer">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Address</th>
                    <th scope="col">Dob</th>
                    <th scope="col">Edit</th>
                    <th scope="col">Upgrade</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${users.size()==0}">
                        <div class="card-body">
                            <p class="card-text">No data</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${users}" var="u">
                            <c:if test="${u.role == 1}">
                                <tr>
                                    <th scope="col">${u.id}</th>
                                    <th scope="col">${u.name}</th>
                                    <th scope="col">${u.email}</th>
                                    <th scope="col">${u.address}</th>
                                    <th scope="col">${u.dob}</th>
                                    <th scope="col">
                                        <a type="button" class="btn btn-outline-info btn-sm btn-block w-50" href="${pageContext.request.contextPath}/Admin/EditUser?id=${u.id}" role="button" >
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </a>
                                    </th>
                                    <th scope="col">
                                        <c:if test="${u.reQuest == 1}">
                                            <button type="button" class="btn btn-outline-success btn-sm btn-block w-50" >
                                                <i class="fa fa-check" aria-hidden="true"></i>
                                            </button>
                                        </c:if>
                                    </th>
                                </tr>
                            </c:if>

                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <div class="title-box bg-danger mt-1 mb-3 w-100 justify-content-center" style="border-radius: 5px; font-family: 'Bauhaus 93'" >
            <h2>Manager Seller</h2>
        </div>
        <div class="tableFixHistory" style="cursor: pointer">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Address</th>
                    <th scope="col">Dob</th>
                    <th scope="col">Edit</th>
                    <th scope="col">Upgrade</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${users.size()==0}">
                        <div class="card-body">
                            <p class="card-text">No data</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${users}" var="u">
                            <c:if test="${u.role == 2}">
                                <tr>
                                    <th scope="col">${u.id}</th>
                                    <th scope="col">${u.name}</th>
                                    <th scope="col">${u.email}</th>
                                    <th scope="col">${u.address}</th>
                                    <th scope="col">${u.dob}</th>
                                    <th scope="col">
                                        <a type="button" class="btn btn-outline-info btn-sm btn-block w-50" href="${pageContext.request.contextPath}/Admin/EditUser?id=${u.id}" role="button">
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </a>
                                    </th>
                                    <th scope="col">
                                        <button type="button" class="btn btn-outline-danger btn-sm btn-block w-50" >
                                            <i class="fa fa-arrow-down" aria-hidden="true"></i>
                                        </button>
                                    </th>
                                </tr>
                            </c:if>

                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </jsp:body>
</t:manager>