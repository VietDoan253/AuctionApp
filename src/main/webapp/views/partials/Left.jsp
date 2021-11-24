<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="categoriesWithDetails1" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>" />
<jsp:useBean id="categoriesWithDetails2" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>"/>
<%--<jsp:useBean id="categoriesWithDetails3" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>"/>--%>

<div class="left col-sm-2">
    <div class="card mt-1" style="width: 225px; position: sticky; top:0; z-index: 1;">
        <h4 class="card-header bg-info">
            Category
        </h4>
        <div class="list-group list-group-flush">
            <c:forEach items="${categoriesWithDetails1}" var="c1">

                <div class="dropright">
                        <a href="#" class="list-group-item list-group-item-action  " aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-caret-right mr-3" aria-hidden="true"></i>
                            ${c1.catname}
                        </a>
                        <ul class="dropdown-menu ml-0">
                             <c:forEach items="${categoriesWithDetails2}" var="c2">
                                 <c:if test="${c2.pid==c1.catid}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Product/List?id=${c2.catid}">${c2.catname}</a></li>
                                </c:if>
                             </c:forEach>
                        </ul>
                </div>
            </c:forEach>
        </div>
    </div>
</div>