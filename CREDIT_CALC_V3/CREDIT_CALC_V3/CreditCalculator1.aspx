<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreditCalculator1.aspx.cs" Inherits="CREDIT_CALC_V3.CreditCalculator1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
    <%--<div>
    <h1 id="id1">text</h1>
        <span data-bind="text: ID"></span>
        <span data-bind="text: Array().lenght"></span>
    </div>--%>
</form>

<!--params attribute is used to pass the parameter to component viewModel.-->
<%--<click params="a: a, b: b"></click>--%>

<!--template is used for a component by specifying its ID -->
<%--<script type="text/html" id="click-l">
   <div data-bind="text: a"></div>

   <!--Use data-bind attribute to bind click:function() to ViewModel. -->
   <button data-bind="click:function(){callback(1)}">Increase</button>
   <button data-bind="click:function(){callback(-1)}">Decrease</button>
</script>--%>

<button data-bind="click: Calculate">CALC</button>
<button data-bind="click: Load">Load</button>
<%--<button data-bind="click: Check">Check</button>

<ul data-bind="foreach: Parameters">
    <li>{{ParamName}}</li>
    <li>
        <input type="text" value="{{ParamValue}}"/>
    </li>
</ul>
<input type="text" data-bind="value: PRM('DateStart')"/>
<input type="text" data-bind="value: PRM('DateEnd')"/>
<input type="text" data-bind="value: PRM('DateEnd')"/>
<input type="text" data-bind="value: PRM('RatingId')"/>
<input type="text" data-bind="value: PRM('Payments')"/>
<input type="text" data-bind="value: BoundedData._justShortDate"/>

    --%>
<ul data-bind="foreach: ComponentsSequence">
    {{$index}}
    <li>{{$data}}</li>
    <%--{{#template $data/}}--%>
    <div data-bind="template: { name: $data, data: $root }"></div>

</ul>
    


<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
<script src="Scripts/jquery-3.0.0.js"></script>
<script src="Scripts/moment-with-locales.js"></script>
<script src="Scripts/knockout-3.4.0.debug.js"></script>
<script src="Scripts/knockout.punches.js"></script>
<script src="Scripts/knockout.validation.js"></script>
<script src="Scripts/ko.plus.js"></script>
<script src="Scripts/ko.mapping.js"></script>
<%--<script type="text/javascript">
        ko.components.register('click', {
            viewModel: function (params) {
                self = this;
                this.a = params.a;
                this.b = params.b;

                this.callback = function (num) {
                    self.b(parseInt(num));
                    self.a(self.a() + parseInt(num));

                    alert(ko.toJSON(params.$root));
                };
            },
            template: { element: 'click-l' }
        });

        //keeps an eye on variable for any modification in data
        function viewModel() {
            this.a = ko.observable(2);
            this.b = ko.observable(100);
        }

        ko.applyBindings(new viewModel());




    </script>--%>
    
    <script type="text/html" id="cc-client-conponent">
       1 <input type="text" value="{{Context.Parameters.DateStart}}" />
       1 <input type="text" value="{{Context.Parameters.ProductType}}" />
        <select data-bind="options: Context.Dictionaries.ProductTypeList, optionsText: 'Value', optionsValue: 'Key', value: Context.Parameters.ProductType">
            
        </select>
        

    </script>
    <script type="text/html" id="cc-product-component">
        2<input type="text" value="{{Context.Parameters.DateStart}}" />
        

    </script>
    <script type="text/html" id="cc-guarantees-component">
        3<input type="text" value="{{Context.Parameters.DateStart}}" />
        

    </script>
    <script type="text/html" id="cc-payments-component">
        4<input type="text" value="{{Context.Parameters.DateStart}}" />
        

    </script>
    <script type="text/html" id="cc-rates-component">
        5<input type="text" value="{{Context.Parameters.DateStart}}" />
        

    </script>
    <script type="text/html" id="cc-turnover-component">
        6<input type="text" value="{{Context.Parameters.DateStart}}" />
        

    </script>
<script type="text/javascript">

    function Load() {
        return $.ajax({
            type: 'POST',
            url: '<%= ResolveUrl(@"~/CreditCalculator1.aspx/Load") %>',
            data: '{ }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(msg) {
            }
        });
    }

    function Calculate(data) {
        return $.ajax({
            type: 'POST',
            url: '<%= ResolveUrl(@"~/CreditCalculator1.aspx/Calculate") %>',
            data: JSON.stringify(data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(msg) {

            }
        });
    }

    function ObjectToDate(obj, defaultValue) {
        //alert(Date(obj));
        return !ko.validation.utils.isEmptyVal(obj) ? moment(obj).toDate() : defaultValue || null;
    }

    function ObjectToFloat(obj, defaultValue) {
        return !ko.validation.utils.isEmptyVal(obj) ? parseFloat(obj) : defaultValue || null;
    }

    function ObjectToInt(obj, defaultValue) {
        return !ko.validation.utils.isEmptyVal(obj) ? parseInt(obj) : defaultValue || null;
    }

    function Payment(data) {
        var self = this;
        var date = ObjectToDate(data.PaymentDate);
        self.PaymentDate = ko.observable(date);
        var withdrawal = ObjectToFloat(data.Withdrawal);
        self.Withdrawal = ko.observable(withdrawal);
        var redemption = ObjectToFloat(data.Redemption);
        self.Redemption = ko.observable(redemption);
        var interest = ObjectToFloat(data.Interest);
        self.Interest = ko.observable(interest);
        self.Commentary = ko.observable(data.Commentary || "");

        self.SummaryPaid = ko.pureComputed(function () {
            return self.Redemption() + self.Interest();
        });

        return self;
    }

    var ParameterFactory = new function () {
        var self = this;
        self.CreateParameter = function (name, target) {
            var value = target[name] || null;

            switch (name) {
                case "DateStart":
                case "DateEnd":
                    var date = ko.validation.utils.isEmptyVal(value) ? null : Date(value); //moment(value).toDate();
                    target[name](date);
                    break;
                case "Payments":
                    var payments = value || [];
                    var pays = ko.utils.arrayMap(payments, function (item) {
                        return new Payment(item);
                    });
                    target[name](pays);
                    break;
                default:
                    target[name](value);
                    break;
            }
            //return parameter;

        };
        self.UpdateParameter = function (name, src, target) {
            var value = src[name] || null;

            switch (name) {
                case "DateStart":
                case "DateEnd":
                    var date = ko.validation.utils.isEmptyVal(value) ? null : Date(value); //moment(value).toDate();
                    target[name](date);
                    break;
                case "Payments":
                    var payments = value || [];
                    var pays = ko.utils.arrayMap(payments, function (item) {
                        return new Payment(item);
                    });
                    target[name](pays);
                    break;
                default:
                    target[name](value);
                    break;
            }
            //return target;
        };

        self.ConvertForRequest = function (name, src, target) {
            var value = src[name] || null;

            switch (name) {
                case "DateStart":
                case "DateEnd":
                    var date = ko.validation.utils.isEmptyVal(value) ? null : Date(value); //moment(value).toDate();
                    target[name](date);
                    break;
                case "Payments":
                    var payments = value || [];
                    var pays = ko.utils.arrayMap(payments, function (item) {
                        return new Payment(item);
                    });
                    target[name](pays);
                    break;
                default:
                    target[name](value);
                    break;
            }
            //return target;
        };
    }

    var ccMapping = {
        "Dictionaries": {
            create: function(options) {
                console.log(options);
            },
            update: function(options) {
                for (var k in options.data) {
                    if (options.target.hasOwnProperty(k)) {
                        options.target[k] = options.data[k];
                    }
                }
                return options.target;
            }
        },
        "Parameters": {
            create: function(options) {
                for (var k in options.data) {
                    if (self.Context.Parameters.hasOwnProperty(k)) {
                        ParameterFactory.UpdateParameter(k, options.data, options.target);
                        //options.target[k] = options.data[k];
                    }
                }
                return options.data;
            },
            update: function(options) {
                for (var k in options.data) {
                    if (options.target.hasOwnProperty(k)) {
                        ParameterFactory.UpdateParameter(k, options.data, options.target);
                        //options.target[k] = options.data[k];
                    }
                }
                return options.target;
            }
        },
        ignore: ["Model", "Bounds"]
    };


    function CcComponentModel() {
        var self = this;
        self.ComponentsSequence = ko.observableArray([]);
        self.Load = ko.command(function() {
            return Load();
        }).done(function(data) {

            if (data.d.Context.Model === 1) {
                self.Context = new InvestContext();
                console.log(self);

                ko.mapping.fromJS(data.d.Context, ccMapping, self.Context);
                console.log(self);
                self.ComponentsSequence(InvestComponentsSequence);
            }
        });

        self.Calculate = ko.command({
            action: function() {
                var paramsReq = ko.mapping.toJS(self.Context.Parameters);
                console.log(paramsReq);
                return Calculate({ 'paramsReq': paramsReq });
            },
            canExecute: function() {
                //validation logic
                return true;
            }
        }).done(function(data) {
            ko.mapping.fromJS(data.d.Context, { ignore: ["Model", "Dictionaries"] }, self.Context);
        });

        self.Sign = ko.command(function() {

        }).done(function(options) {

        });

        self.Load();
        return self;
    }

    var InvestComponentsSequence = ["cc-client-conponent", "cc-product-component", "cc-guarantees-component", "cc-payments-component", "cc-rates-component"];
    var TurnoverComponentsSequence = ["cc-client-conponent", "cc-turnover-component"];

    function InvestContext() {
        var self = this;
        self.Parameters = {};
        self.Parameters.Rating = ko.observable();
        self.Parameters.Ccs = ko.observable();
        self.Parameters.CritLimit = ko.observable();
        self.Parameters.CritRevenue = ko.observable();
        self.Parameters.FacilitySum = ko.observable();
        self.Parameters.FacilityDuration = ko.observable();
        self.Parameters.ProductSum = ko.observable();
        self.Parameters.ProductType = ko.observable();
        self.Parameters.CommFix = ko.observable();
        self.Parameters.CommVar = ko.observable();
        self.Parameters.Option = ko.observable();
        self.Parameters.NominalCurrency = ko.observable();
        self.Parameters.ExchangeRate = ko.observable();
        self.Parameters.Guarantees = ko.observableArray([]);
        self.Parameters.RepaymentType = ko.observable();
        self.Parameters.ManualInput = ko.observable();
        self.Parameters.RedemDelayType = ko.observable();
        self.Parameters.RedemPercentDelayType = ko.observable();
        self.Parameters.RedemDelay = ko.observable();
        self.Parameters.RedemPercentDelay = ko.observable();
        self.Parameters.DateStart = ko.observable();
        self.Parameters.DateEnd = ko.observable();
        self.Parameters.Payments = ko.observableArray([]);
        self.Parameters.Rates = ko.observableArray([]);

        self.Dictionaries = {};
        self.Dictionaries.ProductTypeList = [];
        self.Dictionaries.FacilityDurationList = [];
        self.Dictionaries.CurrencyList = [];
        self.Dictionaries.GuarantreeTypeList = [];
        self.Dictionaries.GuarantreeCategoryList = [];
        self.Dictionaries.RepaymentTypeList = [];
        self.Dictionaries.RedemDelayTypeList = [];
        self.Dictionaries.RedemPercentDelayTypeList = [];
        self.Dictionaries.RedemDelayList = [];
        self.Dictionaries.RedemPercentDelayList = [];

        self.Bounds = {};
        self.Bounds._currencyShortStr = ko.pureComputed(function() {
            var currencyValue = ko.utils.unwrapObservable(self.Parameters.NominalCurrency);

            var entry = ko.utils.arrayFirst(self.Dictionaries.CurrencyList, function(item) {
                return item.Key === currencyValue;
            }) || null;
            return entry === null ? "неизвестно" : entry.ShortStr;

        });
        self.Bounds._productShortStr = ko.pureComputed(function() {
            var productValue = ko.utils.unwrapObservable(self.Parameters.ProductType);

            var entry = ko.utils.arrayFirst(self.Dictionaries.ProductTypeList, function(item) {
                return item.Key === productValue;
            }) || null;
            return entry === null ? "неизвестно" : entry.ShortStr;
        });


        return self;
    }

    $(document).ready(function() {
        var vm = new CcComponentModel();

        ko.punches.enableAll();
        ko.applyBindings(vm);
    });


</script>
</body>
</html>