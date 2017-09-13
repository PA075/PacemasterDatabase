using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Models
{

    public class CommonSendInfo
    {
        public string SenderName { get; set; }
        public string SenderEmail { get; set; }
        public string ClientName { get; set; }
        public string ProjectName { get; set; }
        public bool IsShare { get; set; }
        public string ForecastVersion { get; set; }
        public string ModuleType { get; set; }
        public string PathString { get; set; }
    }

    public class SendMailInfo
    {
        
        public string ReceiverName { get; set; }
        public string ReceiverEmail { get; set; }
        public string Subject { get; set; }
        public StringBuilder sbEmailBody { get; set; }
        public bool FlagForSendMail { get; set; }
        public bool FlagForPermission { get; set; }
        public string Permission { get; set; }
        public string PrevPermission { get; set; }
        public string PrevAuth { get; set; }
        public string CurrentAuth { get; set; }
        public bool FlagForUpdation { get; set; }

    }

    public class SendMailUserInfo
    {
        public List<SendMailInfo> SendMailInfoValue { get; set; }
        public CommonSendInfo CommonSendInfoValue { get; set; }
        public int ResultUW { get; set; }
    }
}
