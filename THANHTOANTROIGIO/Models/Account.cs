namespace THANHTOANTROIGIO.Models
{
    public class Account
    {
        public String username { get; set; }
        public String password { get; set; }
        public String MaGV { get; set; }
        public String TenGV { get; set; }

        public Account(string username, string password, string maGV, string tenGV)
        {
            this.username = username;
            this.password = password;
            MaGV = maGV;
            TenGV = tenGV;
        }
        public Account()
        {

        }
    }
}
