using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace PharmaACE.ForecastApp.Models
{
    public class NewsFeedItem
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int UserID { get; set; }
        public int DivOrder { get; set; } //sequence of the company division, e.g. for Mallinkrodth, Generic division's sequence is 1, Home is 0.
        public string Setting { get; set; }
        public string Source { get; set; }
        public double Rating { get; set; }
        public int NoOfViews { get; set; }
        public string Link { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Thumbnail { get; set; }
        public string TimeStamp { get; set; }
        public string Comment { get; set; }
    }

    public class NewsFeedItems
    {
        public List<NewsFeedItem> Items { get; set; }
    } 
}