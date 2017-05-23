
<!--commontemplte-->
<#--
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/jquery.jqplot.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.json2.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.pieRenderer.js"></script>

<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.barRenderer.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.pieRenderer.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.categoryAxisRenderer.js"></script>
<script type="text/javascript" src="/jquery.jqplot.1.0.9/plugins/jqplot.pointLabels.js"></script>


<link rel="stylesheet" type="text/css" href="/jquery.jqplot.1.0.9/jquery.jqplot.css"/>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>-->


<link href="/jquery-ui-1.12.1.green2/jquery-ui.theme.css" rel="stylesheet"/>
<link href="/jquery-ui-1.12.1.green2/jquery-ui.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
      integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<!-- jqGrid-4.6.0 -->
<link href="/jquery.jqGrid-4.6.0/css/ui.jqgrid.css" rel="stylesheet"/>
<script type="text/javascript" src="/jquery.jqGrid-4.6.0/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/jquery.jqGrid-4.6.0/js/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="/jquery.jqGrid-4.6.0/js/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="/jquery-ui-1.12.1.green2/jquery-ui.js"></script>

<script type="text/javascript" src="/jquery.fileDownload.js"></script>

<!-- bootstrap -->
<#--<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"
        integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js"
        integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn"
        crossorigin="anonymous"></script>-->



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

</script>

