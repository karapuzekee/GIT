var ccMapping = {
    "Dictionaries": {
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
                }
            }
            return options.data;
        },
        update: function(options) {
            for (var k in options.data) {
                if (options.target.hasOwnProperty(k)) {
                    ParameterFactory.UpdateParameter(k, options.data, options.target);
                }
            }
            return options.target;
        }
    },
    ignore: ["Model", "Bounds"]
};