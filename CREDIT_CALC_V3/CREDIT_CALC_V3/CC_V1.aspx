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

                <input  data-bind="value: A, click: callback"></input>

<ul data-bind="foreach: Groups">
    <div data-bind='component: {name: "group",params:  $data }'></div>
</ul>
    
<ul data-bind="foreach: Groups1">
    <li class="product">
                <strong data-bind="text: $data"></strong>
            </li>
</ul>


</body>
<script type="text/html" id="group-template">
    <li class="product">
        <strong data-bind="text: $index, click: callback"></strong>

                <input type="text" data-bind="value: P"/>
        <p>------------------</p>
                <input type="text" data-bind="value: P1"/>
        <p>------------------</p>
           
        <select data-bind="options: Settings.ModelTypes, optionsText: 'Value', optionsValue: 'Key', value: selectedProduct"></select>
                <strong data-bind="text: selectedProduct"></strong>
                <strong data-bind="text: $root.A"></strong>
                <input type="text" data-bind="value: SupaTest"/><br/>

        <ul data-bind="foreach: Parameters">
            <li class="product">
                <strong data-bind="text: $index"></strong>
                <br/>
                <%--<strong data-bind="text: ParamId"></strong>--%>
                <strong data-bind="text: $data['ParamId']"></strong>
                <br/>
                <input type="text" data-bind="value: ParamValue"/><br/>
                <input type="text" data-bind="value: $data['ParamId']"/><br/>
                <input type="text" data-bind="value: $parent.DataSettings['P1'].paramName"/><br/>
            </li>
        </ul>
    </li>
</script>
    
<script type="text/html" id="client-group-template">
    <div>
        
    </div>
</script>


    



<script type="text/javascript">




    ko.components.register('group', {
        viewModel: function(params) {
            var self = params;
          //  self.Parameters = params.data.Parameters;
       //     self.Settings = params.data.Settings;
            params.selectedProduct = ko.observable();
           
            self.P1.extend({ required: true });
            self.P = ko.observable().extend({ required: true });
            self['SupaTest'] = ko.observable(1111122222233333);
            self.DataSettings = {
                "P1": { "paramName": "Param1Name" }
            }
           
            self.callback = function (num) {
                console.log(self);
                alert(self.DataSettings['P1'].paramName);

              //  alert(ko.toJSON(self.root));

               
            };
            return self;
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
            self.A = ko.observable(123);
            self.Groups = ko.observableArray([]);
            self.Start = ko.command(function (id) {
                    return getAjax("/CC_V1.aspx/GetSettings", { id: id});
                }
            ).done(function(data) {
                ko.mapping.fromJS(data, {}, self);
                console.log(ko.toJSON(self));
                                

            });

            self.Start2 = ko.command(function (id) {
                return getAjax("/CC_V1.aspx/GetCalcValues", { id: id });
            }
            ).done(function (data) {
                ko.mapping.fromJS(data, {}, self);
                console.log(ko.toJSON(self));
                //   ko.applyBindings(self);


               
            });

            self.callback = function (num) {
              //  alert(ko.toJSON(self));

                console.log('self');
                console.log(self);
                console.log('ko.toJS(self)');
                console.log(ko.toJS(self));
                console.log('ko.toJSON(self)');
                console.log(ko.toJSON(self));
                console.log('ko.mapping.toJS(self)');
                console.log(ko.mapping.toJS(self));
                console.log('ko.mapping.toJSON(self)');
                console.log(ko.mapping.toJSON(self));




                var mapping = {
                    'ignore': ["Groups.AA", "Groups1"]
                    //'ignore': ["Groups1"]
                };
                var mapped = ko.mapping.toJSON(self);
                var thin = ko.mapping.fromJSON(mapped, mapping);


                alert(ko.mapping.toJSON(thin));
            };
        };



        var vm = new ccViewModel();
        ko.applyBindings(vm);

        for (var i = 0; i < 5 ;i++) {
            vm.Start(i);

        }



       // var a = ko.mapping.fromJS(ko.toJS(vm), {});
        console.log(ko.toJS(vm));

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