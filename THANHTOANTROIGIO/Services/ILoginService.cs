using THANHTOANTROIGIO.Models;
using THANHTOANTROIGIO.Models.Cache;

namespace THANHTOANTROIGIO.Services
{
    public interface ILoginService
    {
        public Account Login(String username, String password, string connectionString);
    }
}
