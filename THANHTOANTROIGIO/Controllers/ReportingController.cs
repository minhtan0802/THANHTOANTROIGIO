using DevExpress.AspNetCore.Reporting.WebDocumentViewer;
using DevExpress.AspNetCore.Reporting.WebDocumentViewer.Native.Services;
using Microsoft.AspNetCore.Mvc;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Controllers
{
    [AuthorizeUser]
    public class CustomWebDocumentViewerController : WebDocumentViewerController
    {
        public CustomWebDocumentViewerController(IWebDocumentViewerMvcControllerService controllerService)
            : base(controllerService)
        {
        }
    }
}
