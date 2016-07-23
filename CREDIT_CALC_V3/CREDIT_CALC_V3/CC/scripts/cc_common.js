function CcComponentModel() {
    var self = this;

    self.ComponentsSequence = ko.observableArray([]);

    self.Load = ko.command(function() {

    }).done(function(options) {

    }).failed(function(options) {

    });

    self.Calculate = ko.command(function() {

    }).done(function(options) {

    }).failed(function(options) {

    });

    self.Sign = ko.command(function() {

    }).done(function(options) {

    }).failed(function(options) {

    });


    return self;
}


var InvestParameterList = [
    "Rating", "Ccs", "CritLimit", "CritRevenue",
    "FacilitySum, FacilityDuration", "ProductSum", "ProductType", "CommFix", "CommVar", "Option", "NominalCurrency", "ExchangeRate",
    "Guarantees",
    "RepaymentType", "ManualInput", "RedemDelayType", "RedemPercentDelayType", "RedemDelay", "RedemPercentDelay", "DateStart", "DateEnd",
    "Payments",
    "Rates"
];
var TurnoverParameterList = [
    "Rating", "Ccs", "CritLimit", "CritRevenue",
    "FacilityDuration", "ProductSum", "ProductType", "CommFix", "CommVar", "Option", "NominalCurrency", "ExchangeRate",
    "Guarantees",
    "RepaymentType",
    "Rates"
];
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
    self.Parameters.Parameters.Option = ko.observable();
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

    self.Bounds._currencyShortStr = ko.pureComputed(function() {
        var currencyValue = ko.utils.unwrapObservable(self.Parameters.NominalCurrency);

        var entry = ko.utils.arrayFirst(self.Dictionaries.CurrencyList, function(item) {
            return item.Key === currencyValue;
        }) || null;
        return entry === null ? "неизвестно" : entry.ShortStr;

    });
    self.Bounds._productShortStr = ko.pureComputed(function () {
        var productValue = ko.utils.unwrapObservable(self.Parameters.ProductType);

        var entry = ko.utils.arrayFirst(self.Dictionaries.ProductTypeList, function (item) {
            return item.Key === productValue;
        }) || null;
        return entry === null ? "неизвестно" : entry.ShortStr;
    });


    return self;
}



var ParameterFactory = new function() {
    var self = this;
    self.CreateParameter = function(data) {
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
    self.UpdateParameter = function(data, target) {
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
}