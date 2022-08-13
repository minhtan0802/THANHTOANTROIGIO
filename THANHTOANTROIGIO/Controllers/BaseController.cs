using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Primitives;
using THANHTOANTROIGIO.Models.Cache;
using THANHTOANTROIGIO.Services;
namespace THANHTOANTROIGIO.Controllers
{
    public class BaseController : Controller
    {
        private readonly IHttpContextAccessor _httpContextAccessor;
        protected readonly AuthService _authService;

        public BaseController(IHttpContextAccessor httpContextAccessor, AuthService authService)
        {
            this._authService = authService;
            _httpContextAccessor= httpContextAccessor;
        }

        protected AuthUserCache AuthUserCache
        {
            get
            {
                string authHeader = HttpContext.Request.Headers["Authorization"];
                authHeader = authHeader.Replace("Bearer", "").Trim();
                return _authService.GetCurrentAuthUser(authHeader);
            }
        }
    }
}