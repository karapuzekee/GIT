var ParameterFactory = new function () {
    var self = this;
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
    };
};

function Payment(data) {
    var self = this;
    var date = ObjectToDate(data.PaymentDate);
    self.PaymentDate = ko.observable(date);
    var withdrawal = ObjectToFloat(data.Withdrawal);
    self.Withdrawal = ko.observable(withdrawal);
    var redemption = ObjectToFloat(data.Redemption, 0);
    self.Redemption = ko.editable(redemption);
    var interest = ObjectToFloat(data.Interest);
    self.Interest = ko.observable(interest);
    self.Commentary = ko.observable(data.Commentary || "");

    self.SummaryPaid = ko.pureComputed(function () {
        return self.Redemption() + self.Interest();
    });

    return self;
}

ko.dirtyFlag = function (root, isInitiallyDirty) {
    var result = function () { },
        _initialState = ko.observable(ko.toJSON(root)),
        _isInitiallyDirty = ko.observable(isInitiallyDirty);

    result.isDirty = ko.computed(function () {
        return _isInitiallyDirty() || _initialState() !== ko.toJSON(root);
    });

    result.reset = function () {
        _initialState(ko.toJSON(root));
        _isInitiallyDirty(false);
    };

    return result;
};

function ObjectToDate(obj, defaultValue) {
    return !ko.validation.utils.isEmptyVal(obj) ? moment(obj).toDate() : defaultValue || null;
}

function ObjectToFloat(obj, defaultValue) {
    return !ko.validation.utils.isEmptyVal(obj) ? parseFloat(obj) : defaultValue || null;
}

function ObjectToInt(obj, defaultValue) {
    return !ko.validation.utils.isEmptyVal(obj) ? parseInt(obj) : defaultValue || null;
}