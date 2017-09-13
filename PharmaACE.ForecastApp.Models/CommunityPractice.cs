using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class CommunityPractice
    {
        //public string LogoImagePath { get; set; }
        //public string PageHeader { get; set; }

        public IEnumerable<ForumQuestion> questionList { get; set; }
    }
}
