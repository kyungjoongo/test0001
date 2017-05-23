<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script
            src="https://code.jquery.com/jquery-2.2.4.js"
            integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
            crossorigin="anonymous"></script>
    <script>
        // Shorthand for $( document ).ready()
        $(function () {
            /*   alert("sdlfksdlfksdlfk");


               alert("Sdflksdflksdlfksldkflk!!2222222222");
   */
        });
    </script>
</head>
<body>


    <#if 'test' == 'test111'>
    		같아요 같아
    <#elseif 'test' =='test'>
    	2번째입니다sdlfksdlfksdfl
    <#else>
    	같지않습니다sdlfksdlfksdlfklsdkflk
    </#if>


    <#list arrList as arrOne>
         <p>${arrOne.content}
         	${arrOne.id}
	</#list>


</body>
</html>