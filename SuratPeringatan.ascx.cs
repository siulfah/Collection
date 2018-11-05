namespace Collection.Controls
{
    using System;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using DMS.Tools;
    using DMS.Framework;
    using System.IO;
    using Collection.Framework;
    /// <summary>
    ///		Summary description for Letter.
    /// </summary>
    public partial class SuratPeringatan : MasterUserControl
    {
        string ACC, CUST, ActionID;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            ACC = Request.QueryString["ACC"];
            CUST = Request.QueryString["CUST"];
            ActionID = Request.QueryString["ActionID"];
            if (!IsPostBack)
            {
                initDropDown(Request.QueryString["FUNC"]);
            }
            BTN_SAVE.Attributes.Add("onclick", "if(!cek_mandatory(document.Form1)){return false;}");
            btnHistory.Attributes.Add("onclick", "PopupPage('../History/History.aspx?ActionID=" + ActionID + "&ACC=" + ACC + "&CUST=" + CUST + "',null,400);");
        }

        protected void BTN_HISTORY_Click(object sender, System.EventArgs e)
        {
            Response.Redirect("../History/History.aspx?FUNC=" + Request.QueryString["FUNC"] +
                "&ACC=" + ACC + "&CUST=" + CUST);
        }

        protected void BTN_SAVE_Click(object sender, System.EventArgs e)
        {
            saveData();
        }

        protected void BTN_Gen_Click(object sender, System.EventArgs e)
        {
            GenLetterDocX("737ED75F-6838-4606-A00B-6F0F4B4E75F8");
        }
        private void GenLetterDocX(string bulkID)
        {
            string templatePath = Server.MapPath("~") + "\\Files\\Template\\Letter\\";
            string targetFileName = "";
            DataTable dtList = new DataTable();
            dtList.Columns.Add("BulkID");
            dtList.Columns.Add("AccNo");
            dtList.Columns.Add("TemplateID");
            //divMessage.InnerHtml = "";

            System.Collections.Generic.List<object> listGen;
            if (bulkID == null || bulkID.Trim() == "")
            {
                bulkID = Guid.NewGuid().ToString();
                //listGen = DGR_BULK_GEN.GetSelectedFieldValues(new string[] { DGR_BULK_GEN.KeyFieldName, "Kode Jenis Surat" });
                //foreach (object[] lst in listGen)
                //{
                //    dtList.Rows.Add(new object[]{
                //            bulkID,
                //            lst[0].ToString(),
                //            lst[1].ToString()}
                //        );
                //}
                targetFileName = Server.MapPath("~") + "Files\\Generated\\Letter\\" + USERID + "_" + DateTime.Today.ToString("yyyyMMdd") + ".docx";
            }
            else
            {
                DataTable dt = conn.GetDataTable("EXEC dbo.usp_ViewBulkLetterRegen @1",
                    new object[] { bulkID }, dbtimeout);
                //if (dt.Rows.Count == 0)
                //{
                //    divMessage.InnerHtml = "Tidak ada data untuk di Regenerate";
                //}
                foreach (DataRow dr in dt.Rows)
                {
                    dtList.Rows.Add(new object[]{
                            bulkID,
                            dr["AccNo"].ToString(),
                            dr["SU_TYPE"].ToString()}
                        );

                }
                targetFileName = Server.MapPath("~") + "\\Files\\Generated\\Letter\\" + dt.Rows[0]["BulkFile"].ToString();
                if (File.Exists(targetFileName))
                    File.Delete(targetFileName);
            }

            MailMerger mm = new MailMerger();
            mm.conn = conn;
            mm.dbtimeout = dbtimeout;
            mm.ReceiptTemplateFile = templatePath + "letter_Receipt.dotx";
            mm.UserID = USERID;
            mm.MailMergeToSingleFile(dtList, templatePath, targetFileName);


            //foreach (string s in mm.ErrorList)
            //{
            //    divMessage.InnerHtml += s + "<br />";
            //}
            //divMessage.Style["color"] = "red";
            dtList.Dispose();

        }

        protected void initDropDown(string function)
        {
            staticFramework.reff(DDL_LETTER_TYPE, "EXEC dbo.usp_GetSPType @1",
                new object[1] { ACC }, conn);
        }


        protected void saveData()
        {
            string filename = "DDL_LETTER_TYPE.SelectedValue_" + USERID + "_" + DateTime.Today.ToString("yyyyMMdd") + ".docx";
            GenLetterDocXext(null);
            conn.ExecNonQuery("EXEC SP_SAVE_SP @1,@2,@3,@4,@5,@6,@7,@8",
                new object[] { ACC, DDL_LETTER_TYPE.SelectedValue, TXT_NOTES.Text, USERID, TxtNoSurat.Text, TxtDivisi.Text, TxtTembusan.Text, filename }, dbtimeout);

            string strClientScript = "if(parent.window.opener.window.ViewData) {" +
                                    " parent.window.opener.window.ViewData(); " +
                                    "}";
            strClientScript += "if (parent.window.document.getElementById('IFR_ISI')!=undefined){ " +
                                    "parent.window.document.getElementById('IFR_ISI').src='';}";
            Response.Write(@"<script type=""text/javascript"">" + strClientScript + "</script>");

        }

        private void GenLetterDocXext(string bulkID)
        {
            string templatePath = Server.MapPath("~") + "Files\\Template\\Letter\\";
            string targetFileName = "";
            DataTable dtList = new DataTable();
            dtList.Columns.Add("BulkID");
            dtList.Columns.Add("AccNo");
            dtList.Columns.Add("TemplateID");
            divMessage.InnerHtml = "";

            //System.Collections.Generic.List<object> listGen;
            if (bulkID == null || bulkID.Trim() == "")
            {
                bulkID = Guid.NewGuid().ToString();
                //listGen = DGR_BULK_GEN.GetSelectedFieldValues(new string[] { DGR_BULK_GEN.KeyFieldName, "Kode Jenis Surat" });
                //foreach (object[] lst in listGen)
                //{
                //TEMPLATE ID diganti berdasarkan pilihan tipe surat
                    dtList.Rows.Add(new object[]{
                            bulkID,
                           ACC.ToString(),
                           //"surat_SP1"}
                           DDL_LETTER_TYPE.SelectedValue}
                        );
                //}
                    targetFileName = Server.MapPath("~") + "Files\\Generated\\Letter\\" + "DDL_LETTER_TYPE.SelectedValue_" + USERID + "_" + DateTime.Today.ToString("yyyyMMdd") + ".docx";
                    //targetFileName = Server.MapPath("~") + "Files\\Generated\\Letter\\" + "surat_SP1_" + USERID + "_" + DateTime.Today.ToString("yyyyMMdd") + ".docx";
            }
            //else
            //{
            //    DataTable dt = conn.GetDataTable("EXEC dbo.usp_ViewBulkLetterRegen @1",
            //        new object[] { bulkID }, dbtimeout);
            //    if (dt.Rows.Count == 0)
            //    {
            //        divMessage.InnerHtml = "Tidak ada data untuk di Regenerate";
            //    }
            //    foreach (DataRow dr in dt.Rows)
            //    {
            //        dtList.Rows.Add(new object[]{
            //                bulkID,
            //                dr["AccNo"].ToString(),
            //                dr["SU_TYPE"].ToString()}
            //            );

            //    }
            //    targetFileName = Server.MapPath("~") + "Files\\Generated\\Letter\\" + "surat_SP1_"  + dt.Rows[0]["BulkFile"].ToString();
            //    if (File.Exists(targetFileName))
            //        File.Delete(targetFileName);
            //}

            MailMerger mm = new MailMerger();
            mm.conn = conn;
            mm.dbtimeout = dbtimeout;
            mm.ReceiptTemplateFile = templatePath + "letter_Receipt.dotx";
            mm.UserID = USERID;
            mm.MailMergeToSingleFile(dtList, templatePath, targetFileName);


            foreach (string s in mm.ErrorList)
            {
                divMessage.InnerHtml += s + "<br />";
            }
            divMessage.Style["color"] = "red";
            dtList.Dispose();

        }
    }
}
