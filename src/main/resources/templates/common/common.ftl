<#--<script type="text/javascript" src="/jquery.jqplot.1.0.9/jquery.jqplot.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.json2.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.pieRenderer.js"></script>

<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.barRenderer.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.pieRenderer.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.categoryAxisRenderer.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.pointLabels.js"></script>


<link rel="stylesheet" type="text/css" href="/jquery.jqplot.1.0.9/jquery.jqplot.css"/>-->
<!--commontemplte-->
<#--
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>


<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>-->


<link href="${rc.contextPath}/jquery-ui-1.12.1.green2/jquery-ui.theme.css" rel="stylesheet"/>
<link href="${rc.contextPath}/jquery-ui-1.12.1.green2/jquery-ui.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
      integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<!-- jqGrid-4.6.0 -->
<link href="${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css" rel="stylesheet"/>
<script type="text/javascript" src="${rc.contextPath}/jquery.jqGrid-4.6.0/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="${rc.contextPath}/jquery.jqGrid-4.6.0/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="${rc.contextPath}/jquery.jqGrid-4.6.0/js/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${rc.contextPath}/jquery-ui-1.12.1.green2/jquery-ui.js"></script>
<script type="text/javascript" src="${rc.contextPath}/jquery.fileDownload.js"></script>

<!--multiselect-->
<link href="${rc.contextPath}/multi-select2/css/multi-select.css" rel="stylesheet"/>
<script type="text/javascript" src="${rc.contextPath}/multi-select2/js/jquery.multi-select.js"></script>
<script type="text/javascript" src="${rc.contextPath}/multi-select2/js/jquery.quicksearch.js"></script>



<!-- bootstrap -->
<#--<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
        integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"
        integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn"
        crossorigin="anonymous"></script>-->
<style>

    /*그리드 폰트사이즈*/
    .ui-widget-content td {
        font-size: 8pt;
    }

    .ui-icon {
        zoom: 125%;
        -moz-transform: scale(1.25);
        -webkit-zoom: 1.25;
        -ms-zoom: 1.25;
    }

    .ui-dialog-title {
        font-size: 10pt;
    }

    .ui-state-default {
        font-size: 10pt;
    }

    div.ui-datepicker {
        font-size: 16px;
    }

    label {
        display: inline-block;
        margin-bottom: .5rem;
        font-size: 11pt;
    }

    .large22 {
        font-size: 11pt;
    }


</style>


<script>


    function loadjscssfile(filename, filetype) {
        if (filetype == "js") { //if filename is a external JavaScript file
            var fileref = document.createElement('script')
            fileref.setAttribute("type", "text/javascript")
            fileref.setAttribute("src", filename)
        }
        else if (filetype == "css") { //if filename is an external CSS file
            var fileref = document.createElement("link")
            fileref.setAttribute("rel", "stylesheet")
            fileref.setAttribute("type", "text/css")
            fileref.setAttribute("href", filename)
        }
        if (typeof fileref != "undefined")
            document.getElementsByTagName("head")[0].appendChild(fileref)
    }

    function getToday(){

        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth()+1; //January is 0!
        var yyyy = today.getFullYear();

        if(dd<10) {
            dd='0'+dd
        }

        if(mm<10) {
            mm='0'+mm
        }

        today = yyyy+'-'+mm+'-'+dd;
        //document.write(today);

        return today;
    }

    function getPreviousDate( day){

        var d = new Date();
        d.setDate(d.getDate() - day);
        var datestring =d.getFullYear()+ "-"+ ("0"+(d.getMonth()+1)).slice(-2) + "-"+  ("0" + d.getDate()).slice(-2) ;

        return datestring;
    }
    $(function () {

        //테마 init
        //쿠키가 존재하는 경우.
        if (document.cookie != '' && document.cookie != 'undefined') {
            $("#selectChangeTheme").val(document.cookie);
            loadTheme(document.cookie);
        } else {//쿠키가 존재 하지 않는 경우.........(default theme)
            document.cookie = "flick";
            $("#selectChangeTheme").val(document.cookie);

            loadTheme(document.cookie);
        }


        /**
         * datepicker i18n
         */
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            showMonthAfterYear: true,
            yearSuffix: '년'
        });

    });


    function loadTheme(selectedId) {
        if (selectedId == 'green2') {
            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.green2/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
        } else if (selectedId == 'green') {
            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.green/jquery-ui.theme.css", "css") ////dy
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy

        } else if (selectedId == 'red') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.red/jquery-ui.theme.css", "css") ////dy
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy
        } else if (selectedId == 'gray') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.custom/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy
        } else if (selectedId == 'swanky') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.swanky/jquery-ui.theme.css", "css");
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css");
        } else if (selectedId == 'dotluv') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.dotluv/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
        } else if (selectedId == 'excitebike') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.excitebike/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")

        }
        else if (selectedId == 'sunny') {
            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.sunny/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
        }
        else if (selectedId == 'trontastic') {
            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.trontastic/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")

        } else if (selectedId == 'papergrind') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.papergrind/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
        } else if (selectedId == 'green3') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.green3/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
        } else if (selectedId == 'redmonde') {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.redmonde/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
        } else {

            loadjscssfile("${rc.contextPath}/jquery-ui-1.12.1.flick/jquery-ui.theme.css", "css")
            loadjscssfile("${rc.contextPath}/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
        }

        document.cookie = selectedId;
    }





</script>
<style>

    /*그리드 폰트사이즈*/
    .ui-widget-content td {
        font-size: 8pt;
    }

    .ui-icon {
        zoom: 125%;
        -moz-transform: scale(1.25);
        -webkit-zoom: 1.25;
        -ms-zoom: 1.25;
    }

    .ui-dialog-title {
        font-size: 10pt;
    }

    .ui-state-default {
        font-size: 10pt;
    }

    /*로딩 이미지*/
    #loadingImage {
        position: absolute;
        top: 0px;
        left: 0px;
        width: 100%;
        height: 100%;

        /*width: 500px;
        height: 500px;*/
        background-color: #666;
        background-image: url('${rc.contextPath}/image/loading3.gif');
        background-repeat: no-repeat;
        background-position: center;
        z-index: 10000000;
        opacity: 0.4;
    }


    div.ui-datepicker {
        font-size: 16px;
    }

    label {
        display: inline-block;
        margin-bottom: .5rem;
        font-size: 11pt;
    }

    .large22 {
        font-size: 11pt;
    }





</style>
<script>

    function queryFormatter(cellvalue, options, rowObject) {
        var res = cellvalue.split(";");

        var id = rowObject.id;

        return "<div class='query_text_and_response' query_id='"+id +"'>   <a   style='color: deepskyblue'>" + res[0] + " </a><br/>&nbsp;&nbsp;&nbsp;" + res[1]+ "</div>";

    };

    //query_continuation
    function query_continuation_formatter(cellvalue, options, rowObject) {
        var result = "false";

        if (cellvalue == 1) {
            result = "true";
        } else {
            result = "false";
        }
        return result;

    };


    function query_work_status_formatter(cellvalue, options, rowObject) {
        var result = "";

        if (cellvalue == 0) {
            result = "작업전";
        } else if (cellvalue == 1) {
            result = "작업완료";
        } else if (cellvalue == 2) {
            result = "v ";
        }
        return result;

    };


    function queryRouteFormatter(cellvalue, options, rowObject) {
        var result = "";
        /*P1,P2,AE,P5*/
        if (cellvalue == 0) {
            result = "P1";
        } else if (cellvalue == 1) {
            result = "P2";
        } else if (cellvalue == 2) {
            result = "AE";
        } else if (cellvalue == 3) {
            result = "P5";
        }
        return result;

    };

    function queryRouteFormatter2(cellvalue, options, rowObject) {
        var result = "";
        /*P1,P2,AE,P5*/
        if (cellvalue == "0") {
            result = "P1";
        } else if (cellvalue == "1") {
            result = "P2";
        } else if (cellvalue == "2") {
            result = "AE";
        } else if (cellvalue == '3') {
            result = "P5";
        } else {
            result = "";
        }
        return result;

    };


    function blockYnFormatter(cellvalue, options, rowObject) {

        var result = "";

        if (cellvalue == "1") {
            result = "O";
        } else {
            result = "X";
        }
        return result;

    };



</script>

