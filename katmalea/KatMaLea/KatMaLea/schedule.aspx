<%@ Page Title="" Language="C#" MasterPageFile="~/Master_default.Master" AutoEventWireup="true" CodeBehind="schedule.aspx.cs" Inherits="KatMaLea.schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="container" id="scheduling-container">
      <div class="row">
        <div class="col-lg-12">
          <div role="tabpanel">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist" id="schedtab">
              <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">VIEW TASKS</a></li>
              <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">ADD TASK</a></li>
              <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">EDIT TASK</a></li>
              <li role="presentation"><a href="#settings" aria-controls="settings" role="tab" data-toggle="tab">DELETE TASK</a></li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
              <div role="tabpanel" class="tab-pane active" id="home">
                <div id="panelviewtask">
                  <div class="panel panel-default">
                    <div class="panel-heading">SCHEDULED TASKS</div>
                    <div class="panel-body">
                      <form id="form-dates">
                        <div class="form-group">
                          <b>DATE:</b>
                          <input type="date" id="taskdate" name="arrdate" size="20" />
                          <button id="btn-checkavail" type="button" class="btn btn-default">VIEW TASKS</button>
                        </div>
                      </form>
                      <table class="table table-striped">
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                      </table>
                      <button type="button" class="btn btn-primary">SAVE</button>
                    </div>
                  </div>
                </div>
              </div>
              <div role="tabpanel" class="tab-pane" id="profile">
                <!-- start here -->
                <div class="panel panel-default">
                  <div class="panel-heading">ADD NEW TASK</div>
                  <div class="panel-body">
                    
                    <form id="form1">
                        <div class="form-group"> 
                          <b>TASK NAME:</b>
                          <input type="text" id="taskname" size="50" />      
                          <b>DATE:</b>
                          <input type="date" id="addtaskdate" name="arrdate" size="20" />
                        </div>                      
                    </form>
                    <button id="btn-savetask" type="button" class="btn btn-primary">SAVE TASK</button>
                  </div>
                </div>
              </div>
              <div role="tabpanel" class="tab-pane" id="messages">
                <!-- start here -->
                <div class="panel panel-default">
                  <div class="panel-heading">ADD NEW TASK</div>
                  <div class="panel-body">
                    <form id="form2">
                        <div class="form-group"> 
                          <b>TASK NAME:</b>
                            <select>
                              <option value="taskname">Task1</option>
                              <option value="taskname">Task2</option>
                              <option value="taskname">Task3</option>
                              <option value="taskname">Task4</option>
                            </select>    
                          <b>DATE:</b>
                          <input type="date" id="defaulttaskdate" name="arrdate" size="20" />
                        </div>
                        <div class="form-group"> 
                          <b>TASK NAME:</b>
                            <input type="text" id="Text1" size="50" />
                          <b>DATE:</b>
                          <input type="date" id="newtaskdate" name="arrdate" size="20" />
                        </div>                       
                    </form>
                    <button id="Button1" type="button" class="btn btn-primary">UPDATE TASK</button>
                  </div>
                </div>
              </div>
              <div role="tabpanel" class="tab-pane" id="settings">
                <div class="panel panel-default">
                  <div class="panel-heading">SELECT TASKS TO DELETE</div>
                  <div class="panel-body">

                     <table class="table table-striped">
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
                        <tr>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                          <td><input type="checkbox" name="task"> TASK NAME<br></td>
                        </tr>
               
                      </table>
                      <button type="button" class="btn btn-danger">DELETE TASKS</button>  <button type="button" class="btn btn-default">RELOAD TABLE</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script>
        $(function () {
            $('#schedtab a:last').tab('show')
        })
    </script>
      <script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/npm.js"></script>

    <!-- datepicker script -->
    <script type="text/javascript">
        var datefield = document.createElement("input")
        datefield.setAttribute("type", "date")
        if (datefield.type != "date") { //if browser doesn't support input type="date", load files for jQuery UI Date Picker
            document.write('<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"><\/script>\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"><\/script>\n')
        }
    </script>  
    <script>
        if (datefield.type != "date") { //if browser doesn't support input type="date", initialize date picker widget:
            jQuery(function ($) { //on document.ready
                $('#taskdate').datepicker();
                $('#departure').datepicker();
            })
        }
    </script>

    <!-- datepicker script addtask -->
    <script type="text/javascript">
        var datefield = document.createElement("input")
        datefield.setAttribute("type", "date")
        if (datefield.type != "date") { //if browser doesn't support input type="date", load files for jQuery UI Date Picker
            document.write('<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"><\/script>\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"><\/script>\n')
        }
    </script>  
    <script>
        if (datefield.type != "date") { //if browser doesn't support input type="date", initialize date picker widget:
            jQuery(function ($) { //on document.ready
                $('#addtaskdate').datepicker();
                $('#departure').datepicker();
            })
        }
    </script>

    <!-- datepicker script addtask -->
    <script type="text/javascript">
        var datefield = document.createElement("input")
        datefield.setAttribute("type", "date")
        if (datefield.type != "date") { //if browser doesn't support input type="date", load files for jQuery UI Date Picker
            document.write('<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"><\/script>\n')
            document.write('<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"><\/script>\n')
        }
    </script>  
    <script>
        if (datefield.type != "date") { //if browser doesn't support input type="date", initialize date picker widget:
            jQuery(function ($) { //on document.ready
                $('#newtaskdate').datepicker();
                $('#departure').datepicker();
            })
        }
    </script>

   </asp:Content>
