using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public interface AccountService
    {
        public Account Login(String username, String password);
    }
}
