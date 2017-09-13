using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{
    public class Notification
    {
        public int UserId { get; set; }
        public int NotificationId { get; set; }
        public string Description { get; set; }
        public DateTime CreatedDate { get; set; }
        public bool IsRead { get; set; }
    }
    public class NotificationCount
    {
        public List<Notification> Notifications { get; set; }
        public int Notificationcount { get; set; }
    }
}
