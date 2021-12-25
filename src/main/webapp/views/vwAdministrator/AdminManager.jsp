
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<t:admin>
    <jsp:attribute name="js">
        <script>
            //Add paging
            $(document).ready(function() {
                $('.t1').after('<div id="nav" class="text-center"></div>');
                let itemsShown = 8;
                let itemsTotal = $('.t1 .col-md-3').length;
                let numPages = itemsTotal / itemsShown;
                for (let i = 0; i < numPages; i++) {
                    let pageNum = i + 1;
                    $('#nav').append('<a href="#" class="btn-outline-info btn-sm text-decoration-none rounded-lg border border-info" rel="' + i + '">&emsp;' + pageNum + '&emsp;</a> ');
                }
                $('.t1 .col-md-3').hide();
                $('.t1 .col-md-3').slice(0, itemsShown).show();
                $('#nav a:first').addClass('active');
                $('#nav a').bind('click', function(e) {
                    e.preventDefault();
                    $('#nav a').removeClass('active');
                    $(this).addClass('active');
                    let currPage = $(this).attr('rel');
                    let startItem = currPage * itemsShown;
                    let endItem = startItem + itemsShown;
                    $('.t1 .col-md-3').css('opacity', '0').hide().slice(startItem, endItem).
                    css('display', 'block').animate({
                        opacity: 1
                    }, 300);
                });
            });
            function remove (otp){
                $.getJSON(otp, function (data) {
                    if (data === 'false') {
                        swal({
                            title: "Failed!",
                            text: "Failed deleted to your watchlist!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else
                    {
                        swal({
                            title: "Successfully!",
                            text: "Successfully deleted to your watchlist!",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        })
                            .then(function(){
                                    location.reload();
                                }
                            );
                    }
                });
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <h3 class="text-center mb-3 mt-3 bg-primary text-light" style="font-family: 'Bauhaus 93'">Welcome To Control Manager</h3>
        <div id="grad4">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner" style="width: 50%; height: 50%; margin-left: auto; margin-right: auto">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/public/imgs/AdminMainImage.png" class="d-block w-100" alt=“Decoration” style="height:345px">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/public/imgs/AdManager.png" class="d-block w-100" alt=“Decoration” style="height:350px">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/public/imgs/AdManager1.png" class="d-block w-100" alt=“Decoration” style="height:350px">
                </div>
                <ol class="carousel-indicators">
                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                </ol>
                <button class="carousel-control-prev" type="button" data-target="#carouselExampleIndicators" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-target="#carouselExampleIndicators" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </button>
            </div>
        <%--<div class="row">--%>
        <section class="on-sale">
            <div class="container-fluid t1">
                <div class="row mt-2">
                    <c:choose>
                        <c:when test="${watchlists.size()==0}">
                            <div class="card-body">
                                <p class="card-text">No data</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${watchlists}" var="w">
                                <div class="col-md-3 mb-4 text-center" >
                                    <div class="product-top">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${w.proid}&catid=${w.catid}"><img style="width: 232px;height: 232px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${w.proid}/main.jpg"></a>
                                        <div class="overlay-right">
                                            <a href="${pageContext.request.contextPath}/Product/Detail?id=${w.proid}&catid=${w.catid}" class="btn btn-secondary" title="Detail">
                                                <i class="fa fa-eye" style="border-radius: 50%" aria-hidden="true"></i>
                                            </a>
                                            <button type="button" href="${pageContext.request.contextPath}/WatchList/deleteWatchList?id=${w.id}" onclick="remove('${pageContext.request.contextPath}/WatchList/deleteWatchList?id=${w.id}')" class=" btn btn-secondary" title="Remove from WatchList">
                                                <i class="fa fa-trash" aria-hidden="true" style="border-radius: 50%"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="product-bottom text-center">
                                        <h3 class="mx-auto" style="width: 250px;height: 75px; object-fit: contain">Tên sản phẩm: ${w.proname}</h3>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>
        <%--</div>--%>
    </jsp:body>
</t:admin>
</div>