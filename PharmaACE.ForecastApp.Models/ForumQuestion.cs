using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class ForumQuestion
    {
        [Display(Name = "Question Id")]
        public int QuestionId { get; set; }

        [Display(Name = "User Id")]
        public int UserId { get; set; }

        [Display(Name = "Title")]
        public string QuestionTitle { get; set; }

        [Display(Name = "Category")]
        public int QuestionCategory { get; set; }

        [Display(Name = "Question Attachments")]
        public List<Attachment> Attachments { get; set; }


        [Display(Name = "Post Date")]
        public DateTime PostDate { get; set; }


        //[Display(Name = "Modify Date")]
        //public DateTime ModifyDate { get; set; }
        

        [Display(Name = "Question")]
        public string QuestionText { get; set; }

        [Display(Name = "Answer Count")]
        public int AnswerCount { get; set; }

        [Display(Name = "Answered Time")]
        public DateTime LatestTime { get; set; }


    }
}

