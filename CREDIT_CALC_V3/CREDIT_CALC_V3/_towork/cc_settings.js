var InvestComponentsSequence = ["cc-client-conponent", "cc-product-component", "cc-guarantees-component", "cc-payments-component", "cc-rates-component"];
var TurnoverComponentsSequence = ["cc-client-conponent", "cc-turnover-component"];

function InvestContext() {
    var self = this;

    self.Parameters = {};

    self.Parameters.Rating = ko.observable();
    self.Parameters.Ccs = ko.observable();
    self.Parameters.CritLimit = ko.observable();
    self.Parameters.CritRevenue = ko.editable();
    self.Parameters.FacilitySum = ko.editable();
    self.Parameters.FacilityDuration = ko.observable();
    self.Parameters.ProductSum = ko.observable();
    self.Parameters.ProductType = ko.editable();
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
    self.Parameters.DateStart = ko.editable();
    self.Parameters.DateEnd = ko.observable();
    self.Parameters.Payments = ko.editableArray([]);
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
    self.Dictionaries.YesNo = [{ Key: 0, Value: "Нет" }, { Key: 1, Value: "Да" }];

    self.Bounds = {};
    self.Bounds._currencyShortStr = ko.pureComputed(function() {
        var currencyValue = ko.utils.unwrapObservable(self.Parameters.NominalCurrency);

        var entry = ko.utils.arrayFirst(self.Dictionaries.CurrencyList, function(item) {
            return item.Key === currencyValue;
        }) || null;
        return entry === null ? "неизвестно" : entry.Value;

    });
    self.Bounds._productShortStr = ko.pureComputed(function() {
        var productValue = ko.utils.unwrapObservable(self.Parameters.ProductType);

        var entry = ko.utils.arrayFirst(self.Dictionaries.ProductTypeList, function(item) {
            return item.Key === productValue;
        }) || null;
        return entry === null ? "неизвестно" : entry.Value;
    });


    ko.editable.makeEditable(self.Parameters);

    self.Edit = function() {
        self.Parameters.beginEdit();
    };
    self.Cancel = function() {
        self.Parameters.cancelEdit();
    };
    self.EndEdit = function() {
        self.Parameters.endEdit();
    };
    self.Rollback = function() {
        self.Parameters.rollback();
    };

    self.dirtyFlag = new ko.dirtyFlag(self, true);

    return self;
};