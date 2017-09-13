using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.EntityProvider.pacemaster
{
    public partial class MasterModel : DbContext
    {
        public MasterModel(string sConnectionString)
            : base(sConnectionString)
        {
        }
    }
}
