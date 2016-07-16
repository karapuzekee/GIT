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
    

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
    <script src="Scripts/jquery-3.0.0.js"></script>
    <script src="Scripts/knockout-3.4.0.debug.js"></script>
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
        function search() {
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveUrl("~/CreditCalculator.aspx/search") %>',
                    data: '{ }',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function(msg) {
                        alert(msg.d);
                    }
                });
            }
        $(document).ready(function() {
            //search();
            

         /*   var VM = function() {
                var self = this;
                self.ID = ko.observable(1);
                self.Array = ko.observableArray([]);
                self.Array.subscribe(function(newVal) {
                    alert(ko.toJSON(newVal));
                });
            }
            var vm = new VM();
            ko.applyBindings(vm);

            var unmapped = ko.mapping.toJS(vm);
            console.log(ko.toJSON(unmapped));

            var data = { "id": 2, "Array": [{ "id": 1, "name": "Alice111" }] };
            var mapping = {
                'Array': {
                    key: function (data) {
                        return ko.utils.unwrapObservable(data.id);
                    }
                }
            }


            ko.mapping.fromJS(data, mapping, vm);
            var unmapped2 = ko.mapping.toJS(vm);
            console.log(ko.toJSON(unmapped2));
           
            */

            function GroupVM(data) {
                ko.mapping.fromJS(data, {}, this);
            }

            var data = { "Groups": [{ "Settings": { "ModelTypes": [{ "Key": 1, "Value": "Investing" }, { "Key": 2, "Value": "Turnover" }] }, "Parameters": [{ "ParamId": 1, "ParamValue": "srt1" }] }] };

            var mapping = {
                'Groups': {
                    create: function (options) {
                        return new GroupVM(options.data);
                    }
                }
            }
            var viewModel = ko.mapping.fromJS(data, mapping);
            console.log(ko.toJSON(viewModel));
           


        });
    </script>
</body>
</html>
