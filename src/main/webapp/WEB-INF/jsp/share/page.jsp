<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 
<c:if test="${pageView.currentpage-1 != 0}"><a href="javascript:topage('1')" >首页</a></c:if><c:if test="${pageView.currentpage-1 == 0}"><a href="javascript:topage('1')">首页</a></c:if>
 -->
 
 
 <form id="myPageFormId" action="${pageView.forwardPath}" method="post">
<input type="hidden" name="currentpage" value="${pageView.currentpage}"/>
<c:forEach items="${pageView.pagePram}" var="entry" >
	<input type="hidden" name="${entry.key }" value="${entry.value }" />
</c:forEach>


 <ul class="pagination">
<c:if test="${pageView.currentpage-1 == 0}"><li><a>&laquo;</a></li></c:if><c:if test="${pageView.currentpage-1 != 0}"><li><a href="javascript:topage('${pageView.currentpage-1}')" title="上一页">&laquo;</a></li></c:if>
<c:forEach begin="${pageView.pageindex.startindex}"
		end="${pageView.pageindex.endindex}" var="wp">
		<c:if test="${pageView.currentpage==wp}">
			<li><a>${wp}</a></li>
		</c:if>
		<c:if test="${pageView.currentpage!=wp}">
			<li><a href="javascript:topage('${wp}')">${wp}</a></li>
		</c:if>
	</c:forEach>
	<c:if test="${pageView.currentpage == pageView.totalpage}"><li><a>&raquo;</a></li></c:if><c:if test="${pageView.currentpage != pageView.totalpage}"><li><a href="javascript:topage('${pageView.currentpage+1}')" title="下一页">&raquo;</a></li></c:if>
	<!--  
	<c:if test="${pageView.currentpage == pageView.totalpage}"><li><a>&raquo;</a></li></c:if><c:if test="${pageView.currentpage != pageView.totalpage}"><li><a href="javascript:topage('${pageView.currentpage+1}')" title="下一页">&raquo;</a></li></c:if>
	<c:if test="${pageView.currentpage != pageView.totalpage}"><a href="javascript:topage('${pageView.totalpage}')" >末页</a></c:if><c:if test="${pageView.currentpage == pageView.totalpage}"><a href="javascript:topage('${pageView.totalpage}')" >末页</a></c:if> 共<span class="or">${pageView.totalpage}</span>页
-->
</ul>
</form>
<script language="javascript">
<!--
function topage(page){
	var form = document.getElementById("myPageFormId");
	form.currentpage.value=page;
	form.submit();
}
//-->
</script>