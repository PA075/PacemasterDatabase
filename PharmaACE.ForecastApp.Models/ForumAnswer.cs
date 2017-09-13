using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class ForumAnswer
    {
        [Display(Name = "Answer Id")]
        public int AnswerId { get; set; }

        [Display(Name = "User Id")]
        public int UserId { get; set; }

        [Display(Name = "Answer Attachments")]
        public List<Attachment> Attachments { get; set; }

        [Display(Name = "Post Date")]
        public DateTime PostDate { get; set; }

        //[Display(Name = "Modify Date")]
        //public DateTime ModifyDate { get; set; }

        [Display(Name = "Answer")]
        public string AnswerText { get; set; }

        public int QuestionId { get; set; }
        
    }
}
