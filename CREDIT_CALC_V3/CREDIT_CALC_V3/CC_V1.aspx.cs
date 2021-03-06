﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CREDIT_CALC_V3
{
    public partial class CC_V1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }








        [System.Web.Services.WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static object GetSettings(int id)
        {
            var productTypes = new List<KeyValuePair<int, string>>();
            productTypes.Add(new KeyValuePair<int, string>(1, "Investing" + id));
            productTypes.Add(new KeyValuePair<int, string>(2, "Turnover" + id));

            var groups = new List<Group>();
            var g1 = new Group();
            g1.Settings.Add("ModelTypes", productTypes);
            g1.Parameters.Add(new CcParam {ParamId = 1, ParamValue = "srt1" + id, ParamName = "P1"});
            g1.Parameters.Add(new CcParam {ParamId = 2, ParamValue = "srt2" + id, ParamName = "P2"});
            groups.Add(g1);

            var g2 = new Group();
            g2.Settings.Add("ModelTypes", productTypes);
            g2.Parameters.Add(new CcParam {ParamId = 2, ParamValue = "srt2" + id, ParamName = "P1" });
            groups.Add(g2);
            var resut = new
            {
                Groups = groups
            };

            return resut;
        }
    }

    public class Group
    {
        public Group()
        {
            Settings = new Dictionary<string, object>();
            Parameters = new List<CcParam>();
        }
        public int P1 { get; set; }
        public IDictionary<string, object> Settings { get; set; }
        public IList<CcParam> Parameters { get; set; }  
    }

    public class CcParam
    {
        public int ParamId { get; set; }
        public string ParamValue { get; set; }
        public string ParamName { get; set; }
        public ParamType ParamType { get; set; }
    }

    public enum ParamType
    {
        nmbr,
        str,
        slct,
        datetime,
    }
}