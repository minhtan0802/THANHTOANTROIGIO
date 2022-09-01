namespace THANHTOANTROIGIO.Helpers
{
    public class StringHelper
    {
        public String ChuanHoa(String strInput, String type="")
        {
            string strResult = "";
            strInput = strInput.Trim().ToLower();
            while (strInput.Contains("  "))
                strInput = strInput.Replace("  ", " ");

            string[] arrResult = strInput.Split(' ');

            foreach (string item in arrResult)
            {

                if (item.Length == 1)
                {
                    strResult += item.Substring(0, 1).ToUpper() + " ";
                }
                else
                {
                    strResult += item.Substring(0, 1).ToUpper() + item.Substring(1) + " ";
                }
            }
            if (type == "")
            {
                return strResult.TrimEnd();
            }
            if(type=="up")
            {
                return strResult.TrimEnd().ToUpper();
            }  
            return strResult.TrimEnd();
            
        }
    }
}
