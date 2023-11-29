<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://kit.fontawesome.com/6caf283963.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/users/boardList.css">
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h2 {
            float: left;
        }

        .container {
            text-align: center;
        }

        .board-header {
            font-weight: bold;
        }

        .board-row {
            display: flex;
            width: 100%;
        }

        .header-row {
            display: flex;
        }

        .search-container, .search-button {
            display: inline-block;
            width: 500px;
            height: 40px;
        }

        .search-container {
            background-color: #f2f2f2;

        }

        .search-box {
            width: 150px;
            display: inline-block;
            color: #000;
            font-size: 12px;
            border: 1px solid #ddd;
        }


        .pagination-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 20px;
            text-align: center;
        }

        .pagination {
            display: inline-block;
        }

        .pagination a {
            color: black;
            float: left;
            padding: 6px 12px;
            text-decoration: none;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
    </style>

    <script>
        var selectedValue;
        $(function () {
            $("#category-select").val(${pVO.postSort}).prop("selected", true);
            if (${boardcat=="free"}) {
                $(".free").addClass("btn-secondary").removeClass("btn-outline-secondary");
                $(".ask").addClass("btn-outline-secondary").removeClass("btn-secondary");
                $(".tip").addClass("btn-outline-secondary").removeClass("btn-secondary");
            } else if (${boardcat=="ask"}) {
                $(".ask").addClass("btn-secondary").removeClass("btn-outline-secondary");
                $(".free").addClass("btn-outline-secondary").removeClass("btn-secondary");
                $(".tip").addClass("btn-outline-secondary").removeClass("btn-secondary");
            } else if (${boardcat=="tip"}) {
                $(".tip").addClass("btn-secondary").removeClass("btn-outline-secondary");
                $(".ask").addClass("btn-outline-secondary").removeClass("btn-secondary");
                $(".free").addClass("btn-outline-secondary").removeClass("btn-secondary");
            }
            $('#category-select').val(${pVO.category});
            $('#category-select').change(function () {
                selectedValue = $(this).val();
                if (selectedValue == 0) {
                    window.location.href = "${pageContext.servletContext.contextPath}/board/${boardcat}";
                } else {
                    window.location.href = "${pageContext.servletContext.contextPath}/board/${boardcat}?category=" + selectedValue;
                }
            });
            $("#postSort").change(function () {
                var sortvalue = $(this).val();
                window.location.href = "${pageContext.servletContext.contextPath}/board/${boardcat}?category=${pVO.category}&postSort=" + sortvalue + "&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}";
            });
        });
    </script>
</head>
<div class="container">
    <div class="container-top">
        <div class="container-head" style="height: 80px; border-bottom: 2px solid #73351F">
            <h2 class="main-title" style="margin-top: 0px; font-weight: bold; font-size: 35px">
                <c:if test="${boardcat=='free'}">
                    자유
                </c:if>
                <c:if test="${boardcat=='tip'}">
                    노하우
                </c:if>
                <c:if test="${boardcat=='ask'}">
                    질문
                </c:if>
                게시판
            </h2>
        </div>
        <div class="d-flex" style=" margin-top: 10px">
            <div style="display: flex;  text-align: center; align-items: center; margin: 0 auto">
                <div class="button-container" style="margin-top: 0px">
                    <button class="btn btn-outline-secondary free" style="margin-right: 20px"
                            onclick="location.href='${pageContext.servletContext.contextPath}/board/free'">자유 게시판
                    </button>
                    <button class="btn btn-outline-secondary ask" style="margin-right: 20px"
                            onclick="location.href='${pageContext.servletContext.contextPath}/board/ask'">질문 게시판
                    </button>
                    <button class="btn btn-outline-secondary tip"
                            onclick="location.href='${pageContext.servletContext.contextPath}/board/tip'">노하우 게시판
                    </button>
                </div>
            </div>
        </div >
            <div style="display: flex; justify-content: space-between; padding: 5px 20px 20px 20px">
                <select class="form-select" style="width: fit-content" id="postSort" name="postSort">
                    <option value="1"
                            <c:if test="${pVO.postSort==1}">
                                selected
                            </c:if>
                    >최신순
                    </option>
                    <option value="2" <c:if test="${pVO.postSort==2}">
                        selected
                    </c:if>>조회순
                    </option>
                    <option value="3" <c:if test="${pVO.postSort==3}">
                        selected
                    </c:if>>추천순
                    </option>
                </select>
                <select class="form-select" id="category-select" style="width: fit-content;" name="category">
                    <option value="0">카테고리</option>
                    <option value="1">IT/프로그래밍</option>
                    <option value="2">디자인</option>
                    <option value="3">영상음향</option>
                </select>
            </div>
        </div>

    <div class="board-container">
        <div class="board-container-set">
        <div class="board-header">
            <div class="header-row">
                <div id="num" style="width: 7%" class="list">번호</div>
                <div id="title" style="width: 50%; text-align: left; padding: 0 20px;" class="list">제목
                </div>
                <div id="user" style="width: 12%" class="list">작성자</div>
                <div id="view" style="width: 7%" class="list"><i class="fa-solid fa-eye" style="color: #0d0d0d;"></i></div>
                <div id="comment" style="width: 7%" class="list"><i class="fa-regular fa-comment-dots" style="color: #0d0d0d;"></i></div>
                <div id="like" style="width: 7%" class="list"><i class="fa-solid fa-heart" style="color: #0d0d0d;"></i></div>
                <div id="date" style="width: 10%" class="list">게시일</div>
            </div>
        </div>
            <hr class="hr-styleset">
        <c:forEach items="${bVO}" var="bvo">
            <div class="board-row">
                <div style="width: 7%" class="list">${bvo.postid}</div>
                <div style="width: 50%; text-align: left; padding: 0 20px;" class="list"><a
                        href="${pageContext.servletContext.contextPath}/board/view?no=${bvo.postid}">${bvo.posttitle}</a>
                </div>
                <div style="width: 12%" class="list">${bvo.user_userid}</div>
                <div style="width: 7%" class="list">${bvo.views}</div>
                <div style="width: 7%" class="list">${bvo.commentAmount}</div>
                <div style="width: 7%" class="list">${bvo.likeAmount}</div>
                <div style="width: 10%" class="list">${bvo.date}</div>
            </div>
            <hr class="hr-styleset">
        </c:forEach>


        <div class="search-container">
            <form action="${pageContext.request.contextPath}/board/${boardcat}" class="d-flex board-bottom" method="get">
                <select class="form-select" style="width: fit-content; margin-right: 10px" name="searchKey">
                    <option value="all">전체</option>
                    <option value="title">제목</option>
                    <option value="author">작성자</option>
                    <option value="content">글내용</option>
                </select>
                <input type="text" class="form-control" name="searchWord" placeholder="검색어를 입력하세요" style="margin-right: 10px">
                <input type="submit" class="btn btn-secondary" value="검색">
                <input type="hidden" name="category" value="${pVO.category}"/>
            </form>
        </div>

        <div style="display: flex; justify-content: space-between">
            <div></div>
            <div class="pagination-container" style="margin: 0 auto; margin-top: 20px; width: fit-content">
                <div class="pagination" style="display: flex">
                    <div class="paging">
                        <c:if test="${pVO.page > 1}">
                            <button class="btn btn-outline-secondary" onclick="location.href='?page=${pVO.page - 1}'
                            <c:if test="${pVO.category !=''}">
                                    +'&category=${pVO.category}'
                            </c:if>
                            <c:if test="${pVO.searchWord!=''}">
                                    +'&searchKey=${pVO.searchKey}'
                                    +'&searchWord=${pVO.searchWord}'
                            </c:if>
                            <c:if test="${pVO.postSort!=''}">
                                    +'&postSort=${pVO.postSort}'
                            </c:if>
                                    "><
                            </button>
                        </c:if>
                        <c:forEach var="i" begin="${pVO.startPage}" end="${pVO.startPage + pVO.onePageCount - 1}">
                            <c:if test="${i <= pVO.totalPage}">
                                <c:choose>
                                    <c:when test="${i != pVO.page}">
                                        <button class="btn btn-outline-secondary" onclick="location.href='?page=${i}'
                                        <c:if test="${pVO.category !=''}">
                                                +'&category=${pVO.category}'
                                        </c:if>
                                        <c:if test="${pVO.searchWord!=''}">
                                                +'&searchKey=${pVO.searchKey}'
                                                +'&searchWord=${pVO.searchWord}'
                                        </c:if>
                                        <c:if test="${pVO.postSort!=''}">
                                                +'&postSort=${pVO.postSort}'
                                        </c:if>
                                                ">${i}</button>
                                    </c:when>
                                    <c:otherwise>
                                        <strong class="btn btn-outline-secondary" style="font-weight: bold">${i}</strong>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                        <c:if test="${pVO.page < pVO.totalPage}">
                            <button class="btn btn-outline-secondary" onclick="location.href='?page=${pVO.page + 1}'
                            <c:if test="${pVO.category !=''}">
                                    +'&category=${pVO.category}'
                            </c:if>
                            <c:if test="${pVO.searchWord!=''}">
                                    +'&searchKey=${pVO.searchKey}'
                                    +'&searchWord=${pVO.searchWord}'
                            </c:if>
                            <c:if test="${pVO.postSort!=''}">
                                    +'&postSort=${pVO.postSort}'
                            </c:if>
                                    ">>
                            </button>
                        </c:if>
                    </div>
                </div>
            </div>
            <a style="margin-top: 20px; color: white" href="${pageContext.servletContext.contextPath}/board/${boardcat}/write" class="btn btn-secondary">글 작성</a>
        </div>
        </div>
        <div class="container_bottom"></div>
    </div>
</div>
</body>
</html>
<%@include file="../header_footer/footer.jspf" %>