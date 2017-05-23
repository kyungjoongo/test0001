<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hello grid!!!!!!!!</title>

<#include "/common/common.ftl">


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


        $(function () {

            $(".dropdown-menu li a").click(function () {

                $(".btn:first-child").text($(this).text());
                $(".btn:first-child").val($(this).text());

            });

            $("#changeTheme").on("click", function () {

                loadjscssfile("/jquery-ui-1.12.1.green/jquery-ui.theme.css", "css") ////dy

                loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy

            });


            $("#changeTheme2").on("click", function () {

                loadjscssfile("/jquery-ui-1.12.1.green2/jquery-ui.theme.css", "css") ////dy
                loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy
            });


            $("#changeTheme3").on("click", function () {

                loadjscssfile("/jquery-ui-1.12.1.custom/jquery-ui.theme.css", "css")
                loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy
            });

            $("#changeTheme4").on("click", function () {

                loadjscssfile("/jquery-ui-1.12.1.red/jquery-ui.theme.css", "css") ////dy
                loadjscssfile("/jquery.jqGrid-4.6.0/css/ui.jqgrid.css", "css") ////dy
            });


            $("#btnLogout").on("click", function () {

                location.href = "/webapp/logoutAction";
            });


            $("#list2").jqGrid({
                url: '/gridmain/getGridData',
                datatype: "json",
                colNames: ['id','query_text', 'query_route', 'query_type', 'query_continuation', 'query_work_status', 'worker', 'query_qc', 'pub_date'],
                colModel: [
                	{name: 'id', width: 50, sortable: true,   align: "right", sorttype: "number"}
                    ,{name: 'queryTextAndResponse', width: 500, sortable: true, sorttype: "text", formatter:queryFormatter}
                    ,{name: 'query_route', width: 80, sortable: true, sorttype: "text"}
                    ,{name: 'query_type', width: 80, sortable: true, sorttype: "text"}
                    ,{name: 'query_continuation', width: 80, sortable: true, sorttype: "text"}
                    ,{name: 'query_work_status', width: 80, sortable: true, sorttype: "text"}
                    ,{name: 'worker', width: 80, sortable: true, sorttype: "text"}
                    ,{name: 'query_qc', width: 80, sortable: true, sorttype: "text"}
                    ,{name: 'pub_date', width: 150, sortable: true, sorttype: "text"}
                    //{name: 'query_response', width: 500, sortable: true, sorttype: "text"},
                ],
                rowNum: 10,
                height: 'auto',
                rowList: [10, 20, 30],
                pager: '#pager2',
             //   sortname: 'id',
                viewrecords: true,
                sortorder: "desc",
                caption: "JSON 33333333333333",
                
                loadonce: false,
                jsonReader: {
                    repeatitems: false,
                    root: function(obj) {
                    	
                    	return obj.rows; 
                   	},
                    page: function(obj) {
                    	return obj.page;
                   	},
                    total: function(obj) { 
                    	return obj.total 
                   	},
                    records: function(obj) { 
                    	return 900; 
                   	}
                }
               
              
            });
            
        
       		$('#list2').jqGrid('filterToolbar', { searchOnEnter: true, enableClear: false });
            
            function queryFormatter (cellvalue, options, rowObject)
            {
               // do something here
               console.log("Sdflksdlfksdlkflsdkf");
               
               var splitedArray =  cellvalue.split(";");
               
               var new_format_value = '<font color=blue>'+splitedArray[0] + '</font>'+ "\n" +  splitedArray[1]; 
               
               return new_format_value;
            }
            

          /*   $('#list2').jqGrid('setGridParam', {sortorder: 'desc'});
            $('#list2').jqGrid('sortGrid', 'id');


            $("#list2").jqGrid('navGrid', '#pager2',
                    {edit: false, add: false, del: false, search: true}, {}, {}, {},
                    {

                        multipleSearch: false, multipleGroup: false, showQuery: false,
                        sopt: ['cn'],
                        defaultSearch: 'cn',
                        caption: "Search",
                        //closeAfterSearch: true,
                        //closeOnEscape: true,
                        modal: false,
                        left: 400,
                        top: 400,
                        searchOnEnter: true


                    }
            );
 */

        });


    </script>

</head>
<body>
<div class="">
    <table id="list2"></table>
    <div id=pager2></div>


    <input class="btn btn-outline-info btn-sm" type="button" value="green2" id="changeTheme2">
    <input class="btn btn-outline-info btn-sm" type="button" value="green" id="changeTheme">
    <input class="btn btn-outline-info btn-sm" type="button" value="gray" id="changeTheme3">
    <input class="btn btn-outline-info btn-sm" type="button" value="red" id="changeTheme4">


    <input class="btn btn-outline-info btn-sm arrow-button" type="button" value="logout" id="btnLogout">


    <!-- <select id="selectLang">
        <option id="ko">ko</option>
        <option id="en">en</option>


    </select> -->


</div>
</body>
</html>