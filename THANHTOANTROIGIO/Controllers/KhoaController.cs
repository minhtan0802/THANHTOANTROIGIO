using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("khoa")]
    [AuthorizeUser]
    public class KhoaController :Controller
    {
        private readonly KhoaService _khoaService;
        private readonly IConfiguration _iconfiguration;    
        public KhoaController(KhoaService khoaService, IConfiguration iconfiguration, AuthService authService)
        {
            _khoaService = khoaService;
            _iconfiguration = iconfiguration;
        }
        [Authorize]
        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        [Route("ds-khoa")]
        public JsonResult AjaxMethod_Khoa()
        {
            var data = _khoaService.getListKhoa();
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
