using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.EntityProvider.TenantModel
{
    public partial class TenantModel : DbContext
    {
        public TenantModel(string sConnectionString)
            : base(sConnectionString)
        {
        }
    }
}
