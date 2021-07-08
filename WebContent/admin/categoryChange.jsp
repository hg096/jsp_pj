<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script>
	function categoryChange(e) {
		var Outer = [ "플리스/덤블", "패딩/다운", "코트", "자켓", "바람막이", "가디건/베스트" ];
		var top = [ "스웨트셔츠", "후드/집업", "니트/스웨터", "긴팔티셔츠", "블라우스", "셔츠", "반팔티셔츠" ];
		var bottom = [ "슬랙스", "데님", "코튼팬츠", "숏츠", "스웨트/우븐팬츠", "스커트" ];
		var shoes = [ "스니커즈", "샌들", "슬리퍼" ];
		var etc = [ "양말", "모자", "벨트", "뷰티", "우산", "기타" ];
		var target = document.getElementById("categoryS");

		if (e.value == "아우터")
			var d = Outer;
		else if (e.value == "상의")
			var d = top;
		else if (e.value == "하의")
			var d = bottom;
		else if (e.value == "신발")
			var d = shoes;
		else if (e.value == "기타")
			var d = etc;
		

		
		target.options.length = 0;

		for (x in d) {
			var opt = document.createElement("option");
			opt.value = d[x];
			opt.innerHTML = d[x];
			target.appendChild(opt);
		}
	}
</script>


</head>
<body>

</body>
</html>