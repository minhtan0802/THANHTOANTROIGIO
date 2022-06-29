﻿using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using THANHTOANTROIGIO.DAO;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Controllers
{
    [Route("mon-hoc")]
    public class MonHocController : Controller
    {
        [Route("")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("ds-mon-hoc")]
        [HttpPost]
        public JsonResult getDSMonHoc()
        {
            var data = MonHocDAO.getDSMonHoc();
            return Json(JsonConvert.SerializeObject(data));
        }
        [Route("by-ma-mon")]
        [HttpPost]
        public JsonResult getDSMonHocByMaMon(MonHoc model)
        {
            var data = MonHocDAO.getMonHoc(model.MaMonHoc.Trim());
            return Json(JsonConvert.SerializeObject(data));
        }
    }
}
