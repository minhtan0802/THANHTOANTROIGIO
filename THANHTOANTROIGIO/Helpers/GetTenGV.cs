namespace THANHTOANTROIGIO.Helpers
{
    public class GetTenGV
    {
        public String getTenGV(String HoTenGV)
        {
            var array = HoTenGV.Split(' ');
            var TenGV = array[array.Length - 1].Trim();
            var HoGV = "";
            for (int i = 1; i < array.Length-1; i++)
            {
                HoGV += array[i] + " ";
            }
            HoGV = HoGV.Trim();
            var tenGV = HoGV + "." + TenGV;
            return tenGV;

        }
    }
}
