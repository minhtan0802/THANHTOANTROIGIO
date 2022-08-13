using System;
namespace THANHTOANTROIGIO.Models.Cache
{
    public class AuthUserCache
    {
        public int id { get; set; }
        public string MaGiangVien { get; set; }
        public string Name { get; set; }
        public int RoleType { get; set; }
        public string RoleDesc { get; set; }

        public AuthUserCache() { }

        public AuthUserCache(GiangVien user, int id)
        {
            this.MaGiangVien = user.MaGiangVien;
            this.id = id;
            this.Name = user.Ho+" "+user.Ten;
            this.RoleType = 1;
            this.RoleDesc = "Admin";
        }
    }
}