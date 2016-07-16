using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CreditCalculator.Repository
{
    public static class CcRepository
    {
        public static IList<object> GetParameterList(int modelId)
        {
            
            return null;
        }

        public static IList<object> GetValuesForCalc(long calcId)
        {

            return null;
        } 







    }

    public class CcRep
    {
        
    }

    public class CcClient
    {
        
    }

    public static class CcHelper
    {



        public static CcRep ToCcRep(this CcClient client)
        {
            return null;
        }

        public static CcClient ToCcClient(this CcRep rep)
        {
            return null;
        }
    }
}
