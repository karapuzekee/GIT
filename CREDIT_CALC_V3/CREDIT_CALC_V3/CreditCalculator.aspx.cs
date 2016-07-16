using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using CreditCalculator;

namespace CREDIT_CALC_V3
{
    public partial class CreditCalculator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CalculationModule test = new CalculationModule();
        }


        [System.Web.Services.WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string search()
        {
            return "worked";
        }
    }
}