using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CreditCalculator;

namespace CREDIT_CALC_V3
{
    public class Calculator
    {
        public dynamic DataSource { get; set; }
        public object Model { get; internal set; }

        public object Calculate(object input)
        {
            throw new NotImplementedException();
        }
    }

    public class Parameter
    {
        public ParameterType Type { get; set; }
        public string Name { get; set; }
        public object Value { get; set; }
    }

    public enum ParameterType
    {
        Rating,
        Ccs
    }


    public class CalculatorHelper
    {
        public CalculatorHelper(Calculator calculator)
        {
            _calculator = calculator;
            FillParamList();
        }

        private void FillParamList()
        {
            _parameterList = new List<Parameter>(); //or _calculator.DataSource.GetParamsByModelId(_calculator.Model);
            _parameterList.Add(new Parameter());
        }

        private Calculator _calculator;
        private IList<Parameter> _parameterList; 

        public IDictionary<string, object> GetFullParameterDictionary(IList<Parameter> calcParameters)
        {
            Dictionary<string, object> result = new Dictionary<string, object>();
            foreach (var parameter in _parameterList)
            {
                var value = calcParameters.Any(x => x.Type == parameter.Type) ? calcParameters.First(x => x.Type == parameter.Type).Value : parameter.Value;
                result.Add(parameter.Name, value);
            }
            
            return result;
        }

        public IList<Parameter> ConvertParamsToObject(IDictionary<string, object> caclDictionary)
        {

            var result = caclDictionary.Join(_parameterList, o => o.Value, i => i.Name, (o, i) =>
            {
                var param = i;
                i.Value = o.Value;
                return param;
            }).ToList();

            return result;
        }

        public object ConvertToCalcInput(IList<Parameter> calcParameters)
        {

            return null;
        }

        public IList<Parameter> ConvertFromCalcOutnput(object calcOutput)
        {

            return null;
        }

        public IDictionary<string, object> Calculate(Calculation calculation, IDictionary<string, object> paramsDictionary)
        {
            calculation.Parameters = ConvertParamsToObject(paramsDictionary);
            var input = ConvertToCalcInput(calculation.Parameters);
            //input.Payments bla bla bla
            var output = _calculator.Calculate(input);
            var calcParams = ConvertFromCalcOutnput(output);
            calculation.Parameters = calcParams;
            //calculation.Payments = output.Payments

            var pDict = GetFullParameterDictionary(calculation.Parameters);
            return pDict;
        }


    }

    public class Calculation
    {
        public IList<Parameter> Parameters { get; set; }
    }



    /*On client side
    
    Создать поле CalcContext
             |
             Создать поле DependentData
             Создать метод для создания зависимостей между
                параметрами(пересекающиеся между группами параметров) и дополнительные (справчоные, типа .руб и тд)


    vat viewModel = function(){
    ..

    self.CalcContext = {};
    self.CalcContext.Data = {};
    self.CalcContext.RelatedData = {};
    self.CalcContext.DependentData = {};
    self.CalcContext.DependentData.BoundParams = function(){
        self.CalcContext.DependentData._currencyStrShort = ko.observable("");
        self.CalcContext.Data.NominalCurrency.subscribe(function(newValue){
            ...
            var shortStr = ko.utils.arrayFirst(self.CalcContext.RelatedData.Currencies, function(currency){ return currency.Key = newValue}) || 'ошибка';
            ...
        };
        self.CalcContext.DependentData._LGD = ko.pureCalculated(function(){
            ...
        };
    }

    ..
    }

    
    */
}