using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
   public  class ForumQuestionDetails
    {
        public ForumQuestion forumQuestion { set; get; }
        public List<ForumAnswer> forumAnswers { set; get; }

        //[Display(Name = "LogoImagePath")]
        //public string LogoImagePath { get; set; }

        //[Display(Name = "PageHeader")]
        //public string PageHeader { get; set; }
    }
}
