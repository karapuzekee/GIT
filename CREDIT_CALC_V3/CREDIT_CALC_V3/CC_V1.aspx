<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CC_V1.aspx.cs" Inherits="CREDIT_CALC_V3.CC_V1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.0.0.js"></script>
    <script src="Scripts/knockout-3.4.0.debug.js"></script>
    <script src="Scripts/knockout.punches.js"></script>
    <script src="Scripts/knockout.validation.js"></script>
    <script src="Scripts/ko.mapping.js"></script>
    <script src="Scripts/ko.plus.js"></script>
    <script src="Scripts/koGrid-2.1.1.debug.js"></script>
    <script src="Scripts/moment-with-locales.js"></script>
    <script src="Scripts/qunit-2.0.0.js"></script>
    <script src="CC_Scripts/main.js"></script>
</head>
<body>

                <input  data-bind="value: A" required></input>

<ul data-bind="foreach: Groups">
    <div data-bind='component: {name: "group",params: { data: $data }}'></div>
</ul>
    
<ul data-bind="foreach: Groups1">
    <li class="product">
                <strong data-bind="text: $data"></strong>
            </li>
</ul>


</body>
<script type="text/html" id="group-template">
    <li class="product">
        <strong data-bind="text: $index"></strong>
        <strong data-bind="text: AA"></strong>
                <input type="text" data-bind="value: P" required/>

        <ul data-bind="foreach: Parameters">
            <li class="product">
                <strong data-bind="text: $index"></strong>
                <br/>
                <strong data-bind="text: ParamId"></strong>
                <br/>
                <input type="text" data-bind="value: ParamValue" required/><br/>
            </li>
        </ul>
    </li>
</script>

<script type="text/javascript">




    ko.components.register('group', {
        viewModel: function(params) {
            self = this;
            this.Parameters = params.data.Parameters;
            this.AA = "AAAAAAAAAA";
            this.P = ko.observable().extend({required : true});

            this.callback = function(num) {
            };
        },
        template: { element: 'group-template' }
    });


    $(document).ready(function() {

        ko.validation.init({
            registerExtenders: true,
            messagesOnModified: true,
            insertMessages: true,
            parseInputAttributes: true,
            writeInputAttributes: true

        }, true);

        function GroupVM(data) {
            ko.mapping.fromJS(data, {}, this);
        }


        function ccViewModel() {
            var self = this;
            self.Groups1 = [1,2,3,4,5,6];
            self.A = ko.observable();
            self.Groups = ko.observableArray([]);
            self.Start = ko.command(function (id) {
                    return getAjax("/CC_V1.aspx/GetSettings", { id: id});
                }
            ).done(function(data) {
                ko.mapping.fromJS(data, {}, self);
                console.log(ko.toJSON(self));
             //   ko.applyBindings(self);
            });
        };

        var vm = new ccViewModel();
        ko.applyBindings(vm);

        for (var i = 0; i < 5 ;i++) {
            vm.Start(i);

        }


/*





        var VM = function () {
            var self = this;
            self.ID = ko.observable(1);
            self.Array = ko.observableArray([]);
            self.Array.subscribe(function (newVal) {
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
        console.log(ko.toJSON(unmapped2));*/
    });
</script>


</html>