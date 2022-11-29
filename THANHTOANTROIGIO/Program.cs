using DevExpress.AspNetCore;
using Microsoft.EntityFrameworkCore;
using System.Configuration;
using Microsoft.Extensions.Caching.Distributed;
using THANHTOANTROIGIO;
using Autofac.Extensions.DependencyInjection;
using THANHTOANTROIGIO.Services;
using THANHTOANTROIGIO.Models;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using THANHTOANTROIGIO.Middlewares;

var builder = WebApplication.CreateBuilder(args);
// Add services to the container.
builder.Services.AddDevExpressControls();
builder.Services.AddControllersWithViews();
builder.Services.AddSession();
builder.Services.AddScoped<ILoginService, LoginService>();
builder.Services.AddScoped<ThanhToanTroiGioEntities, ThanhToanTroiGioEntities>();
builder.Services.AddScoped<DinhMucGiangService, DinhMucGiangService>();
builder.Services.AddScoped<DinhMucNCKHService, DinhMucNCKHService>();
builder.Services.AddScoped<NguoiKyService, NguoiKyService>();
builder.Services.AddScoped<ThucHienNCKHService, ThucHienNCKHService>();
builder.Services.AddScoped<KhoaService, KhoaService>();
builder.Services.AddScoped<NienKhoaHocKyService, NienKhoaHocKyService>();
builder.Services.AddScoped<BacHocService, BacHocService>();
builder.Services.AddScoped<BoMonService, BoMonService>();
builder.Services.AddScoped<ChucVuService, ChucVuService>();
builder.Services.AddScoped<GiangVienService, GiangVienService>();
builder.Services.AddScoped<HeLopService, HeLopService>();
builder.Services.AddScoped<HocViService, HocViService>();
builder.Services.AddScoped<LopDongLyThuyetService, LopDongLyThuyetService>();
builder.Services.AddScoped<LopDongThucHanhService, LopDongThucHanhService>();
builder.Services.AddScoped<LopTinChiService, LopTinChiService>();
builder.Services.AddScoped<MonHocService, MonHocService>();
builder.Services.AddScoped<ThucTapTotNghiepService, ThucTapTotNghiepService>();
builder.Services.AddScoped<ReportService, ReportService>();
builder.Services.AddScoped<AuthService, AuthService>();


var authSettingsSection = builder.Configuration.GetSection("AuthSettings");
builder.Services.Configure<AuthSettings>(authSettingsSection);
var appSettings = authSettingsSection.Get<AuthSettings>();
var key = Encoding.ASCII.GetBytes(appSettings.AuthSecret);
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
            .AddJwtBearer(x =>
            {
                x.RequireHttpsMetadata = false;
                x.SaveToken = true;
                x.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = false,
                    ValidateAudience = false
                };
            });

var redisSettings = builder.Configuration.GetSection("RedisSettings").Get<RedisSettings>();
builder.Services.AddDistributedRedisCache(option =>
{
    option.Configuration = redisSettings.Host + ":" + redisSettings.Port + ",connectTimeout=10000,syncTimeout=10000";
});
builder.Services.AddDbContext<ThanhToanTroiGioEntities>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
var app = builder.Build();
app.UseSession();
app.UseDevExpressControls();
// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
app.UseStaticFiles();
app.UseHttpsRedirection();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
/*app.UseMiddleware<AuthMiddleware>();*/
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");
app.Run();
