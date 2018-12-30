<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>Custom Login Demo - Kakao JavaScript SDK</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>
<body>
<a id="custom-login-btn" href="javascript:loginWithKakao()">
<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
</a>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('0133dcaed0bd462fc689ea050efdfaa9');
    function loginWithKakao() {
      // 로그인 창을 띄웁니다.
      Kakao.Auth.login({
        success: function(authObj) {
          alert("성공"+JSON.stringify(authObj));
          Kakao.API.request({
              url: '/v2/user/me',
              success: function(res) {
                var result =JSON.parse(res);
                alert(result);
              },
              fail: function(error) {
                alert(JSON.stringify(error));
              }
            });
        },
        fail: function(err) {
          alert("에러"+JSON.stringify(err));
        }
      });
    };
  //]]>
</script>

</body>
</html>