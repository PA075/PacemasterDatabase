using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PharmaACE.ForecastApp.Models;
namespace PharmaACE.ForecastApp.Controllers
{
    public class UserLoginController : Controller
    {
        //
        // GET: /UserLogin/
        public JsonResult Index(string email, string passowrd)
        {
            string msg = null;
            var model = new Login();
            model.Email = email;
            model.Password = passowrd;
            if (String.IsNullOrEmpty(msg))
                return Json(new { success = true });
            else
                return Json(new { success = false, errors = new[] { msg } });
        }
    }
}
