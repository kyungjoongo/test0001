<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>_STATSSTATSSTATS_STATSSTATSSTATSSTATSSTATS</title>

<#include "/common/common.ftl">


    <script>

        $(function () {

            //쿠키가 존재하는 경우.
            if (document.cookie != '' && document.cookie != 'undefined') {
                $("#selectChangeTheme").val(document.cookie);
                loadTheme(document.cookie);
            } else {//쿠키가 존재 하지 않는 경우.........(default theme)
                document.cookie = "excitebike";
                $("#selectChangeTheme").val(document.cookie);

                loadTheme(document.cookie);
            }

            //그리드 로딩..
            loadGrid();

            $("#modifyDialog").dialog({
                autoOpen: false,
                title: '수정',
                modal: false,
                resizable: true,
                width: 900,
                maxHeight: 400,
                closeText: 'fechar',
                draggable: true

            });

            $("#filterDialog").dialog({
                autoOpen: false,
                title: '필터',
                modal: false,
                resizable: true,
                width: 900,
                maxHeight: 400,
                closeText: 'fechar',
                draggable: true

            });


            //#####################
            //excel 파일업로드 event
            //#####################
            /*파일submit시 file upload*/
            function submitFile() {

                if (confirm($("#file")[0].value + "을 Import 하시겠습니까?")) {
                    if ($("#file")[0].value == '') {
                        //alert("파일을 선택하세요^^");
                        return false;
                    } else {//파일이 존재할경우에 진행
                        var formData = new FormData();
                        formData.append('file', $('input[id=file]')[0].files[0]);
                        console.log("form data " + formData);
                        $("#LoadingImage").show();
                        $.ajax({
                            url: '/nda/importExcel',
                            data: formData,
                            processData: false,
                            contentType: false,
                            type: 'POST',
                            success: function (data) {
                                $("#LoadingImage").hide();
                                //alert("upload sucess");

                                var parsedResult = JSON.parse(data);
                                alert(parsedResult.result);

                                $('#list2').setGridParam({
                                    page: 1,
                                    datatype: "json"
                                }).trigger('reloadGrid');
                            },
                            error: function (err) {
                                alert(err);
                            }
                        });
                    }
                } else {
                    return false;
                }


            }


            //#####################
            //파일선택시 submit file
            //#####################
            $('#file').on("change", function () {
                submitFile();
            });


            /**
             * excelExport event
             */
            $("#btnExport").on("click", function () {

                if (confirm("진짜 Export 하실건가요?")) {

                    $("#LoadingImage").show();

                    var params = "?sortColumn=" + $("#sortColumn").val()
                            + "&sortOrder=" + $("#sortOrder").val()
                            + "&startDate="+  $("#startDate").val()
                           + "&endDate="+  $("#endDate").val()
                            + "&searchWord=" + $("#searchWord").val().trim()
                            + "&searchColumn=" + $('#searchColumn option:selected').attr('val').trim();
                    ;

                    $.fileDownload("/stats/exportToExcel" + params, {
                        successCallback: function (url) {
                            $("#LoadingImage").hide();
                            // alert("Export 성공");
                        },
                        failCallback: function (responseHtml, url) {
                            alert("Export fail");
                            $("#LoadingImage").hide();
                        }
                    });

                }

            });


            $("#btnDownload").on("click", function () {

                if (confirm("진짜 CSV Export 하실건가요?")) {


                    var params = "?sortColumn=" + $("#sortColumn").val()
                            + "&sortOrder=" + $("#sortOrder").val()
                            + "&startDate="+  $("#startDate").val()
                            + "&endDate="+  $("#endDate").val()
                            + "&searchWord=" + $("#searchWord").val().trim()
                            + "&searchColumn=" + $('#searchColumn option:selected').attr('val').trim();
                    ;

                    $("#LoadingImage").show();
                    $.fileDownload("/stats/exportToCsv"+ params, {
                        successCallback: function (url) {
                            $("#LoadingImage").hide();
                            //alert("Export 성공");
                        },
                        failCallback: function (responseHtml, url) {
                            alert("Export fail");
                        }
                    });
                }

            });


            $("#selectChangeTheme").on("change", function () {
                var selectedId = $("#selectChangeTheme option:selected").attr("id");
                loadTheme(selectedId);
            });

            function loadTheme(selectedId) {

                if (selectedId == 'green2') {
                    loadjscssfile("/jquery-ui-1.12.1.green2/jquery-ui.theme.css", "css")
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
                } else if (selectedId == 'green') {
                    loadjscssfile("/jquery-ui-1.12.1.green/jquery-ui.theme.css", "css") ////dy
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy

                } else if (selectedId == 'red') {

                    loadjscssfile("/jquery-ui-1.12.1.red/jquery-ui.theme.css", "css") ////dy
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy
                } else if (selectedId == 'gray') {

                    loadjscssfile("/jquery-ui-1.12.1.custom/jquery-ui.theme.css", "css")
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy
                } else if (selectedId == 'swanky') {

                    loadjscssfile("/jquery-ui-1.12.1.swanky/jquery-ui.theme.css", "css");
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css");
                } else if (selectedId == 'dotluv') {

                    loadjscssfile("/jquery-ui-1.12.1.dotluv/jquery-ui.theme.css", "css")
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")
                } else if (selectedId == 'excitebike') {

                    loadjscssfile("/jquery-ui-1.12.1.excitebike/jquery-ui.theme.css", "css")
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")

                } else {
                    loadjscssfile("/jquery-ui-1.12.1.trontastic/jquery-ui.theme.css", "css")
                    loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css")

                }

                document.cookie = selectedId;
            }

            $("#btnLogout").on("click", function () {
                location.href = "/webapp/logoutAction";
            });


            //검색어 search event
            $("#btnSearch").on("click", function () {

                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();

                /*str.replace(/-/gi, "");*/

                startDate = startDate.replace(/-/gi, "");
                endDate = endDate.replace(/-/gi, "");

                /*alert(startDate);
                alert(endDate);*/

                if (parseInt(startDate) > parseInt(endDate)) {
                    alert("시작일가 종료일보다 클 수 없습니다.");
                    return false;
                }

                var searchWord = $("#searchWord").val();

                var searchColumn = $('#searchColumn option:selected').attr('val');
                //alert(searchColumn);

                //url --> stats/getList
                $("#LoadingImage").show();
                $('#list2').setGridParam({
                    page: 1,
                    datatype: "json",
                    postData: {
                        searchColumn: searchColumn
                        , searchWord: searchWord
                        , startDate: $("#startDate").val()
                        , endDate: $("#endDate").val()
                        , sortOrder: $("#sortOrder").val()
                    }, ajaxGridOptions: {
                        complete: function () {

                            $("#LoadingImage").hide();
                        }
                    }
                }).trigger('reloadGrid');

            });


            $("#btnInit").on("click", function () {
                location.href = '/stats/list';

            });


            //선택삭제 버튼 이벤트.
            $("#btnDelete").on("click", function () {

                if (confirm("삭제하시겠습니까?")) {
                    var selRowIds = $("#list2").jqGrid('getGridParam', 'selarrrow');

                    $("#LoadingImage").show();
                    $.ajax({
                        url: '/stats/delete',
                        type: 'post',
                        //async: false,
                        data: {rowIds: selRowIds.toString()},
                        success: function (data) {

                            $("#LoadingImage").hide();
                            $('#list2').setGridParam({
                                page: $("#currentPage").val(),
                                datatype: "json"
                            }).trigger('reloadGrid');
                        }
                    })
                }


            });


            //btnFilter
            $("#btnFilter").on("click", function () {
                $("#filterDialog").dialog("open");
            });

            //btnFilterSubmit
            $("#query_type, #query_route, #query_work_status, #pub_date, #query_continuation").on("change", function () {

                // /stat/getList
                $('#filterDialog').dialog('close');
                $("#LoadingImage").show();
                $('#list2').setGridParam({
                    page: $("#currentPage").val(),
                    postData: {
                        query_type: $("#query_type").val(),
                        query_route: $("#query_route").val(),
                        page: $("#currentPage").val(),
                        query_continuation: $("#query_continuation").val(),
                        query_work_status: $("#query_work_status").val(),
                        pub_date: $("#pub_date").val(),
                        rows: $("#rows").val()
                    },
                    datatype: "json"
                    , ajaxGridOptions: {
                        complete: function () {

                            $("#LoadingImage").hide();
                        }
                    }
                }).trigger('reloadGrid');


            });


            $("#btnPopupSubmit").on("click", function () {
                $.ajax({
                    url: '/stats/update',
                    type: 'post',
                    async: false,
                    data: {
                        rowId: $("#rowId").val(),
                        query_text: $("#query_text").val(),
                        query_response: $("#query_response").val()

                    },
                    success: function (data) {
                        $('#modifyDialog').dialog('close');
                        $('#list2').setGridParam({
                            page: $("#currentPage").val(),
                            datatype: "json"
                        }).trigger('reloadGrid');
                    }
                })

            });


            $('input[id=query_text], input[id=query_response]').on('keydown', function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    $("#btnPopupSubmit").trigger("click");
                }
            });

            $('input[id=searchWord]').on('keydown', function (e) {
                if (e.which == 13) {
                    e.preventDefault();
                    $("#btnSearch").trigger("click");
                }
            });


        });//onReady End


        function queryFormatter(cellvalue, options, rowObject) {
            var res = cellvalue.split(";");
            return "<a style='color: deepskyblue'>" + res[0] + " </a><br/>" + res[1];

        };

        //query_continuation
        function query_continuation_formatter(cellvalue, options, rowObject) {
            var result= "false";

            if ( cellvalue==1){
                result= "true";
            }else{
                result= "false";
            }
            return result;

        };


        function query_work_status_formatter(cellvalue, options, rowObject) {
            var result= "";

            if ( cellvalue==1){
                result= "작업완료";
            }else if ( cellvalue==0){
                result= "미작업";
            }else if ( cellvalue==2){
                result= 2;
            }else {
                result= 3;
            }
            return result;

        };


        function loadGrid() {

            $("#list2").jqGrid({
                url: '/stats/getList',
                datatype: "json",
                postData: {
                    startDate: $("#startDate").val(),
                    endDate: $("#endDate").val()
                },
                colNames: [
                    'id',
                    '쿼리',
                    '기존라우팅',
                    '변경라우팅',
                    '타입',
                    '연속질의',
                    '작업상태',
                    '일괄블럭여부',
                    'QM라우팅',
                    'QM키',
                    '작업자',
                    'QC',
                    'pub_date'
                ],
                colModel: [
                    {name: 'id', width: 50, sortable: true, sorttype: "number"},
                    {
                        name: 'query_text_and_response',
                        width: 350,
                        sortable: true,
                        sorttype: "text",
                        formatter: queryFormatter
                    },
                    {name: 'query_route', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'query_route', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'query_type', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'query_continuation', width: 100, sortable: true, sorttype: "text", align: 'center', formatter: query_continuation_formatter},
                    {name: 'query_work_status', width: 100, sortable: true, sorttype: "text", align: 'center', formatter: query_work_status_formatter},
                    {name: 'query_blockkeywords', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'worker', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'query_text', width: 170, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'worker', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'qc_sum', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {name: 'pub_date', width: 140, sortable: true, sorttype: "text", align: 'center'}

                ],
                rowNum: 20,
                height: 'auto',
                rowList: [10, 20, 30, 100, 300, 1000],
                pager: '#pager2',
                sortname: 'id',
                viewrecords: true,
                sortorder: "desc",
                caption: "NDA STATS",
                loadonce: false,
                jsonReader: {
                    repeatitems: false,
                    root: function (obj) {

                        return obj.arrList;
                    },
                    page: function (obj) {
                        return obj.page;
                    },
                    total: function (obj) {
                        return obj.total
                    },
                    records: function (obj) {
                        return obj.records;
                    }
                }, onSortCol: function (sortColumn, iCol, sortOrder) {//소트컬럼클릭시 event(/stats/getList)

                    $("#sortColumn").val(sortColumn);
                    $("#sortOrder").val(sortOrder);


                    /*                    $("#LoadingImage").show();*/
                    $('#list2').setGridParam({
                        page: 1,
                        datatype: "json",
                        postData: {
                            sortColumn: sortColumn,
                            sortOrder: sortOrder,
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }, ajaxGridOptions: {
                            complete: function () {

                                /*  $("#LoadingImage").hide();*/
                            }
                        }
                    }).trigger('reloadGrid');


                }
                , gridComplete: function () {

                    var curPage = $('#list2').getGridParam('page');

                    $("#currentPage").val(curPage);
                    $(".btnRowDelete").on("click", function () {

                        if (confirm("삭제하시겠습니까?")) {
                            var selRowIds = $(this).attr("id")
                            $.ajax({
                                url: '/nda/delete',
                                type: 'post',
                                async: false,
                                data: {rowIds: selRowIds.toString()},
                                success: function (data) {
                                    $('#list2').setGridParam({
                                        page: $("#currentPage").val(),
                                        datatype: "json"
                                    }).trigger('reloadGrid');
                                }
                            })
                        }
                    });


                    $(".btnRowModify").on("click", function () {

                        var rowid = $(this).attr("id");

                        $("#rowId").val(rowid);


                        var rowData = $('#list2').jqGrid('getRowData', rowid);
                        var query_text = rowData.query_text;
                        var query_response = rowData.query_response;


                        $("#modifyDialog").dialog("open");
                        $("#query_text").val(query_text);
                        $("#query_response").val(query_response);

                    });


                }
                /*,
                multiselect: 1*/
                //editable : 1
            });


        }//loadGrid End


    </script>
    <style>

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

        /* #prev_pager2{

             background-color: #4297d7;
         }
         #next_pager2{
             background-color: #4297d7;
         }*/

        /*로딩 이미지*/
        #LoadingImage {
            position: fixed;
            top: 0px;
            right: 0px;
            width: 100%;
            height: 100%;
            background-color: #666;
            background-image: url('/image/loading3.gif');
            background-repeat: no-repeat;
            background-position: center;
            z-index: 10000000;
            opacity: 0.4;
        }

        /*choosefile hidden*/
        /*  input#file {
              display: inline-block;
              width: 100%;
              padding: 120px 0 0 0;
              height: 100px;
              overflow: hidden;
              -webkit-box-sizing: border-box;
              -moz-box-sizing: border-box;
              box-sizing: border-box;
              !*background: url('http://archisnapper.com/cloud.png') center center no-repeat #e4e4e4;*!
              border-radius: 20px;
              background-size: 150px 100px;
          }*/
    </style>
</head>
<body>

<div class="">


    <!--################-->
    <!--상단버튼div-->
    <!--################-->
    <div class="container-fluid">
        <input type="hidden" id="rowId" value=""/>
        <input type="hidden" id="currentPage" value=""/>
        <input type="text" id="sortColumn" value="id"/>
        <input type="text" id="sortOrder" value="desc"/>
        <input type="hidden" id="rows" value="10"/>


        <div class="row">

        <#--
                    <label class="ui-state-default" id="btnDelete">&nbsp;선택삭제&nbsp;</label>&nbsp;-->
            <form id="form1" method="POST" action="/tinkerbell/upload" enctype="multipart/form-data">

                <input type="file" id="file" style="display: none"/>
                <label for="file" class="ui-state-default">&nbsp;Import&nbsp;</label>
                <label class="ui-state-default" id="btnExport">&nbsp;Export&nbsp;</label>

                <label class="ui-state-default" id="btnDownload">&nbsp;CSV&nbsp;</label>
                <label class="ui-state-default" id="btnFilter">&nbsp;Filter&nbsp;</label>
            </form>
        <#--<input type="button" class="ui-state-default" value="filter" id="btnFilter">-->


        </div>
    <#--<div class="row">
        &nbsp;
    </div>-->
        <div class="row">
        <#if message??>
        ${message}
        </#if>
        <#if RequestParameters.message??>
        ${RequestParameters.message}
        </#if>

        </div>
    </div>

    <!--###################-->
    <!--grid rendering div-->
    <!--###################-->
    <table id="list2"></table>
    <div id=pager2></div>

<#--<div>


</div>-->
    <script>

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
        $(function () {


            $("#startDate, #endDate").datepicker();

            $("#startDate, #endDate").val(getToday());
        });
    </script>

    <div id="searhchDiv" style="font-size: 9pt;text-align: center">
        시작일: <input type="text" id="startDate">
        종료일: <input type="text" id="endDate">
        <select id="searchColumn" class="ui-state-default" style="height: 25px;">
            <option val="query_text">Query</option>
        <#--<option val="query_response">응답문장</option>-->
        </select>
        <input type="text" value="" id="searchWord" lass="ui-state-default">
        <input type="button" class="ui-state-default" value="search" id="btnSearch">
        <input type="button" class="ui-state-default" value="init" id="btnInit">
    </div>

    <div id="bottonDiv">
    <#--<span class="ui-icon ui-icon-trash"></span>
    &lt;#&ndash;ui-icon-pencil&ndash;&gt;
    <span class="ui-icon ui-icon-pencil" ></span>-->
        Theme:
        <select id="selectChangeTheme" style="font-size: 9pt;" class="ui-state-default">
            <option id="green2">green2</option>
            <option id="green">green</option>
            <option id="gray">gray</option>
            <option id="red">red</option>
            <option id="swanky">swanky</option>
            <option id="dotluv">dotluv</option>
            <option id="excitebike">excitebike</option>
            <option id="trontastic">trontastic</option>

        </select>
    </div>

<#--<input cvlass="btn btn-outline-info btn-sm arrow-button" type="button" value="logout" id="btnLogout">-->

    <!--###################-->
    <!--수정 다이얼로그 popup-->
    <!--###################-->
    <div id="modifyDialog" class="small" title="Dialog Title goes here...">
        <table>
            <colgroup>
                <col width="100px;">
                <col width="400px;">
            </colgroup>
            <tr>
                <td>
                    <label>질의문장&nbsp;&nbsp; </label>
                </td>
                <td>
                    <input type="text" width="500px" size="80" id="query_text" style="font-size: 9pt;">
                </td>

            </tr>
            <tr>
                <td>
                    <label>응답문장&nbsp;&nbsp; </label>
                </td>
                <td>
                    <input type="text" width="500px" size="80" id="query_response" style="font-size: 9pt;">

                </td>

            </tr>
            <tr>
                <td colspan="2">
                    <input type="button" id="btnPopupSubmit" value="저장" class="ui-state-default">
                </td>

            </tr>
        </table>


    </div>
    <div id="LoadingImage" style="display:none">

    </div>


    <!--#############-->
    <!--핕터 다이얼로그-->
    <!--#############-->
    <div id="filterDialog" class="small" title="필터">
        <table>
            <colgroup>
                <col width="100px;">
                <col width="400px;">
            </colgroup>
            <tr>
                <td>
                    <label>퀴리타입&nbsp;&nbsp; </label>
                </td>
                <td>
                    <select id="query_type">
                        <option value="">모두</option>
                    <#--<option value="informResponse">informResponse</option>-->

                    <#list quertType as quertTypeOne>
                        <option value="${quertTypeOne}">${quertTypeOne}</option>
                    </#list>


                    </select>
                </td>

            </tr>

            <tr>
                <td>
                    <label>변경라우팅&nbsp;&nbsp; </label>
                </td>
                <td>
                    <select class="grp-filter-choice" id="query_route">
                        <option value="P1">
                            P1
                        </option>
                        <option value="P2">
                            P2
                        </option>
                        <option value="AE">
                            AE
                        </option>
                        <option value="P5">
                            P5
                        </option>
                        <option value="모두">
                            모두
                        </option>
                        <option value="직접입력">
                            직접입력
                        </option>
                    </select>
                </td>

            </tr>

            <tr>
                <td>
                    <label>작업상태&nbsp;&nbsp; </label>
                </td>
                <td>
                    <select class="grp-filter-choice" id="query_work_status" name="query_work_status">
                        <option value="">
                            모두
                        </option>
                        <option value="0">
                            미작업
                        </option>
                        <option value="1">
                            작업완료
                        </option>
                        <option value="2">
                            2
                        </option>
                        <option value="3">
                            3
                        </option>
                    </select>

                </td>

            </tr>

            <tr>
                <td>
                    <label>연속질의&nbsp;&nbsp; </label>
                </td>
                <td>
                    <select class="grp-filter-choice" id="query_continuation" name="query_continuation">
                        <option value="">
                            모두
                        </option>
                        <option value="1">
                            true
                        </option>
                        <option value="0">
                            false
                        </option>

                    </select>

                </td>

            </tr>

            <tr>
                <td>
                    <label>pub_date&nbsp;&nbsp; </label>
                </td>
                <td>
                    <select class="grp-filter-choice" id="pub_date">
                        <option value="">언제나</option>
                        <option value="today">
                            오늘
                        </option>
                        <option value="week">
                            지난 7일
                        </option>
                        <option value="month">
                            이번 달
                        </option>
                        <option value="year">
                            이번 해
                        </option>
                    </select>

                </td>

            </tr>

        <#-- <tr>
             <td colspan="2">
                 <input type="button" id="btnFilterSubmit" value="검색" class="ui-state-default">
             </td>

         </tr>-->
        </table>


    </div>


</div>
</body>
</html>