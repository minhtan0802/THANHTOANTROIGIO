using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using THANHTOANTROIGIO.Helpers;
using THANHTOANTROIGIO.Models;
using Microsoft.Data.SqlClient;

namespace THANHTOANTROIGIO.DAO
{
    public class GiangVienDAO
    {
        public static DataTable getListGiangVien(String maBoMon)
        {
            List<SqlParameter> param= new List<SqlParameter>();
            param.Add(new SqlParameter("@maBoMon", maBoMon));
            var data = new SQLHelper().ExecuteQuery("get_DS_GV", param);
            return data;
        }
        public static string getLoaiGVByMaGV(string maGiangVien)
        {
            ThayDoiLoaiGV loaiGV = new ThayDoiLoaiGV();

            using (var ctx = new ThanhToanTroiGioEntities())
            {
                var ngayThayDoi = ctx.ThayDoiLoaiGVs.Where(s => s.MaGV.Equals(maGiangVien)).Max(o => o.NgayThayDoi);
                loaiGV = (ThayDoiLoaiGV)ctx.ThayDoiLoaiGVs
                              .Where(s => s.MaGV.Equals(maGiangVien.Trim()) && s.NgayThayDoi == ngayThayDoi).FirstOrDefault();
            }
            if (loaiGV.MaLoaiGV == "0")
            {
                return "false";
            }
            else
            {
                return "true";
            }
        }

        public static string getChucDanhByMaGV(string maGiangVien)
        {
            /* GiangVien gv = new GiangVien();

             using (var ctx = new ThanhToanTroiGioEntities())
             {
                 gv = (GiangVien)ctx.GiangViens
                               .Where(s => s.MaGiangVien.Equals(maGiangVien.Trim())).FirstOrDefault();
             }
             return gv.ChucDanh.Trim();*/
            var x = new SQLHelper().ExecuteString("SELECT ChucDanh From GiangVien Where MaGiangVien='" + maGiangVien + "'");
            return x.Rows[0][0].ToString();
        }
        public static IEnumerable<Object> getDSGVByBoMon(string maKhoa)
        {
            List<BoMon> listBoMon = new List<BoMon>();
            List<GiangVien> listGV = new List<GiangVien>();
            GiangVienTree gvTree = new GiangVienTree();
            List<GiangVienTree> listGVTree = new List<GiangVienTree>();
            List<Tree_GV> listTreeGV = new List<Tree_GV>();
            Tree_GV treeGV = new Tree_GV();

            using (var context = new ThanhToanTroiGioEntities())
            {
                listBoMon = context.BoMons.Where(x => x.MaKhoa == maKhoa).OrderBy(x => x.TenBoMon).ToList();
                listGV = context.GiangViens.Where(g=>g.TrangThaiXoa==false).OrderBy(x =>x.Ten).ToList();
                for (int i = 0; i < listBoMon.Count; i++)
                {
                    listGVTree=new List<GiangVienTree>();
                   
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
}