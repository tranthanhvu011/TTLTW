<%@ page import="model.News" %><%--
  Created by IntelliJ IDEA.
  User: Nguyen Nhu Toan
  Date: 2023-11-21
  Time: 10:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/common/taglib.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tin tuc</title>
    <%@include file="/common/libraries.jsp"%>
    <link rel="stylesheet" href="../resources/css/user/news.css">
</head>
<style>
    body {
        background-color: #F5F5FA;
    }

    * {
        font-size: 14px;
        font-family: Inter, Helvetica, Arial, sans-serif;
    }
</style>
<body>

<%@include file="/common/header.jsp" %>
<div class="container">
<div class="news-container" style="background-color: #eee;">
    <div class="container" style="background-color: white;margin-top: -10px;width: 1230px;">
        <fmt:setLocale value="${lang}" scope="session" />
        <fmt:bundle basename="messages">
        <p style="color: #6c757d;font-size: 50px;font-weight: 500;margin-top: 10px;"><fmt:message key="News"/></p>
        </fmt:bundle>

        <div class="row news-main  ">
<div class="news-left col-md-6">
    <%
        News news = (News) request.getAttribute("news");
        News news2 = (News) request.getAttribute("news2");
        News news3 = (News) request.getAttribute("news3");
        News news4 = (News) request.getAttribute("news4");
        News news5 = (News) request.getAttribute("news5");
        News news6 = (News) request.getAttribute("news6");
        News news7 = (News) request.getAttribute("news7");
        News news8 = (News) request.getAttribute("news8");
        News news9 = (News) request.getAttribute("news9");
    %>
        <img style="width: 700px; height: 400px;" src="<%= news.getUrl_image()%>">
        <p class="title-news"> <a href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985" target="_blank"><%= news.getTitle()%></a></p>
        <div class="date">
            <i class="fa-regular fa-clock"></i>
            <p>  <%= news.getCreate_at()%></p>
        </div>
</div>

            <div class="new-right col-md-6">
                <div class="news-item news-right">
                    <img style="height: 100px;" src="<%=news2.getUrl_image()%>">
                    <div class="news-content">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news2.getTitle()%></a></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news2.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
                <div class="news-item">
                    <img style="height: 100px;" src="<%=news3.getUrl_image()%>">
                    <div class="news-content news-right">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news3.getTitle()%></a></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news3.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
                <div class="news-item news-right">
                    <img style="height: 100px;" src="<%=news4.getUrl_image()%>">
                    <div class="news-content">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news4.getTitle()%></a></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news4.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row news-other">
            <div class="col-md-6">
                <div class="news-item">
                    <img style="height: 200px;" src="<%=news5.getUrl_image()%>">
                    <div class="news-content">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news5.getTitle()%></a></p>
                        <p class="news-noidung"> <%=news5.getContent()%></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news5.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
                <div class="news-item">
                    <img style="height: 200px;" src="<%=news6.getUrl_image()%>">
                    <div class="news-content">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news6.getTitle()%></a></p>
                        <p class="news-noidung">  <%=news6.getContent()%></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news6.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
                <div class="news-item">
                    <img style="height: 200px;" src="<%=news7.getUrl_image()%>">
                    <div class="news-content">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news7.getTitle()%></a></p>
                        <p class="news-noidung">  <%=news7.getContent()%></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news7.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
                <div class="news-item">
                    <img style="height: 200px;" src="<%=news8.getUrl_image()%>">
                    <div class="news-content">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news8.getTitle()%></a></p>
                        <p class="news-noidung">  <%=news8.getContent()%></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news8.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
                <div class="news-item" style="margin-bottom: 20px">
                    <img style="height: 200px;" src="<%=news9.getUrl_image()%>">
                    <div class="news-content">
                        <p class="title-news"><a
                                href="https://www.thegioididong.com/tin-tuc/galaxy-s24-ultra-se-trang-bi-snapdragon-8-gen-3-toc-do-khung-1553985"
                                target="_blank"><%= news9.getTitle()%></a></p>
                        <p class="news-noidung">  <%=news9.getContent()%></p>
                        <div class="date">
                            <i class="fa-regular fa-clock"></i>
                            <p><%= news9.getUpdate_at()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<%@include file="/common/footer.jsp"%>
<%@include file="/common/libraries_js.jsp"%>
</body>
</html>
