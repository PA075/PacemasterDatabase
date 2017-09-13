using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{

    public class UsersList
    {
        public string label { get; set; }
        public string value { get; set; }
    }
    

   public class AutocompleteList
    {
        public List<UsersList> UsersList { get; set; }
    }

        
}
