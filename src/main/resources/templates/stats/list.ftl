<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>_STATSSTATSSTATS_STATSSTATSSTATSSTATSSTATS</title>

<#include "/common/common.ftl">
    <style>

        /*그리드 폰트사이즈*/
        .ui-widget-content td {font-size:8pt;}

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
        #LoadingImage {
            position: fixed;
            top: 0px;
            right: 150px;
            width: 100%;
            height: 100%;
            background-color: #666;
            background-image: url('/image/loading7.gif');
            background-repeat: no-repeat;
            background-position: center;
            z-index: 10000000;
            opacity: 0.4;
        }

        div.ui-datepicker{
            font-size:16px;
        }



    </style>

    <script type="text/javascript" src="/js/Stats.js"></script>
    <#--<script>
    </script>-->

</head>
<body>
<form id="form1" method="post">
    <input type="hidden" id="rowId" value=""/>
    <input type="hidden" id="currentPage" value=""/>
    <input type="hidden" id="sortColumn" value="id"/>
    <input type="hidden" id="sortOrder" value="asc"/>
    <input type="hidden" id="rows" value="10"/>


    <div class="">
        <!--################-->
        <!--상단버튼div-->
        <!--################-->
        <div class="container-fluid">
            <div class="row" style="width: 1500px">
                <form id="form1" method="POST" action="/tinkerbell/upload" enctype="multipart/form-data">
                    <table border="0" style="width: 1610px;">
                        <tr>
                            <td style="width: 1300px;">

                                <input type="file" id="file" style="display: none"/>
                            <#--<label for="file" class="ui-state-default">&nbsp;Import&nbsp;</label>-->
                                <label class="ui-state-default" id="btnExport">&nbsp;Export&nbsp;</label>

                                <label class="ui-state-default" id="btnCSVExport">&nbsp;CSV&nbsp;</label>
                                <label class="ui-state-default" id="btnFilter">&nbsp;Filter&nbsp;</label>
                            </td>

                            <td style="text-align: right">


                            </td>


                        </tr>


                    </table>


                </form>
            </div>

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

        <!--###################-->
        <!--End of grid rendering div-->
        <!--###################-->

        <div id="searhchDiv" style="font-size: 9pt;text-align: center">
            시작일: <input type="text" id="startDate">
            종료일: <input type="text" id="endDate">
            <select id="searchColumn" class="ui-state-default" style="height: 25px;">
                <option val="query_text">Query</option>
            <#--<option val="query_response">응답문장</option>-->
            </select>
            <input type="text" value="" id="searchWord" lass="ui-state-default">
            <input type="button" class="ui-state-default" value="Search" id="btnSearch">
            <input type="button" class="ui-state-default" value="Init" id="btnInit">
        </div>

        <div id="bottonDiv">
            Theme:
            <select id="selectChangeTheme" style="font-size: 9pt;" class="ui-state-default">
                <option id="green2">green2</option>
                <option id="papergrind">papergrind</option>
                <option id="green">green</option>
                <option id="gray">gray</option>
                <option id="red">red</option>
                <option id="swanky">swanky</option>
                <option id="dotluv">dotluv</option>
                <option id="excitebike">excitebike</option>
                <option id="trontastic">trontastic</option>
                <option id="sunny">sunny</option>
                <option id="redmonde">redmonde</option>
                <option id="flick">flick</option>



            </select>
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
                        <select id="query_type" name="query_type">
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
                        <label>기존라우팅&nbsp;&nbsp; </label>
                    </td>
                    <td>
                        <select class="grp-filter-choice" id="query_route">
                            <option value="" selected>
                                모두
                            </option>
                            <option value="0">
                                P1
                            </option>
                            <option value="1">
                                P2
                            </option>
                            <option value="2">
                                AE
                            </option>
                            <option value="3">
                                P5
                            </option>

                            <option value="직접입력">
                                직접입력
                            </option>
                        </select>
                    </td>

                </tr>

                <tr>
                    <td>
                        <label>변경라우팅&nbsp;&nbsp; </label>
                    </td>
                    <td>
                        <select class="grp-filter-choice" id="output_route">
                            <option value="" selected>
                                모두
                            </option>
                            <option value="0">
                                P1
                            </option>
                            <option value="1">
                                P2
                            </option>
                            <option value="2">
                                AE
                            </option>
                            <option value="3">
                                P5
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
                            <option value="" selected>
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

            </table>


        </div>


    </div>
</form>
</body>
</html>