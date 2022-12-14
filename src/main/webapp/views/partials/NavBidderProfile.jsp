<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />
<div class="header">

        <script>
            function upgrare (otp){
                {
                    $.getJSON(otp, function (data) {
                        if (data == false) {
                            swal({
                                title: "Failed!",
                                text: "Failed request to your upgare!",
                                icon: "error",
                                button: "OK!",
                                dangerMode: true,
                                closeOnClickOutside: false,
                            });
                        } else swal({
                            title: "Successfully!",
                            text: "Successfully request to your upgrare!",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        });
                    });
                }
            }
        </script>

    <!-- Top Nav -->
    <nav class="navbar navbar-expand-lg navbar-light " style="background-image: linear-gradient(#ea8215, #eca45d)">
        <div class="collapse navbar-collapse justify-content-lg-between" id="navbarSupportedContent">
            <a href="${pageContext.request.contextPath}/Home">
                <img src="${pageContext.request.contextPath}/public/imgs/logo.png" class="img-fluid rounded-top" alt="No Loading" style=" width:140px ;height: 70px">
            </a>

            <ul class="navbar-nav">
                <li class="nav-item active mr-4 dropdown">
                    <c:choose>
                        <c:when test="${auth}">
                            <form id="frmLogout" method="post" action="${pageContext.request.contextPath}/Account/Logout"></form>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light" style="font-weight: bold">
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                <c:set var="nameParts" value="${fn:split(authUser.name, ' ')}"/>
                                Hi, <b>${nameParts[0]}!</b>
                                <c:choose>
                                    <c:when test="${authUser.role == 0}">${"(Admin)"}</c:when>
                                    <c:when test="${authUser.role == 1}">${"(Bidder)"}</c:when>
                                    <c:otherwise>${"(Seller)"}</c:otherwise>
                                </c:choose>
                            </a>
                            <ul class="dropdown-menu mt-0 dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                                <c:choose>
                                    <c:when test="${authUser.role == 1}"><li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/BidderProfile">
                                        <i class="fa fa-user" aria-hidden="true"></i> Profile
                                    </a></li></c:when>
                                    <c:when test="${authUser.role == 0}"><li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile">
                                        <i class="fa fa-user" aria-hidden="true"></i> Profile
                                    </a></li></c:when>
                                    <%-- <c:otherwise>${"(Seller)"}</c:otherwise>--%>
                                </c:choose>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/YourProduct?uid=${authUser.id}">
                                    <i class="fa fa-product-hunt" aria-hidden="true"></i> Your Products
                                </a></li>
                                <li><a class="dropdown-item" href="javascript: $('#frmLogout').submit()">
                                    <i class="fa fa-sign-out" aria-hidden="true"></i> Sign out
                                </a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light" style="font-weight: bold">
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                Login/Register
                            </a>
                            <ul class="dropdown-menu mt-0 dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Login">
                                    <i class="fa fa-sign-in mr-1" aria-hidden="true"></i>Login
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Register">
                                    <i class="fa fa-user-plus mr-1" aria-hidden="true"></i> Register
                                </a></li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </nav>

    <nav class="navbar navbar-expand-lg navbar-light bg-light mt-1 ">
        <div class="collapse navbar-collapse justify-content-around" id="navbarNavDropdown">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link mr-5 ml-5 text-success" href="${pageContext.request.contextPath}/Feedback/ViewFeedback">
                        <i class="fa fa-star text-success" aria-hidden="true"></i>
                        Feedback <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link mr-5 ml-5 text-danger" href="${pageContext.request.contextPath}/WatchList?uid=${authUser.id}">
                        <i class="fa fa-heart-o text-danger" aria-hidden="true"></i>
                        Favorite Product
                    </a>
                </li>
                <li class="nav-item mr-5 ml-5">
                    <a class="nav-link text-warning" href="${pageContext.request.contextPath}/Account/YourProduct?uid=${authUser.id}">
                        <i class="fa fa-newspaper-o text-warning" aria-hidden="true"></i>
                        On Auction</a>
                </li>
                <li class="nav-item mr-5 ml-5">
                    <a class="nav-link text-info" href="${pageContext.request.contextPath}/Account/YourProduct?uid=${authUser.id}">
                        <i class="fa fa-check-square text-info" aria-hidden="true"></i>
                        Successful Auction</a>
                </li>

                <li class="nav-item mr-5 ml-5">
                    <button type="button" onclick="upgrare('${pageContext.request.contextPath}/Admin/Upgrage?uid=${authUser.id}')" class="heart btn btn-light ">
                        <i class="fa fa-arrow-circle-up" aria-hidden="true"></i>
                        Upgrage Seller
                    </button>
                  <%-- <a class="nav-link text-secondary " href="add('${pageContext.request.contextPath}/Admin/Upgrare?uid=${authUser.id}">
                        <i class="fa fa-arrow-circle-up" aria-hidden="true"></i>
                        Upgrage Seller</a>--%>
                </li>
            </ul>
        </div>
    </nav>
</div>