<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Create a new Ad"/>
    </jsp:include>
    <link href="${pageContext.request.contextPath}/css/createAd.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp">
    <jsp:param name="location" value="create"/>
</jsp:include>
<div class="container">
    <div id="message" class="messages">
        <%--Form Validation error messages are dynamically placed here with JavaScript--%>
    </div>
    <div class="create-new-ad-text">
    <h1>Create a new Ad</h1>
    </div>
    <form action="/ads/create" method="post" id="create-ad-form">
        <%--  if the user tries to subit a from with missing information, keep the values for the fields that they DID fill in    --%>
        <div class="left-content">
        <div class="form-group">
            <c:choose>
                <c:when test="${ad.title != null}">
                    <div id="title-error">
                            <%-- dynamically created JS goes here if the user does not type in a title   --%>
                    </div>
                    <label for="title">Title</label>
                    <input id="title" name="title" class="form-control" type="text" value="${ad.title}">
                </c:when>
                <c:otherwise>
                    <label for="title">Title</label>
                    <div id="title-error">
                            <%-- dynamically created JS goes here if the user does not type in a title   --%>
                    </div>
                    <input id="title" name="title" class="form-control" type="text">
                </c:otherwise>
            </c:choose>
        </div>
<%--            <hr>--%>
        <div class="form-group">
            <c:choose>
                <c:when test="${ad.description != null}">
                    <div id="description-error">
                            <%-- dynamically created JS goes here if the user does not type in a description   --%>
                    </div>
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control"
                              type="text">${ad.description}</textarea>
                </c:when>
                <c:otherwise>
                    <div id="description-error">
                            <%-- dynamically created JS goes here if the user does not type in a description   --%>
                    </div>
                    <label for="description">Description</label>
                    <textarea id="description" name="description" class="form-control" type="text"></textarea>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="image-upload-wrapper">
            <c:choose>
                <c:when test="${ad.image != null}">
                    <label for="file-upload" class="custom-file-upload">
                        <i class="fa fa-cloud-upload"></i> Upload Image
                        <input type="file" id="file-upload">
                    </label>
                    <input type="hidden" id="image-url" name="image" value="${ad.image}">
                    <img src="${ad.image}" name="adImage" alt="ad image" class="ad-image" id="temp-pic">
                </c:when>
                <c:otherwise>
                    <label for="file-upload" class="custom-file-upload">
                        <i class="fa fa-cloud-upload"></i> Upload Image
                        <input type="file" id="file-upload">
                    </label>
                    <input type="hidden" id="image-url" name="image" value="">
                    <img src="" name="adImage" alt="ad image" class="ad-image" id="temp-pic">
                </c:otherwise>
            </c:choose>
<%--            <img src="src/main/webapp/assets/images/category-ducks.jpeg" id="random-image">--%>
        </div>
        </div>

            <div class="vl"></div>
            <div class="right-content">
        <div class="form-group category">
            <div class="align-p">
            <p><b>Select categories</b></p></div>
            <div id="category-error">
                <%-- dynamically created JS goes here if the user does not select at least one category   --%>
            </div>
            <div class="categories-group">

            <c:choose>
                <c:when test="${generic != null}">
                    <label class="category-label"> Generic
                        <input class="category" type="checkbox" name="generic" value="1" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label> Generic
                        <input class="category" type="checkbox" name="generic" value="1">
                    </label>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${music != null}">
                    <label category-label> Music
<%--                        <img src="images/music.svg">--%>
                        <input class="category" type="checkbox" name="music" value="2" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label> Music
                        <input class="category" type="checkbox" name="music" value="2">
                    </label>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${sports != null}">
                    <label category-label>Sports
                        <input class="category" type="checkbox" name="sports" value="3" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label>Sports
                        <input class="category" type="checkbox" name="sports" value="3">
                    </label>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${seasonal != null}">
                    <label category-label>Sports
                        <input class="category" type="checkbox" name="seasonal" value="4" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label>Sports
                        <input class="category" type="checkbox" name="seasonal" value="4">
                    </label>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${international != null}">
                    <label category-label> International
                        <input class="category" type="checkbox" name="international" value="5" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label> International
                        <input class="category" type="checkbox" name="international" value="5">
                    </label>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${patriotic != null}">
                    <label category-label>Patriotic
                        <input class="category" type="checkbox" name="patriotic" value="6" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label>Patriotic
                        <input class="category" type="checkbox" name="patriotic" value="6">
                    </label>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${movie != null}">
                    <label category-label>Movie
                        <input class="category" type="checkbox" name="movie" value="7" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label>Movie
                        <input class="category" type="checkbox" name="movie" value="7">
                    </label>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${superhero != null}">
                    <label category-label>Superhero
                        <input class="category" type="checkbox" name="superhero" value="8" checked>
                    </label>
                </c:when>
                <c:otherwise>
                    <label category-label>Superhero
                        <input class="category" type="checkbox" name="superhero" value="8">
                    </label>
                </c:otherwise>
            </c:choose>
            </label>
        </div>
            </div>
            </div>
                <div class="btn-align">
                    <button type="submit" id="submit-button" class="btn btn-block btn-primary"> Submit</button>
                </div>

    </form>
</form>

</div>
<jsp:include page="/WEB-INF/partials/script.jsp"/>
<script src="/js/create-ad.js" type="module"></script>

</body>
</html>
