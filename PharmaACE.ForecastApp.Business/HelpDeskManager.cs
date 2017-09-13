using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PharmaACE.ForecastApp.Business
{
    public class HelpDeskManager
    {
        public bool SendMailHelpDesk(List<string> fileNames, List<byte[]> fileBytes, string issue, string issueDesc, string loginEmail, string toEmail)
        {
            StringBuilder sbEmailBody = new StringBuilder();
            sbEmailBody.Append("<br/>");
            sbEmailBody.Append("Hello, <br/><br/>");
            sbEmailBody.Append(" Following Issue from " + loginEmail + " has been submitted:");
            sbEmailBody.Append("<br/><br/>");
            sbEmailBody.Append("<b>Issue</b>: " + issue);
            sbEmailBody.Append("<br/>");
            sbEmailBody.Append("<b>Issue Description</b>: " + issueDesc.Replace("\n", "<br/>"));
            sbEmailBody.Append("<br/><br/>");
            sbEmailBody.Append("<b>Regards,</b>");
            sbEmailBody.Append("<br/>");
            sbEmailBody.Append("<b>"+ GenUtil.GetClientNameForSendingMail()+"</b>");
            return GenUtil.SendEmail("Issue From User", sbEmailBody.ToString(), toEmail, fileNames, fileBytes);
        }
    }
}
