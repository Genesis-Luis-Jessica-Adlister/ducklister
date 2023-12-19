<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Viewing All The dao.Ads"/>
    </jsp:include>
    <link href="/css/ads-index.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp">
    <jsp:param name="location" value="search"/>
</jsp:include>


    <div class="container-fluid w-100">

        <div class=" categories-drop-down-row" style="display: flex; align-items: center">
            <div class="categories-drop-down-col" style="width: 100%; display: flex; flex-direction: column; justify-content: center">
                <h1>Here Are all the ads!</h1>

                <form action="/cat" method="post" class="categories-form">
                    <select id="category" name="id" type="text" >
                        <c:forEach var="cat" items="${cats}">
                            <option value="${cat.id}">${cat.title}</option>
                        </c:forEach>
                    </select>
                    <button type="submit">Submit</button>
                </form>
            </div>
        </div>

        <div class="container-fluid w-100">

        <div class="row">
            <div class="arrow">
                <img src="/assets/images/arrow-right-solid.svg" id="arrow-img">
            </div>
            <c:forEach var="ad" items="${ads}">
                <div class="post-card d-flex">

                    <h2>${ad.title}</h2>
                    <p>${ad.description}</p>
                    <div class="ad-img-wrapper">
                        <c:choose>
                            <c:when test="${ad.image == null || ad.image == ''}">
                                <img class="ad-img" src="/assets/images/missing-duck.svg" alt="ad image">
                            </c:when>
                            <c:otherwise>
                                <img src="${ad.image}" alt="ad image" class="ad-img">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <form method="get" action="/ad">
                        <input hidden="hidden" name="ad" value="${ad.id}">
                        <input hidden="hidden" name="from" value="ads">
                        <button class="ad-details" type="submit">View Details</button>
                    </form>

                    <c:if test="${sessionScope.user.id == ad.userId}">
                        <form method="post" action="/delete">
                            <input hidden="hidden" name="adid" value="${ad.id}">
                            <input hidden="hidden" name="from" value="ads">
                            <button class="delete-ad" type="submit">Delete Post</button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>


        </div>
    </div>

    <jsp:include page="/WEB-INF/partials/script.jsp"/>
</body>
<script>

</script>
</html>