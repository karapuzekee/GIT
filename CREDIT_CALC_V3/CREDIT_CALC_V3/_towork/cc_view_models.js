function CcComponentModel() {
    var self = this;
    self.ComponentsSequence = ko.observableArray([]);
    self.Load = ko.command(function () {
        return Load();
    }).done(function (data) {

        if (data.d.Context.Model === 1) {
            self.Context = new InvestContext();
            console.log(self);

            ko.mapping.fromJS(data.d.Context, ccMapping, self.Context);
            console.log(self);
            self.ComponentsSequence(InvestComponentsSequence);

            self.Context.dirtyFlag.reset();
        }
    });

    self.Calculate = ko.command({
        action: function () {
            var paramsReq = ko.mapping.toJS(self.Context.Parameters);
            return Calculate({ 'paramsReq': paramsReq });
        },
        canExecute: function () {
            //validation logic
            return true;
        }
    }).done(function (data) {
        ko.mapping.fromJS(data.d.Context, { ignore: ["Model", "Dictionaries"] }, self.Context);
        self.Context.dirtyFlag.reset();
    });

    self.Sign = ko.command(function () {

    }).done(function (options) {


    });
    ko.editable.makeEditable(self);

    self.Test = ko.editable();
    self.Edit = function () {
        self.beginEdit();
    };
    self.Cancel = function () {
        self.cancelEdit();
    };
    self.EndEdit = function () {
        self.endEdit();
    };
    self.Rollback = function () {
        self.rollback();
    };

    self.Load();
    return self;
}