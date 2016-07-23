<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreditCalculator.aspx.cs" Inherits="CREDIT_CALC_V3.CreditCalculator" %>

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
    
   <button data-bind="click: Click">CALC</button>
   <button data-bind="click: Load">Load</button>
   <button data-bind="click: Check">Check</button>

    <ul data-bind="foreach: Parameters">
        <li>{{ParamName}}</li>
        <li><input type="text"  value="{{ParamValue}}" /></li>
    </ul>
            <input type="text"  data-bind="value: PRM('DateStart')" />
            <input type="text"  data-bind="value: PRM('DateEnd')" />
            <input type="text"  data-bind="value: PRM('DateEnd')" />
            <input type="text"  data-bind="value: PRM('RatingId')" />
            <input type="text"  data-bind="value: PRM('Payments')" />
            <input type="text"  data-bind="value: BoundedData._justShortDate" />
    
    
     <ul data-bind="foreach: PRM('Payments')">
         $index()
        <li>{{PaymentDate}}{{Redemption}}</li>
        <li><input type="text"  value="{{PaymentDate}}" /></li>
    </ul>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
    <script src="Scripts/jquery-3.0.0.js"></script>
    <script src="Scripts/moment-with-locales.js"></script>
    <script src="Scripts/knockout-3.4.0.debug.js"></script>
    <script src="Scripts/knockout.punches.js"></script>
    <script src="Scripts/knockout.validation.js"></script>
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
    <script type="text/javascript">
        function Parameter(data) {
            var self = this;
            ko.mapping.fromJS(data, {}, this);

            self.ParamName = {};
            self.ParamValue = {};
            self.DefaultValue = {};
            self.Commentary = {};
        }

        function ObjectToDate(obj, defaultValue) {
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

            self.SummaryPaid = ko.pureComputed(function() {
                return self.Redemption() + self.Interest();
            });

            return self;
        }


        var ParameterFactory = new function () {
            var self = this;
            self.CreateParameter = function (data) {
                var name = data.ParamName;
                var value = data.ParamValue || null;
                var parameter = ko.mapping.fromJS(data, { copy: ["ParamName"], ignore: ["ParamValue"] });

                    switch (name) {
                        case "DateStart":
                        case "DateEnd":
                            var date = ko.validation.utils.isEmptyVal(value) ? null : moment(value).toDate();
                            parameter.ParamValue = ko.observable(date);
                            break;
                        case "Payments":
                            var payments = value || [];
                            var pays = ko.utils.arrayMap(payments, function(item) {
                                return new Payment(item);
                            });
                            parameter.ParamValue = ko.observableArray(pays);
                            break;
                        default:
                            parameter.ParamValue = ko.observable(value);
                            break;
                    }
                    return parameter;

            };
            self.UpdateParameter = function (data, target) {
                var name = data.ParamName;
                var value = data.ParamValue || null;

                switch (name) {
                    case "DateStart":
                    case "DateEnd":
                        var date = ko.validation.utils.isEmptyVal(value) ? null : moment(value).toDate();
                        target.ParamValue(date);
                        break;
                    case "Payments":
                        var payments = value || [];
                        var pays = ko.utils.arrayMap(payments, function(item) {
                            return new Payment(item);
                        });
                        target.ParamValue(pays);
                        break;
                    default:
                        target.ParamValue(value);
                        break;
                }
                return target;
            };
            return self;
        }


        function Load() {
            return $.ajax({
                type: 'POST',
                url: '<%= ResolveUrl(@"~/CreditCalculator.aspx/Load") %>',
                data: '{ }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function(msg) {
                    //alert(msg.d);
                    console.log(msg.d);
                }
            });
        }
        function Calculate() {
            return $.ajax({
                type: 'POST',
                url: '<%= ResolveUrl(@"~/CreditCalculator.aspx/Calculate") %>',
                data: '{ }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function(msg) {
                    //alert(msg.d);
                    console.log(msg.d);

                }
            });
        }

        var mapping = {
            'Parameters': {
                key: function (options) {
                    var key = ko.utils.unwrapObservable(options.ParamName);
                    return key;
                },
                create: function (options) {
                    var prm = ParameterFactory.CreateParameter(options.data);
                    return prm; 
                },
                update: function (options) {
                    var prm = ParameterFactory.UpdateParameter(options.data, options.target);
                    return prm;
                }
            }
        };


  

        
        $(document).ready(function() {

            function viewM() {
                var self = this;
                self.Parameters = ko.observableArray([]);

                self.Update = function (data, initial) {
                    if (initial) {
                        // standard initial mapping 
                        ko.mapping.fromJS(data, mapping, self);
                    } else {
                        // merge orders
                        var newModel = ko.mapping.fromJS(data, mapping);

                        // go through all orders in the updated list
                        for (var i = 0; i < newModel.Parameters().length; i++) {
                            var newParam = newModel.Parameters()[i];

                            // find order with same key in existing ko model
                            var match = ko.utils.arrayFirst(self.Parameters(), function (item) {
                                return newParam.ParamName === item.ParamName;
                            });

                            if (match == null) {
                                //TrySetValueType(newParam);
                                self.Parameters.push(newParam);
                            }

                            // replace original order in list
                            self.Parameters.replace(match, newParam);
                        }
                    }
                };

                self.PRM = function (paramName) {
                    var parameter = ko.utils.arrayFirst(self.Parameters(), function(record) {
                        return record.ParamName === paramName;
                    }) || null;
                    var value = parameter === null ? null : parameter.ParamValue;
                    return value;
                };


                self.BoundedData = {};
                self.BoundedData._justShortDate = ko.pureComputed(function() {
                    var ds = ko.utils.unwrapObservable(self.PRM('DateStart'));
                    console.log('_justShortDate-ds--------------------------------');
                    console.log(ds);
                    var de = ko.utils.unwrapObservable(self.PRM('DateEnd'));
                    console.log('_justShortDate-de--------------------------------');
                    console.log(de);
                });

                self.Click = function () {
                    Calculate().done(function (data) {
                        self.Update(data.d.Context, false);
                        //ko.mapping.fromJS(data.d.Context, mapping, self);
                        console.log("Calculate().done");
                        console.log(self);

                    });
                };

                self.Load = function () {
                    Load().done(function (data) {
                        self.Update(data.d.Context, true);
                        //ko.mapping.fromJS(data.d.Context, mapping, self);
                        console.log("Calculate().done");
                        console.log(self);

                    });
                };
               
                self.Check = function () {
                        console.log(self);
                };
                

                return self;
            };

            var vm = new viewM();

            

          /*  Load().done(function(data) {
                ko.mapping.fromJS(data.d.Context, mapping, vm);
                console.log("Load().done");
                console.log(vm);

            });*/
            
            //ko.options.deferUpdates = true;
            ko.punches.enableAll();
            ko.applyBindings(vm);
        });


    </script>
</body>
</html>
