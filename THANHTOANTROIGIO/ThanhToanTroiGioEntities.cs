using Microsoft.EntityFrameworkCore;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO
{
    public class ThanhToanTroiGioEntities : DbContext
    {
        public DbSet<GiangVien>? GiangViens { get; set; }
        public DbSet<BoMon>? BoMons { get; set; }
        public DbSet<ChucVu>? ChucVus { get; set; }
        public DbSet<HocVi>? HocVis { get; set; }
        public DbSet<Khoa>? Khoas { get; set; }
        public DbSet<LoaiGiangVien>? LoaiGiangViens { get; set; }
        public DbSet<ThayDoiBoMon>? ThayDoiBoMons { get; set; }
        public DbSet<ThayDoiChucVu>? ThayDoiChucVus { get; set; }
        public DbSet<ThayDoiHocVi>? ThayDoiHocVis { get; set; }
        public DbSet<ThayDoiLoaiGV>? ThayDoiLoaiGVs { get; set; }
        public DbSet<NienKhoaHocKy>? NienKhoaHocKys { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            IConfigurationRoot configuration = new ConfigurationBuilder()
                .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                .AddJsonFile("appsettings.json")
                .Build();
            optionsBuilder.UseSqlServer(configuration.GetConnectionString("DefaultConnection"));
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ThayDoiBoMon>()
                .HasKey(c => new { c.MaGV, c.MaBoMon, c.NgayThayDoi });
            modelBuilder.Entity<ThayDoiChucVu>()
               .HasKey(c => new { c.MaGV, c.MaChucVu, c.NgayThayDoi });
            modelBuilder.Entity<ThayDoiHocVi>()
               .HasKey(c => new { c.MaGV, c.MaHocVi });
            modelBuilder.Entity<ThayDoiLoaiGV>().HasKey(c => new { c.MaGV, c.MaLoaiGV, c.NgayThayDoi });
        }
    }
}
