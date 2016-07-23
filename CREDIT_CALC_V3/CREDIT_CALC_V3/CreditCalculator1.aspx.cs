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
    public partial class CreditCalculator1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CalculationModule test = new CalculationModule();
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object Initialize()
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
            payments.Add(new CcPayment { Interest = 1, Commentary = "1", PaymentDate = Convert.ToDateTime("10.10.2010"), Redemption = 1, Withdrawal = 1 });
            payments.Add(new CcPayment { Interest = 2, Commentary = "2", PaymentDate = Convert.ToDateTime("10.10.2011"), Redemption = 2, Withdrawal = 2 });
            payments.Add(new CcPayment { Interest = 3, Commentary = "3", PaymentDate = Convert.ToDateTime("10.10.2012"), Redemption = 3, Withdrawal = 3 });
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

            var dict = prmtrs.ToDictionary(x => x.ParamName, parameter => new { parameter.ParamValue, parameter.Commentary });

            return new ResultData
            {
                Context = new { Dictionaries = dict },
                Error = false,
                ErrorMessage = null
            };
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
            p2.ParamValue = DateTime.Now.ToString();
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

            //var dict = prmtrs.ToDictionary(x => x.ParamName, parameter => new {parameter.ParamValue, parameter.Commentary});
            var dict = prmtrs.ToDictionary(x => x.ParamName, parameter => parameter.ParamValue );

            var dictionaries = new Dictionary<string, object>();

            var currenciesDictionary = new List<KeyValuePair<int, dynamic>>();
            currenciesDictionary.Add(new KeyValuePair<int, dynamic>(643, "Рубль"));
            currenciesDictionary.Add(new KeyValuePair<int, dynamic>(789, "Евро"));
            dictionaries.Add("CurrencyList", currenciesDictionary);

            var productDictionary = new List<KeyValuePair<int, dynamic>>();
            productDictionary.Add(new KeyValuePair<int, dynamic>(1,"Кредиты"));
            productDictionary.Add(new KeyValuePair<int, dynamic>(6, "Транши" ));
            dictionaries.Add("ProductTypeList", productDictionary);

            return new ResultData
            {
                Context = new
                {
                    Dictionaries = dictionaries,
                    Parameters = dict,
                    Model = 1
                },
                Error = false,
                ErrorMessage = null
            };
        }

        [System.Web.Services.WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object Calculate(object paramsReq)
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

            var з9 = new CcParameter();
            з9.ParamName = "ProductType";
            з9.ParamValue = 6;//DateTime.MaxValue.ToString(CultureInfo.InvariantCulture);
            з9.PreviousValue = null;
            з9.Commentary = "Дата начала";
            prmtrs.Add(з9);

            var p2 = new CcParameter();
            p2.ParamName = "DateStart";
            p2.ParamValue = null;//DateTime.MaxValue.ToString(CultureInfo.InvariantCulture);
            p2.PreviousValue = null;
            p2.Commentary = "Дата начала";
            prmtrs.Add(p2);

            var p3 = new CcParameter();
            p3.ParamName = "Payments";
            var payments = new List<CcPayment>();
            payments.Add(new CcPayment { Interest = 11, Commentary = "11", PaymentDate = Convert.ToDateTime("10.10.2013"), Redemption = 11, Withdrawal = 11 });
            payments.Add(new CcPayment { Interest = 22, Commentary = "22", PaymentDate = Convert.ToDateTime("10.10.2014"), Redemption = 22, Withdrawal = 22 });
            payments.Add(new CcPayment { Interest = 33, Commentary = "33", PaymentDate = Convert.ToDateTime("10.10.2015"), Redemption = 33, Withdrawal = 33 });
            p3.ParamValue = payments;
            p3.PreviousValue = null;
            p3.Commentary = "Платежи";
            prmtrs.Add(p3);

            var dict = prmtrs.ToDictionary(x => x.ParamName, parameter => parameter.ParamValue);


            return new ResultData
            {
                Context = new { Parameters = dict },
                Error = false,
                ErrorMessage = null
            };
        }



    }


}
