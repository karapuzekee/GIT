using System;
using System.Collections.Generic;
using System.Globalization;
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
        public static object Load()
        {
           var prmtrs = new List<CcParameter>();
               var p1 = new CcParameter();
              p1.ParamName = "RatingId";
              p1.ParamValue = 12;
              p1.PreviousValue = 1;
              p1.Commentary = "Рейтинг клиента";
              prmtrs.Add(p1);
              
            var p2 = new CcParameter();
            p2.ParamName = "DateStart";
            p2.ParamValue = DateTime.Now.ToString(CultureInfo.InvariantCulture);
            p2.PreviousValue = null;
            p2.Commentary = "Дата начала";
            prmtrs.Add(p2);

            var p3 = new CcParameter();
            p3.ParamName = "Payments";
            var payments = new List<CcPayment>();
            payments.Add(new CcPayment {Interest = 1, Commentary = "1", PaymentDate = Convert.ToDateTime("10.10.2010"), Redemption = 1, Withdrawal = 1});
            payments.Add(new CcPayment {Interest = 2, Commentary = "2", PaymentDate = Convert.ToDateTime("10.10.2011"), Redemption = 2, Withdrawal = 2});
            payments.Add(new CcPayment {Interest = 3, Commentary = "3", PaymentDate = Convert.ToDateTime("10.10.2012"), Redemption = 3, Withdrawal = 3});
            p3.ParamValue = payments;
            p3.PreviousValue = null;
            p3.Commentary = "Платежи";
            prmtrs.Add(p3);

            var p4 = new CcParameter();
            p4.ParamName = "CcsID";
            p4.ParamValue = "1";
            p4.PreviousValue = 1;
            p4.Commentary = "ЦКС клиента";
            prmtrs.Add(p4);

            return new ResultData
            {
                Context = new { Parameters = prmtrs },
                Error = false,
                ErrorMessage = null
            };
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object Calculate()
        {
            var prmtrs = new List<CcParameter>();
            var p1 = new CcParameter();
            p1.ParamName = "CcsID";
            p1.ParamValue = "10";
            p1.PreviousValue = 1;
            p1.Commentary = "Рейтинг клиента";
            prmtrs.Add(p1);

            var p4 = new CcParameter();
            p4.ParamName = "CritRevenue";
            p4.ParamValue = "true";
            p4.PreviousValue = 1;
            p4.Commentary = "CritRevenue";
            prmtrs.Add(p4);


            var p5 = new CcParameter();
            p5.ParamName = "DateEnd";
            p5.ParamValue = Convert.ToDateTime("1.1.2011").ToString(CultureInfo.InvariantCulture);//DateTime.MaxValue.ToString(CultureInfo.InvariantCulture);
            p5.PreviousValue = null;
            p5.Commentary = "Дата начала";
            prmtrs.Add(p5);


            var p2 = new CcParameter();
            p2.ParamName = "DateStart";
            p2.ParamValue = null;//DateTime.MaxValue.ToString(CultureInfo.InvariantCulture);
            p2.PreviousValue = null;
            p2.Commentary = "Дата начала";
            prmtrs.Add(p2);

            var p3 = new CcParameter();
            p3.ParamName = "Payments";
            var payments = new List<CcPayment>();
            payments.Add(new CcPayment { Interest = 11, Commentary = "11", PaymentDate = Convert.ToDateTime("10.10.2010"), Redemption = 11, Withdrawal = 11 });
            payments.Add(new CcPayment { Interest = 22, Commentary = "22", PaymentDate = Convert.ToDateTime("10.10.2011"), Redemption = 22, Withdrawal = 22 });
            payments.Add(new CcPayment { Interest = 33, Commentary = "33", PaymentDate = Convert.ToDateTime("10.10.2012"), Redemption = 33, Withdrawal = 33 });
            p3.ParamValue = payments;
            p3.PreviousValue = null;
            p3.Commentary = "Платежи";
            prmtrs.Add(p3);

            return new ResultData
            {
                Context = new { Parameters = prmtrs },
                Error = false,
                ErrorMessage = null
            };
        }



    }

    public class ResultData
    {
        public bool Error { get; set; }
        public string ErrorMessage { get; set; }
        public object Context { get; set; }
    }

    public class CalcContext
    {
        public IList<CcParameter> Parameters{ get; set; }
        public IDictionary<string, object> Dictionaries{ get; set; }
        public IDictionary<string, object> BackgroundInfo { get; set; }
    }

    public class CcPayment
    {
        public DateTime PaymentDate  { get; set; }
        public decimal Withdrawal { get; set; }
        public decimal Redemption{ get; set; }
        public decimal Interest{ get; set; }
        public string Commentary { get; set; }
    }

    public class CcParameter
    {
        public string ParamName { get; set; }
        public object ParamValue { get; set; }
        public object PreviousValue { get; set; }
        public string Commentary { get; set; }
    }
}
