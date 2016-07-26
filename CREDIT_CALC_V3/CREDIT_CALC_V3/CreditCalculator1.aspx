<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreditCalculator1.aspx.cs" Inherits="CREDIT_CALC_V3.CreditCalculator1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
</form>
<%--<click params="a: a, b: b"></click>--%>
<%--<script type="text/html" id="click-l">
   <div data-bind="text: a"></div>

   <!--Use data-bind attribute to bind click:function() to ViewModel. -->
   <button data-bind="click:function(){callback(1)}">Increase</button>
   <button data-bind="click:function(){callback(-1)}">Decrease</button>
</script>--%>

<button data-bind="click: Calculate">CALC</button>
<button data-bind="click: Load">Load</button>
<ul data-bind="foreach: ComponentsSequence">
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

<script type="text/html" id="cc-client-conponent">
    1 <input type="text" value="{{Context.Parameters.DateStart}}"/>
    1 <input type="text" value="{{Context.Parameters.ProductType}}"/>
    1 <input type="text" value="{{Context.Parameters.CritRevenue}}"/>
    1 <input type="text" value="{{Context.Bounds._productShortStr}}"/>

    <select data-bind="options: Context.Dictionaries.YesNo, optionsText: 'Value', optionsValue: 'Key', value: Context.Parameters.CritRevenue">
    </select>

    <select data-bind="options: Context.Dictionaries.ProductTypeList, optionsText: 'Value', optionsValue: 'Key', value: Context.Parameters.ProductType">
    </select>

    <button data-bind="click: Context.Edit">Edit</button>
    <button data-bind="click: Context.Cancel">Cancel</button>
    <button data-bind="click: Context.EndEdit">EndEdit</button>
    <button data-bind="click: Context.Rollback">Rollback</button>
    FacilitySum<input type="text" data-bind="value: Context.Parameters.FacilitySum"/>

    <h2>{{Context.dirtyFlag.isDirty}}</h2>
    Context.Parameters.Payments()[0].Redemption<input type="text" value="{{Context.Parameters.Payments()[0].Redemption}}"/>

</script>
<script type="text/html" id="cc-product-component">
    2<input type="text" value="{{Context.Parameters.DateStart}}"/>
</script>
<script type="text/html" id="cc-guarantees-component">
    3<input type="text" value="{{Context.Parameters.DateStart}}"/>
</script>
<script type="text/html" id="cc-payments-component">
    4<input type="text" value="{{Context.Parameters.DateStart}}"/>
</script>
<script type="text/html" id="cc-rates-component">
    5<input type="text" value="{{Context.Parameters.DateStart}}"/>
</script>
<script type="text/html" id="cc-turnover-component">
    6<input type="text" value="{{Context.Parameters.DateStart}}"/>
</script>
<script type="text/javascript">

    function Load() {
        return $.ajax({
            type: 'POST',
            url: '<%= ResolveUrl(@"~/CreditCalculator1.aspx/Load") %>',
            data: '{ }',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (msg) {

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
            success: function(data) {

            }
        });
    }

    function TestZ(data) {
        return $.ajax({
            type: 'POST',
            url: '<%= ResolveUrl(@"~/CreditCalculator1.aspx/TestZ") %>',
            data: JSON.stringify(data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(data) {

            }
        });
    }

    $(document).ready(function() {
       // var vm = new CcComponentModel();
        Load().done(function (data) {
            var zz = ko.mapping.fromJS(data.d.Context, {
                "SomeClass": {
                    create: function (options) {
                        options.data.Payments = ko.editableArray(options.data.Payments);
                        ko.mapping.fromJS(options.data, {
                            "Payments": {
                                create: function(options) {
                                    options.data.PaymentDate = ko.editable(new Date());
                                    return options.data;
                                }
                            }
                        });
                        return options.data;
                    }
                }
            });

            zz.SomeClass.Payments.beginEdit();
            ko.editable.makeEditable(zz.SomeClass);
            zz.SomeClass.beginEdit();
            zz.SomeClass.S = 999;
            zz.SomeClass.S1 = 999;
            zz.SomeClass.S3 = 999;
            zz.SomeClass.S4 = { ID: 1, VALUE: 3 };

            var o = ko.mapping.fromJS(data.d.Context.SomeClass, {
                "Payments" : {
                    create : function(options) {
                        options.data.PaymentDate = ko.editable(new Date());
                        return options.data;
                    }
                }
            });
            

            var s = ko.mapping.toJS(zz.SomeClass);
            console.log(s);

            TestZ({ 's': s });
        });
        // ko.punches.enableAll();
        // ko.applyBindings(vm);
    });


</script>
</body>
</html>