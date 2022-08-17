using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO
{
    public class ThanhToanTroiGioEntities : DbContext
    {
        public ThanhToanTroiGioEntities(DbContextOptions<ThanhToanTroiGioEntities> options) : base(options)
        {

        }
        public static String connectionString;
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
        public DbSet<MonHoc>? MonHocs { get; set; }
        public DbSet<BacHoc>? BacHocs { get; set; }
        public DbSet<ThayDoiHSBac>? ThayDoiHSBacs { get; set; }
        public DbSet<LopTinChi>? LopTinChis { get; set; }
        public DbSet<HeLop>? HeLops { get; set; }
        public DbSet<ThayDoiHSHeLop>? ThayDoiHSHeLops { get; set; }
        public DbSet<LopDongLyThuyet>? LopDongLyThuyets { get; set; }
        public DbSet<LopDongThucHanh>? LopDongThucHanhs { get; set; }
        public DbSet<HuongDanTTTN>? HuongDanTTTNs { get; set; }
        public DbSet<DinhMucGiang>? DinhMucGiangs { get; set; }
        public DbSet<NguoiKy>? NguoiKys { get; set; }
        public DbSet<ThayDoiGiaHocVi>? ThayDoiGiaHocVis { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            /* IConfigurationRoot configuration = new ConfigurationBuilder()
                 .SetBasePath(AppDomain.CurrentDomain.BaseDirectory)
                 .AddJsonFile("appsettings.json")
                 .Build();
             optionsBuilder.UseSqlServer(configuration.GetConnectionString("DefaultConnection"));
             connectionString = configuration.GetConnectionString("DefaultConnection");*/
            base.OnConfiguring(optionsBuilder);
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
            modelBuilder.Entity<ThayDoiHSBac>().HasKey(c => new { c.MaBac, c.MaGVDieuChinh, c.NgayApDung });
            modelBuilder.Entity<ThayDoiHSHeLop>().HasKey(c => new { c.MaHeLop, c.MaGVDieuChinh, c.NgayApDung });
            modelBuilder.Entity<LopDongLyThuyet>().HasKey(c => new { c.MaKhoa, c.NgayApDung });
            modelBuilder.Entity<LopDongThucHanh>().HasKey(c => new { c.MaKhoa, c.NgayApDung });
            modelBuilder.Entity<HuongDanTTTN>().HasKey(c => new { c.MaGV, c.MaNKHK, c.Lop });
            modelBuilder.Entity<DinhMucGiang>().HasKey(c => new { c.MaGV, c.MaNKHK });
            modelBuilder.Entity<ThayDoiGiaHocVi>().HasKey(c => new { c.MaHocVi, c.MaNKHK });
        }
    }
}
