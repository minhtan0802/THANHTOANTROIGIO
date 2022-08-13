using System.Net;
using THANHTOANTROIGIO.Services;

namespace THANHTOANTROIGIO.Middlewares
{
    public class AuthMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger _logger;

        public AuthMiddleware(RequestDelegate next, ILogger<AuthMiddleware> logger)
        {
            this._next = next;
            this._logger = logger;
        }

        /*public async Task Invoke(HttpContext context, AuthService authService)
        {
            //Reading the Authorization Header which is signed with JWT
            string authHeader = context.Request.Headers["Authorization"];
            string auth=context.Session.GetString(
            if (authHeader != null)
            {
                authHeader = authHeader.Replace("Bearer", "").Trim();
                try
                {
                    var user = authService.GetCurrentAuthUser(authHeader);
                    if (user == null)
                    {
                        _logger.LogError(message: $"Cannot parse jwt authorization header: {authHeader}");
                        context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                        return;
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError(message: $"Cannot parse jwt authorization header: {authHeader}", exception: ex);
                    context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                    return;
                }
            }

            await _next(context);
        }*/
        public async Task Invoke(HttpContext context, AuthService authService)
        {
            //Reading the Authorization Header which is signed with JWT
                string authHeader = context.Request.Headers["Authorization"];
       /*     string authHeader = context.Session.GetString("user");*/
            if (authHeader != null)
            {
                authHeader = authHeader.Replace("Bearer", "").Trim();
                try
                {
                    var user = authService.GetCurrentAuthUser(authHeader);
                    if (user == null)
                    {
                        _logger.LogError(message: $"Cannot parse jwt authorization header: {authHeader}");
                        context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                        return;
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError(message: $"Cannot parse jwt authorization header: {authHeader}", exception: ex);
                    context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                    return;
                }
            }

            await _next(context);
        }
    }
}
