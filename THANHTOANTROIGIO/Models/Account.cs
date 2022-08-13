namespace THANHTOANTROIGIO.Models
{
    public class Account
    {
        public int id { get; set; }
        public String username { get; set; }
        public String password { get; set; }
        public GiangVien user { get; set; }

        public Account(int id, string username, string password, GiangVien user)
        {
            this.id = id;
            this.username = username;
            this.password = password;
            this.user = user;
        }

        public Account()
        {

        }
    }
}
