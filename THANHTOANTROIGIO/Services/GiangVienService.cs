using Microsoft.Data.SqlClient;
using System.Data;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;

namespace THANHTOANTROIGIO.Services
{
    public class GiangVienService
    {
        private ThanhToanTroiGioEntities _context;
        public GiangVienService(ThanhToanTroiGioEntities context)
        {
            _context = context;
        }
        public DataTable getListGiangVien(String maBoMon, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@maBoMon", maBoMon));
            var data = new SQLHelper(connectionString).ExecuteQuery("get_DS_GV", param);
            return data;
        }
        public DataTable getListGiangVienByKhoa(String maKhoa, String connectionString)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@MaKhoa", maKhoa));
            var data = new SQLHelper(connectionString).ExecuteQuery("sp_Get_GV_Khoa", param);
            return data;
        }
        public string getLoaiGVByMaGV(string maGiangVien)
        {
            ThayDoiLoaiGV loaiGV = new ThayDoiLoaiGV();


            var ngayThayDoi = _context.ThayDoiLoaiGVs.Where(s => s.MaGV.Equals(maGiangVien)).Max(o => o.NgayThayDoi);
            loaiGV = (ThayDoiLoaiGV)_context.ThayDoiLoaiGVs
                          .Where(s => s.MaGV.Equals(maGiangVien.Trim()) && s.NgayThayDoi == ngayThayDoi).FirstOrDefault();

            if (loaiGV.MaLoaiGV == "0")
            {
                return "false";
            }
            else
            {
                return "true";
            }
        }

        public string getChucDanhByMaGV(string maGiangVien, String connectionString)
        {
            var x = new SQLHelper(connectionString).ExecuteString("SELECT ChucDanh From GiangVien Where MaGiangVien='" + maGiangVien + "'");
            return x.Rows[0][0].ToString();
        }
        public IEnumerable<Object> getDSGVByBoMon(string maKhoa)
        {
            List<BoMon> listBoMon = new List<BoMon>();
            List<GiangVien> listGV = new List<GiangVien>();
            GiangVienTree gvTree = new GiangVienTree();
            List<GiangVienTree> listGVTree = new List<GiangVienTree>();
            List<Tree_GV> listTreeGV = new List<Tree_GV>();
            Tree_GV treeGV = new Tree_GV();
            listBoMon = _context.BoMons.Where(x => x.MaKhoa == maKhoa).OrderBy(x => x.TenBoMon).ToList();
            listGV = _context.GiangViens.Where(g => g.TrangThaiXoa == false).OrderBy(x => x.Ten).ToList();
            for (int i = 0; i < listBoMon.Count; i++)
            {
                listGVTree = new List<GiangVienTree>();

                treeGV = new Tree_GV();
                for (int j = 0; j < listGV.Count; j++)
                {
                    if (listGV[j].MaBoMon == listBoMon[i].MaBoMon)
                    {
                        gvTree = new GiangVienTree();
                        gvTree.text = listGV[j].Ho + " " + listGV[j].Ten;
                        gvTree.id = listGV[j].MaGiangVien;
                        listGVTree.Add(gvTree);
                        listGV.RemoveAt(j);
                    }
                }
                treeGV.text = listBoMon[i].TenBoMon;
                treeGV.id = listBoMon[i].MaBoMon;
                treeGV.nodes = listGVTree;
                listTreeGV.Add(treeGV);
            }
            return listTreeGV;
        }
    }
}
