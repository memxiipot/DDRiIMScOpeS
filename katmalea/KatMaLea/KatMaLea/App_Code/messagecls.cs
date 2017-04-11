using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KatMaLea
{
    public class messagecls
    {
        public static string dismissableErrorMessage(string message) {
            string msg = "<div id=\"myMessage\" clientidmode=\"static\" class=\"alert alert-warning alert-dismissible\" role=\"alert\">" +
                 "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>" +
                "<strong>Warning!</strong>" + message+"</div>";
            return msg;
        }
        public static string alertSuccess(string message) {
            return "<div id=\"myMessage\" class=\"alert alert-success\" role=\"alert\">" + message + "</div>";
        }
        public static string alertInfo(string message)
        {
            return "<div  id=\"myMessage\" class=\"alert alert-info\" role=\"alert\">" + message + "</div>";
        }
        public static string alertWarning(string message)
        {
            return "<div  id=\"myMessage\" class=\"alert alert-warning\" role=\"alert\">" + message + "</div>";
        }
        public static string alertDanger(string message)
        {
            return "<div id=\"myMessage\"  class=\"alert alert-danger\" role=\"alert\">" + message + "</div>";
        }
    }
}