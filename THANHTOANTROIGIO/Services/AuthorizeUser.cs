using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using THANHTOANTROIGIO.Controllers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class AuthorizeUser:ActionFilterAttribute
    {
        public override void OnActionExecuted(ActionExecutedContext context)
        {

            if (string.IsNullOrEmpty(AccountController.session))
            {
          
                Error.isLogin = -1;
                var result = new ViewResult();
                result.ViewName = "~/Views/Account/Error.cshtml";
                context.Result = result;

            }
/*            base.OnActionExecuted(context);*/
        }
    }
}
