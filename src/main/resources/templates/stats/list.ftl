<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>NaverDialogAppStats</title>

<#include "/common/common.ftl">

    <script>
        $(window).load(function () {

            $("#btnColumnSettingApply").trigger("click");


        })

        var dialogDomains = [];
        var selectedColumnNameList = [];


        var colName = ['id', '쿼리', '변경쿼리', '대화도메인', '기존라우팅', '변경라우팅', '쿼리타입', '연속질의', '작업상태', '일괄블럭여부', 'QM라우팅', 'QM키', '작업자', '총QC', '기간별QC', '시간'];

        var columnNameDictionary = [
            {key: 'id', kor_value: "id"}
            , {key: 'query_text_and_response', kor_value: "쿼리"}
            , {key: 'query_replace', kor_value: "변경쿼리"}
            , {key: 'dialogDomain', kor_value: "대화도메인"}
            , {key: 'query_route', kor_value: "기존라우팅"}
            , {key: 'output_route', kor_value: "변경라우팅"}
            , {key: 'query_type', kor_value: "쿼리타입"}
            , {key: 'query_continuation', kor_value: "연속질의"}
            , {key: 'query_work_status', kor_value: "작업상태"}
            , {key: 'query_blocked', kor_value: "일괄블럭여부"}
            , {key: 'qm_route', kor_value: "QM라우팅"}
            , {key: 'qm_key', kor_value: "QM키"}
            , {key: 'worker', kor_value: "작업자"}
            , {key: 'query_qc', kor_value: "총QC"}
            , {key: 'qc_by_date', kor_value: "기간별QC"}
            , {key: 'pub_date', kor_value: "시간"}
        ];

        var colModels = [
                    {name: 'id', width: 50, sortable: true, sorttype: "number",

                        formatter: function queryFormatter(cellvalue, options, rowObject) {

                            return "<a class=query_id href='#' style='color: #79b7e7' val='"+ cellvalue+  "'>" + cellvalue + " </a><br/>";

                        }

                    },
                    {
                        name: 'query_text_and_response',
                        width: 320,
                        sortable: true,
                        sorttype: "text",
                        formatter: queryFormatter
                    }
                    , {
                        name: 'query_replace',
                        width: 130,
                        sortable: true,
                        sorttype: "text"

                    },
                    {
                        name: 'dialogDomain',
                        width: 130,
                        sortable: true,
                        sorttype: "text"
                    },
                    {
                        name: 'query_route',
                        width: 80,
                        sortable: true,
                        sorttype: "text",
                        align: 'center',
                        formatter: queryRouteFormatter
                    },
                    {
                        name: 'output_route',
                        width: 80,
                        sortable: true,
                        sorttype: "text",
                        align: 'center'
                        ,
                        formatter: queryRouteFormatter2
                    },
                    {name: 'query_type', width: 100, sortable: true, sorttype: "text", align: 'center'},
                    {
                        name: 'query_continuation',
                        width: 70,
                        sortable: true,
                        sorttype: "text",
                        align: 'center',
                        formatter: query_continuation_formatter
                    },
                    {
                        name: 'query_work_status',
                        width: 100,
                        sortable: true,
                        sorttype: "text",
                        align: 'center',
                        formatter: query_work_status_formatter
                    },
                    {
                        name: 'query_blocked' +
                        '', width: 100, sortable: true, sorttype: "text", align: 'center', formatter: blockYnFormatter
                    },
                    {
                        name: 'qm_route',
                        width: 100,
                        sortable: true,
                        sorttype: "text",
                        align: 'center',
                        formatter: queryRouteFormatter2
                    },
                    {name: 'qm_key', width: 170, sortable: true, sorttype: "text", align: 'center'},
                    {
                        name: 'worker', width: 100, sortable: true, sorttype: "text", align: 'center',

                        formatter: function queryFormatter(cellvalue, options, rowObject) {

                            return "<a class=worker href='#' style='color: #79b7e7' val='"+ cellvalue+  "'>" + cellvalue + " </a><br/>";

                        }



                    },
                    {
                        name: 'query_qc', width: 100, sortable: true, sorttype: "number", align: 'center'
                    }
                    ,
                    {
                        name: 'qc_by_date', width: 100, sortable: true, sorttype: "number", align: 'center'
                    }
                    ,
                    {
                        name: 'pub_date', width: 140, sortable: true, sorttype: "text", align: 'center'
                    }

                ]
        ;


        $(function () {

            $("#columnSettingDialog").dialog({
                autoOpen: false,
                title: '컬럼셋팅',
                modal: false,
                resizable: true,
                width: 1300,
                maxHeight: 150,

                closeText: 'fechar',
                draggable: true


            });


            $("#filterDialog").dialog({
                autoOpen: false,
                title: '필터',
                modal: false,
                resizable: true,
                width: 900,
                height: 550,
                maxHeight: 400,
                closeText: 'fechar',
                draggable: true

            });


            //대화도메인 멀티셀렉트 bind
            $('#dialogDomain').multiSelect({

                selectableHeader: "<input type='text' class='search-input' style='width: 165px;font-size: 11pt; autocomplete='off' placeholder='검색어'>",
                selectionHeader: "<input type='text' class='search-input' style='width: 165px;font-size: 11pt; autocomplete='off' placeholder='검색어'>",
                afterInit: function (ms) {
                    var that = this,
                            $selectableSearch = that.$selectableUl.prev(),
                            $selectionSearch = that.$selectionUl.prev(),
                            selectableSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selectable:not(.ms-selected)',
                            selectionSearchString = '#' + that.$container.attr('id') + ' .ms-elem-selection.ms-selected';

                    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
                            .on('keydown', function (e) {
                                if (e.which === 40) {
                                    that.$selectableUl.focus();
                                    return false;
                                }
                            });

                    that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
                            .on('keydown', function (e) {
                                if (e.which == 40) {
                                    that.$selectionUl.focus();
                                    return false;
                                }
                            });
                },

                afterSelect: function (values) {
                    //alert("Select value: "+values);

                    if (values.length == 1)
                        dialogDomains.push(values[0]);
                    console.log("selectedDialogDomains-->" + dialogDomains);
                },
                afterDeselect: function (values) {

                    if (values.length == 1) {
                        var index = dialogDomains.indexOf(values[0]);
                        if (index != -1) {
                            dialogDomains.splice(index, 1);

                        }


                        console.log("selectedDialogDomains-->" + dialogDomains);
                    }
                }

            });

            $("#startDate, #endDate").datepicker();
            $("#startDate").val(getToday());
            $("#endDate").val(getToday());


            $('#dialogDomain').multiSelect('deselect_all');


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
                            url: '${rc.contextPath}/nda/importExcel',
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

                var message = 'Export 하시겠습니까?';
                var rowlength = $("#list2").jqGrid('getGridParam', 'records');

                if (rowlength > 50000) {
                    message = "5만건 이상은 꽤 오래 걸립니다. 그래도 Export 하시겠습니까?";
                }

                $('<div></div>').appendTo('body')
                        .html('<div><h6>' + message + '</h6></div>')
                        .dialog({
                            modal: true, title: 'Export', zIndex: 10000, autoOpen: true,
                            width: 'auto', resizable: false
                            , position: {
                                my: 'top',
                                at: 'top'
                            },
                            buttons: {
                                네: function () {
                                    $("#loadingImage").show();

                                    var bCheckQueryCountByDate = 0;
                                    if ($("input:checkbox[id='bCheckQueryCountByDate']").is(":checked")) {
                                        //alert("체크o");
                                        bCheckQueryCountByDate = 1;
                                    } else {
                                        //alert('체크x');
                                        bCheckQueryCountByDate = 0;
                                    }

                                    var params = "?sortColumn=" + $("#sortColumn").val()
                                            + "&sortOrder=" + $("#sortOrder").val()
                                            + "&startDate=" + $("#startDate").val()
                                            + "&endDate=" + $("#endDate").val()
                                            + "&searchWord=" + $("#searchWord").val().trim()
                                            + "&query_work_status=" + $("#query_work_status").val()
                                            + "&bCheckQueryCountByDate=" + bCheckQueryCountByDate
                                            + "&query_continuation=" + $("#query_continuation").val()
                                            + "&dialogDomains=" + dialogDomains.toString()
                                            + "&searchType=" + $("#searchType").val()
                                            + "&query_type=" + $("#query_type").val()
                                            + "&searchColumn=" + $('#searchColumn option:selected').attr('val').trim()
                                            + "&boolQueryReplace=" + $("#query_replace").val()
                                            + "&startNo=0"
                                            + "&rows=4000"
                                    ;

                                    $.fileDownload("${rc.contextPath}/stats/exportToExcel" + params, {
                                        successCallback: function (url) {
                                            $("#loadingImage").hide();
                                            // alert("Export 성공");
                                        },
                                        failCallback: function (responseHtml, url) {
                                            alert("Export fail");
                                            $("#loadingImage").hide();
                                        }
                                    });
                                    $(this).dialog("close");
                                },
                                아니오: function () {
                                    //doFunctionForNo();
                                    $(this).dialog("close");
                                }
                            },
                            close: function (event, ui) {
                                $(this).remove();
                            }
                        });

            });


            $("#btnCSVExport").on("click", function () {
                var message = 'CVS Export 하시겠습니까?';
                var rowlength = $("#list2").jqGrid('getGridParam', 'records');

                if (rowlength > 50000) {
                    message = "5만건 이상은 꽤 오래 걸립니다. 그래도 Export 하시겠습니까?";
                }

                $('<div></div>').appendTo('body')
                        .html('<div><h6>' + message + '</h6></div>')
                        .dialog({
                            modal: true, title: 'CVS Export', zIndex: 10000, autoOpen: true,
                            width: 'auto'
                            , resizable: false
                            , position: {
                                my: 'top',
                                at: 'top'
                            },
                            buttons: {
                                네: function () {

                                    var bCheckQueryCountByDate = 0;
                                    if ($("input:checkbox[id='bCheckQueryCountByDate']").is(":checked")) {
                                        //alert("체크o");
                                        bCheckQueryCountByDate = 1;
                                    } else {
                                        //alert('체크x');
                                        bCheckQueryCountByDate = 0;
                                    }
                                    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    var params = "?sortColumn=" + $("#sortColumn").val()
                                            + "&sortOrder=" + $("#sortOrder").val()
                                            + "&startDate=" + $("#startDate").val()
                                            + "&endDate=" + $("#endDate").val()
                                            + "&searchWord=" + $("#searchWord").val().trim()
                                            + "&query_work_status=" + $("#query_work_status").val()
                                            + "&bCheckQueryCountByDate=" + bCheckQueryCountByDate
                                            + "&query_continuation=" + $("#query_continuation").val()
                                            + "&dialogDomains=" + dialogDomains.toString()
                                            + "&searchType=" + $("#searchType").val()
                                            + "&query_type=" + $("#query_type").val()
                                            + "&searchColumn=" + $('#searchColumn option:selected').attr('val').trim()
                                            + "&boolQueryReplace=" + $("#query_replace").val()
                                            + "&startNo=0"
                                            + "&rows=4000"
                                    ;

                                    $("#loadingImage").show();
                                    $.fileDownload("${rc.contextPath}/stats/exportToCsv" + params, {
                                        successCallback: function (url) {
                                            $("#loadingImage").hide();
                                            //alert("Export 성공");
                                        },
                                        failCallback: function (responseHtml, url) {
                                            alert("Export fail");
                                        }
                                    });
                                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////


                                    $(this).dialog("close");
                                },
                                아니오: function () {
                                    //doFunctionForNo();
                                    $(this).dialog("close");
                                }
                            },
                            close: function (event, ui) {
                                $(this).remove();
                            }
                        });

            });


            $("#selectChangeTheme").on("change", function () {
                var selectedId = $("#selectChangeTheme option:selected").attr("id");
                loadTheme(selectedId);
            });


            $("#btnLogout").on("click", function () {
                location.href = "${rc.contextPath}/webapp/logoutAction";
            });


            //검색어 search event
            $("#btnSearch").on("click", function () {

                var startDate = $("#startDate").val();
                var endDate = $("#endDate").val();

                startDate = startDate.replace(/-/gi, "");
                endDate = endDate.replace(/-/gi, "");

                if (parseInt(startDate) > parseInt(endDate)) {
                    alert("시작일가 종료일보다 클 수 없습니다.");
                    return false;
                }

                var searchWord = $("#searchWord").val();

                var searchColumn = $('#searchColumn option:selected').attr('val');


                /*alert($("#searchType").val());*/

                $("#loadingImage").show();
                $('#list2').setGridParam({
                    page: 1,
                    datatype: "json",
                    url: '${rc.contextPath}/stats/getList',
                    postData: {
                        searchColumn: searchColumn
                        , searchWord: searchWord
                        , searchType: $("#searchType").val()
                        , startDate: $("#startDate").val()
                        , endDate: $("#endDate").val()
                        , sortOrder: $("#sortOrder").val()
                    }, ajaxGridOptions: {
                        complete: function () {

                            $("#loadingImage").hide();
                        }
                    }
                }).trigger('reloadGrid');

            });


            $("#btnInit").on("click", function () {
                location.href = '${rc.contextPath}/stats/list';
            });


            //선택삭제 버튼 이벤트.
            $("#btnDelete").on("click", function () {

                if (confirm("삭제하시겠습니까?")) {
                    var selRowIds = $("#list2").jqGrid('getGridParam', 'selarrrow');

                    $("#loadingImage").show();
                    $.ajax({
                        url: '/stats/delete',
                        type: 'post',
                        //async: false,
                        data: {rowIds: selRowIds.toString()},
                        success: function (data) {

                            $("#loadingImage").hide();
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


            $("#btnApplyFilter").on("click", function () {
                // /stat/getList
                $('#filterDialog').dialog('close');
                $("#loadingImage").show();


                $('#list2').setGridParam({
                    page: 1,
                    postData: {
                        query_type: $("#query_type").val(),
                        query_route: $("#query_route").val(),
                        output_route: $("#output_route").val(),
                        startDate: $("#startDate").val(),
                        endDate: $("#endDate").val(),
                        rows: $("#rows").val(),
                        query_work_status: $("#query_work_status").val(),
                        query_continuation: $("#query_continuation").val(),
                        dialogDomains: dialogDomains.toString(),
                        pub_date: $("#pub_date").val(),
                        boolQueryReplace: $("#query_replace").val()
                    },
                    ajaxGridOptions: {
                        complete: function () {

                            $("#loadingImage").hide();
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


            //btnColumnSetting
            $("#btnColumnSetting").on("click", function () {
                $("#columnSettingDialog").dialog("open");
            });

            //#####################
            //컬럼셋팅  적용 이벤트..
            //#####################
            $("#btnColumnSettingApply").on("click", function () {

                selectedColumnNameList = [];

                $('.columnSetting').each(function () {

                    if (this.checked) {
                        /*alert($(this).val());*/

                        selectedColumnNameList.push($(this).val());
                    }

                });


                //선택된 컬럼 모델추출
                var selectedColumnModelList = $.grep(colModels, function (element, index) {

                    var result = 0;
                    $.each(selectedColumnNameList, function (index, selectedColumnNameListOne) {

                        if (selectedColumnNameListOne == element.name) {
                            result++;
                        }

                    });

                    if (result > 0) {
                        return true;
                    } else {
                        return false;
                    }

                });

                //선택된 컬럼vaule,네임 추출..
                var selectedKoreanColumnNameList = $.grep(columnNameDictionary, function (element, index) {

                    var result = 0;
                    $.each(selectedColumnNameList, function (index, selectedColumnNameListOne) {

                        if (selectedColumnNameListOne == element.key) {
                            result++;
                        }

                    });

                    if (result > 0) {
                        return true;
                    } else {
                        return false;
                    }

                });


                //선택된 네임만을 다시 추출.
                var newSelectedKoreanColumnNameList = [];
                $.each(selectedKoreanColumnNameList, function (index, selectedKoreanColumnNameListOne) {
                    newSelectedKoreanColumnNameList.push(selectedKoreanColumnNameListOne.kor_value);
                });


                /*var gview_list2_div = document.getElementById('gview_list2'); //get #myDiv
                //alert(gview_list2_div.clientWidth);
                $("#loadingImage").css('width', gview_list2_div.clientWidth)*/


                //그리드 삭제후 다시 로딩...
                $("#list2").jqGrid('GridUnload');
                loadGrid(newSelectedKoreanColumnNameList, selectedColumnModelList);
                $("#columnSettingDialog").dialog("close");


            });

            $("#btnColumnAllCheck").on("click", function () {
                $('.columnSetting').prop('checked', true);
            });

            $("#btnColumnAllUncheck").on("click", function () {
                $('.columnSetting').removeAttr('checked');
            });



            /*
            ###################################
            다이얼로그 allcheck allUncheck event
            ####################################
            */
            $("#btnAllCheckDialogDomain").on("click", function () {
                $('#dialogDomain').multiSelect('select_all');

                dialogDomains=[];
                $('.ms-selection').find("li").each(function (index, elem) {

                    /*alert(elem.innerText);*/
                    dialogDomains.push(elem.innerText);
                    console.log(dialogDomains);
                });

            });

            $("#btnAllUncheckDialogDomain").on("click", function () {
                $('#dialogDomain').multiSelect('deselect_all');
                //전체 해제
                dialogDomains = [];
                console.log(dialogDomains);
            });

        });//onReady End



        //#################################
        //#################################
        //# 그리드 로딩
        //#################################
        //#################################
        function loadGrid(listOfColumnNames, listofColumnModels) {
            var bCheckQueryCountByDate = 0;
            if ($("input:checkbox[id='bCheckQueryCountByDate']").is(":checked")) {
                //alert("체크o");
                bCheckQueryCountByDate = 1;
            } else {
                //alert('체크x');
                bCheckQueryCountByDate = 0;
            }


            var gridTemplate = "<table id='list2'></table><div id='pager2'></div>";

            $('#grid_wrapper').html(gridTemplate);

            $("#loadingImage").show();
            $("#list2").jqGrid({
                url: '${rc.contextPath}/stats/getList',
                datatype: "json",
                postData: {
                    startDate: $("#startDate").val(),
                    endDate: $("#endDate").val(),
                    bCheckQueryCountByDate: bCheckQueryCountByDate
                },
                loadError: function (jqXHR, textStatus, errorThrown) {
                    $("#loadingImage").hide();
                    alert('HTTP status code: ' + jqXHR.status + '\n' +
                            'textStatus: ' + textStatus + '\n' +
                            'errorThrown: ' + errorThrown);
                    alert('HTTP message body (jqXHR.responseText): ' + '\n' + jqXHR.responseText);

                },
                /*datatype: 'jsonstring',
                datastr: result,*/
                colNames: listOfColumnNames,
                colModel: listofColumnModels,
                rowNum: 17,
                height: 'auto',
                rowList: [10, 15, 17, 20, 30, 50, 100, 200, 300, 1000],
                pager: '#pager2',
                sortname: 'id',
                viewrecords: true,
                sortorder: "asc",
                caption: "CLOVA STATS",
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
                }/*, onCellSelect: function (rowId, iCol, colContent, event) {

/!*                    location.href = "${rc.contextPath}/stats/historyList?editor=" + colContent;*!/

                }*/
                , onSortCol: function (sortColumn, iCol, sortOrder) {//소트컬럼클릭시 event(/stats/getList)

                    if (sortColumn == 'query_text_and_response') {
                        sortColumn = 'query_text';
                    }

                    $("#sortColumn").val(sortColumn);
                    $("#sortOrder").val(sortOrder);


                    $("#loadingImage").show();
                    $('#list2').setGridParam({
                        page: 1,
                        datatype: "json",
                        url: '${rc.contextPath}/stats/getList',
                        postData: {
                            sortColumn: sortColumn,
                            sortOrder: sortOrder,
                            startDate: $("#startDate").val(),
                            endDate: $("#endDate").val()
                        }, ajaxGridOptions: {
                            complete: function () {

                                $("#loadingImage").hide();
                            }
                        }
                    }).trigger('reloadGrid');


                }, onPaging: function () {
                    //$("#loadingImage").show();
                }, loadComplete: function () {
                    $("#loadingImage").hide();
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


                    $(".worker").on("click", function () {
                        var worker = $(this).attr("val");
                        location.href = "${rc.contextPath}/stats/historyList?editor=" + worker + "&query_id=";
                    });

                    //query_text_and_response
                    $(".query_text_and_response").on("click", function () {
                        var query_id = $(this).attr("query_id");

                        /*alert(query_id);*/
                        location.href = "${rc.contextPath}/stats/detail?id=" + query_id ;
                    });

                    $(".query_id").on("click", function () {
                        var query_id = $(this).attr("val");
                        location.href = "${rc.contextPath}/stats/historyList?query_id=" + query_id + "&editor=";
                    });


                    var rowlength = $("#list2").jqGrid('getGridParam', 'records');
                    /*alert(rowlength);*/
                    $("#totalRecords").text(rowlength);


                }
            });


        }//loadGrid End


    </script>

</head>
<body>
<form id="form1" method="post">
    <input type="hidden" id="rowId" value=""/>
    <input type="hidden" id="currentPage" value=""/>
    <input type="hidden" id="sortColumn" value="id"/>
    <input type="hidden" id="sortOrder" value="asc"/>
    <input type="hidden" id="rows" value="10"/>
    <input type="hidden" id="tableName" value="query_manager_userquery"/>


    <div class="">
        <!--################-->
        <!--상단버튼div-->
        <!--################-->
        <div class="container-fluid">
            <div class="row" style="width: 1500px">
                <form id="form1" method="POST" action="${rc.contextPath}/stats/upload"
                      enctype="multipart/form-data">
                    <table border="0" style="width: 1610px;">
                        <tr>
                            <td style="width: 1300px;">

                                <input type="file" id="file" style="display: none"/>
                            <#--<label for="file" class="ui-state-default">&nbsp;Import&nbsp;</label>-->
                                <label class="ui-state-default" id="btnExport">&nbsp;Export&nbsp;</label>

                                <label class="ui-state-default" id="btnCSVExport">&nbsp;CSV&nbsp;</label>
                                <label class="ui-state-default" id="btnFilter">&nbsp;Filter&nbsp;</label>

                                <label class="ui-state-default" id="btnColumnSetting">&nbsp;ColumnSetting&nbsp;</label>
                            </td>

                            <td style="text-align: right;font-weight: bolder">
                                총 데이터수 : <label id="totalRecords"></label>

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
        <div id="grid_wrapper">


        </div>
    <#--<table id="list2"></table>
    <div id=pager2></div>-->

        <!--###################-->
        <!--End of grid rendering div-->
        <!--###################-->

        <div id="searhchDiv" style="font-size: 9pt;text-align: center">
            시작일: <input type="text" id="startDate">
            종료일: <input type="text" id="endDate">
            <select id="searchColumn" class="ui-state-default" style="height: 25px;">
                <option val="query_text">Query</option>
                <option val="qm_key">QM키</option>
            </select>

            <select id="searchType" class="ui-state-default" style="height: 25px;">
                <option value="contains">포함일치</option>
                <option value="prefix">전방일치</option>
                <option value="postfix">후방일치</option>
                <option value="precise">정확히일치</option>

            </select>
            <input type="text" value="" id="searchWord" lass="ui-state-default">
            <input type="button" class="ui-state-default" value="Search" id="btnSearch">
            <input type="button" class="ui-state-default" value="Init" id="btnInit">
        </div>
        <!--#############-->
        <!--핕터 다이얼로그-->
        <!--#############-->
        <div id="filterDialog" class="small" title="필터">
            <table style="font-size: 11pt;">
                <colgroup>
                    <col width="100px;">
                    <col width="400px;">
                </colgroup>

                <tr>
                    <td>
                        <label>변경쿼리&nbsp;&nbsp; </label>
                    </td>
                    <td>
                        <select id="query_replace" name="query_replace"
                                style="font-size: 11pt;">
                            <option value="false">모두</option>
                            <option value="true">true</option>

                        </select>

                    </td>

                </tr>

                <tr>
                    <td>
                        <label>대화도메인&nbsp;&nbsp; </label>
                    </td>
                    <td>
                        <select id="dialogDomain" name="dialogDomain"
                                style="font-size: 11pt;">
                        <#list dialogDomain as dialogDomainOne>
                            <option value="${dialogDomainOne}">${dialogDomainOne}</option>
                        </#list>

                        </select>

                    </td>

                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <input class="ui-state-default" type="button" value="전체선택" id="btnAllCheckDialogDomain"
                               style="font-size: 9pt;">
                        <input class="ui-state-default" type="button" value="전체해제" id="btnAllUncheckDialogDomain"
                               style="font-size: 9pt;">

                    </td>

                </tr>


                <tr>
                    <td>
                        <label>퀴리타입&nbsp;&nbsp; </label>
                    </td>
                    <td>
                        <select id="query_type" name="query_type" style="font-size: 11pt;">
                            <option value="">모두</option>


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
                        <select class="grp-filter-choice" id="output_route" style="font-size: 11pt;">
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
                        <select class="grp-filter-choice" id="query_work_status" name="query_work_status"
                                style="font-size: 11pt;">

                            <option value="">
                                모두
                            </option>
                            <option value="0">
                                작업전
                            </option>
                            <option value="1">
                                작업완료
                            </option>
                            <option value="2">
                                작업중
                            </option>

                        </select>

                    </td>

                </tr>

                <tr>
                    <td>
                        <label>연속질의&nbsp;&nbsp; </label>
                    </td>
                    <td>
                        <select class="grp-filter-choice" id="query_continuation" name="query_continuation"
                                style="font-size: 11pt;">
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
                        <label>시간&nbsp;&nbsp; </label>
                    </td>
                    <td>
                        <select class="grp-filter-choice" id="pub_date" style="font-size: 11pt;">
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
                <tr>
                    <Td>
                        <input class="ui-state-default" type="button" value="필터적용" id="btnApplyFilter"
                               style="font-size: 12pt;">

                    </Td>


                </tr>

            </table>


        </div>

        <div id="loadingImage" style="display:none">
        <#--<img src="${rc.contextPath}/image/loading3.gif" >-->

        </div>
        <!--#############-->
        <!--컬럼setting dialog-->
        <!--#############-->
        <div id="columnSettingDialog" class="small" title="컬럼">
            <table style="font-size: 11pt;">

                <tr>

                    <td style="font-size: 11pt;">


                        <label> <input class="columnSetting" checked type="checkbox" value="id">&nbsp;id&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox" value="query_text_and_response">쿼리&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="query_replace">변경쿼리&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="dialogDomain">대화도메인&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="query_route_by_date">기존라우팅&nbsp;</label>
                        <label> <input class="columnSetting" checked type="checkbox"
                                       value="output_route">변경라우팅&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="query_type">쿼리타입&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="query_continuation">연속질의&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="query_work_status_by_date">작업상태&nbsp;</label>

                        <label><input class="columnSetting" checked type="checkbox"
                                      value="query_blocked">일괄블럭여부&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="qm_route">QM라우팅&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox" value="qm_key">QM키&nbsp;</label>

                        <label><input class="columnSetting" checked type="checkbox" value="worker">작업자&nbsp;</label>

                        <label><input class="columnSetting" checked type="checkbox"
                                      value="query_qc">총QC&nbsp;</label>
                        <label><input class="columnSetting" type="checkbox"
                                      value="qc_by_date" id="bCheckQueryCountByDate">기간별QC&nbsp;</label>
                        <label><input class="columnSetting" checked type="checkbox"
                                      value="pub_date">시간&nbsp;</label>


                    </td>

                </tr>
                <tr>
                    <td>&nbsp;</td>

                </tr>

                <tr>
                    <Td>
                        <table>
                            <tr>
                                <td>

                                    <input class="ui-state-default" type="button" value="전체선택" id="btnColumnAllCheck"
                                           style="font-size: 11pt;">
                                    <input class="ui-state-default" type="button" value="전체헤제" id="btnColumnAllUncheck"
                                           style="font-size: 11pt;">
                                    <input class="ui-state-default" type="button" value="적용" id="btnColumnSettingApply"
                                           style="font-size: 11pt;">

                                </td>

                            </tr>

                        </table>


                    </Td>

                </tr>

            </table>


        </div>


    </div>
</form>
<footer>

    <div id="bottonDiv">
        <a style="font-size: 10pt"> Theme:</a>
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
    <hr class="spacing-lg">
    <div>
        <p class="text-center" style="font-size: 9pt;">Copyright &copy; Naver All Rights Reserved.</p>

    </div>


<#--
${rc.contextPath}
${rc.contextPath}
-->

</footer>
</body>
</html>