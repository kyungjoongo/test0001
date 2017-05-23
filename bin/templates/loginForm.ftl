<!DOCTYPE html>
<head>
    <title>Spring Security Example </title>

<#include "/common/common.ftl">

</head>
<body>



<div class="container">
    <form action="/login/loginAction" method="post">
        <div class="form-group" style="width: 500px">
            <label for="id">Email address:</label>
            <input type="text" name="id" class="form-control" id="id" value="kyungjoon" size="300px">
        </div>
        <div class="form-group" style="width: 500px">
            <label for="password">Password:</label>
            <input type="password" name="password" class="form-control" id="password" value="1114" size="300px">
        </div>

        <button type="submit" class="btn btn-default">Submit</button>
    </form>
</div>
<br/>
<div class="container" style="">


     <#if message??>
     	  <span style="color: red" >
          	${message}
          </span>
     </#if>

</div>


</body>
</html>