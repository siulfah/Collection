using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using DMS.Tools;
using DMS.Framework;
using Collection.Framework;
using System.IO;

namespace Collection.Controls
{
    public partial class Visit : MasterUserControl
    {
        Func_Button BTN;
        object[] OBJ_PARAM;
        //Label LBL, LBL_RESULT, LBL_NEXTACTION;
        string AccNo, CustID, ActionID, BulkId;
        protected void Page_Load(object sender, System.EventArgs e)
        {

            AccNo = Request.QueryString["ACC"];
            CustID = Request.QueryString["CUST"];
            ActionID = Request.QueryString["ActionID"];
            BulkId = Request.QueryString["BulkId"];
            RELATIONSHIP.conn = conn;
            RELATIONSHIP.QueryString = "SELECT REL_ID, REL_DESC FROM RFRELATIONSHIP where visit=1";
            RELATIONSHIP.JavaScript = RESULT.JSCallback();
            RELATIONSHIP.FillDDL();

            RESULT.conn = conn;
            RESULT.QueryString = "EXEC usp_GetResultList @1, @2";
            RESULT.QueryParam = new object[] { ActionID, RELATIONSHIP };
            RESULT.JavaScript = "ResultChange(document.getElementById('" + RESULT.DDL.ClientID + "').value);";

            BTN = new Func_Button();
            if (!IsPostBack)
                initDropDown();


            btnHistory.Attributes.Add("onclick", "PopupPage('../History/History.aspx?ActionID=" + ActionID + "&ACC=" + AccNo + "&CUST=" + CustID + "',null,600);");

            DDL_CUST_ADDR.Attributes.Add("onchange", "addr_change();");
            DDL_NEXTACTION.Attributes.Add("onchange", "next_change();");
            UploadUserControl1.UploadDirectory = "Upload/Temp/";
            UploadUserControl1.NewID = AccNo + "_" + USERID + "_VISIT";
            //UploadUserControl1.UploadControl.ClientSideEvents.FilesUploadComplete = "FilesUploadComplete";
            //UploadUserControl1.UploadControl.ShowUploadButton = false;


            DataTable dt;
            dt = conn.GetDataTable("exec SP_FileUploadVisit @1", new object[1] { AccNo }, dbtimeout);
            staticFramework.GridBind(FileUploadList, dt);

            //DataTable dtPurpose = conn.GetDataTable("exec usp_GetDatapurpose @1", new object[] { AccNo }, dbtimeout);
            //if (dtPurpose != null)
            //{
            //    DDL_TUJUAN.SelectedValue = "Pemasangan Plakat Dilelang";
            //}
        }

        //protected void btn_GenLetter_Click(object sender, System.EventArgs e)
        //{
        //    GenLetterDocX(Request.QueryString["ACC"]);
        //    //GenLetterDocX();
        //    //GenLetterDocX("737ED75F-6838-4606-A00B-6F0F4B4E75F8");

        //}
        //private void GenLetterDocX(string accno)
        //{
        //    string bulkID = "";

        //    string templatePath = Server.MapPath("~") + "\\Files\\Template\\Letter\\";
        //    string targetFileName = "";
        //    DataTable dtList = new DataTable();
        //    dtList.Columns.Add("BulkID");
        //    dtList.Columns.Add("AccNo");
        //    dtList.Columns.Add("TemplateID");

        //    System.Collections.Generic.List<object> listGen;
        //    if (bulkID.ToString() == null || bulkID.Trim() == "")
        //    {
        //        bulkID = Guid.NewGuid().ToString();
        //        targetFileName = Server.MapPath("~") + "\\Files\\Generated\\Letter\\" + USERID + "_" + DateTime.Today.ToString("yyyyMMdd") + ".docx";

        //        try
        //        {
        //            conn.ExecNonQuery("EXEC dbo.usp_LetterBulkStart @1, @2",
        //                new object[] { bulkID, System.IO.Path.GetFileName(targetFileName) }, dbtimeout);
        //        }
        //        catch (Exception exp)
        //        {
        //            return;
        //        }

        //        DataTable dt = conn.GetDataTable("EXEC dbo.usp_ViewBulkLetterRegen @1",
        //            new object[] { bulkID }, dbtimeout);
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //        dtList.Rows.Add(new object[]{
        //                    bulkID,
        //                    accno.ToString(),
        //                    dr["SU_TYPE"].ToString()}
        //                );
        //        }

        //    }
        //    else
        //    {
        //        DataTable dt = conn.GetDataTable("EXEC dbo.usp_ViewBulkLetterRegen @1",
        //            new object[] { bulkID }, dbtimeout);
        //        foreach (DataRow dr in dt.Rows)
        //        {
        //            dtList.Rows.Add(new object[]{
        //                    bulkID,
        //                    dr["AccNo"].ToString(),
        //                    dr["SU_TYPE"].ToString()}
        //                );

        //        }
        //        targetFileName = Server.MapPath("~") + "\\Files\\Generated\\Letter\\" + dt.Rows[0]["BulkFile"].ToString();
        //        if (File.Exists(targetFileName))
        //            File.Delete(targetFileName);
        //    }

        //    MailMerger mm = new MailMerger();
        //    mm.conn = conn;
        //    mm.dbtimeout = dbtimeout;
        //    mm.ReceiptTemplateFile = templatePath + "letter_Receipt.dotx";
        //    mm.UserID = USERID;
        //    mm.MailMergeToSingleFile(dtList, templatePath, targetFileName);
        //    dtList.Dispose();
        //}
                    

        protected void BTN_SAVE_VISIT_Click(object sender, System.EventArgs e)
        {
            SaveInputan();
        }

        private void SaveInputan()
        {

            string LBL = null,
                LBL_RESULT = null,
                LBL_NEXTACTION = null;

            try
            {
                DateTime dtVISIT = new DateTime(
                    Convert.ToInt16(txt_YEAR_exp.Text),
                    Convert.ToInt16(ddl_MONTH_exp.SelectedValue),
                    Convert.ToInt16(txt_DAY_exp.Text)
                    );

                //var Bulan = conn.ExecReader("EXEC usp_GetBulan @1", new object[] { Convert.ToInt16(ddl_MONTH_exp.SelectedValue) }, dbtimeout);
                //int month = Convert.ToInt16(Bulan);

                DataTable dtMonth = conn.GetDataTable("EXEC usp_GetBulan", null, dbtimeout);
                if (dtMonth.Rows.Count > 0)
                {
                    string mth = dtMonth.Rows[0]["month"].ToString();

                    if (Convert.ToInt16(mth) > Convert.ToInt16(ddl_MONTH_exp.SelectedValue))
                    {
                        MyPage.popMessage(this.Page, "Bulan Kunjungan tidak boleh kurang dari Bulan saat ini");
                        return;
                    }
                }

                //if (Convert.ToInt16(ddl_MONTH_exp.SelectedValue) != month)
                //{
                //    MyPage.popMessage(this.Page, "Tanggal Kunjungan tidak valid");
                //    return;
                //}
                LBL = dtVISIT.ToString("yyyy/MM/dd");
            }
            catch
            {
                if (txt_DAY_exp.Text != "")
                {
                    MyPage.popMessage(this.Page, "Tanggal Kunjungan tidak valid");
                    return;
                }
            }

            try
            {
                DateTime dtRESULT = new DateTime(
                    Convert.ToInt16(TXT_YEAR_RESULT.Text),
                    Convert.ToInt16(DDL_MONTH_RESULT.SelectedValue),
                    Convert.ToInt16(TXT_DAY_RESULT.Text),
                    Convert.ToInt16(TXT_HOUR_RESULT.Text),
                    Convert.ToInt16(TXT_MIN_RESULT.Text),
                      0);
                conn.ExecReader("EXEC usp_GetActResultMaxDay @1,@2",
                    new object[]{
                        RESULT.DDL.SelectedValue,
                        dtRESULT
                    }, dbtimeout);
                if (conn.hasRow())
                {
                    MyPage.popMessage(this.Page, "Tanggal janji debitur " + RESULT.DDL.SelectedItem.Text + " Tidak boleh lebih dari " + conn.GetFieldValue(0));
                    return;
                }

                LBL_RESULT = dtRESULT.ToString("yyyy/MM/dd HH:mm:ss");
            }
            catch
            {
                if (TXT_DAY_RESULT.Text != "")
                {
                    MyPage.popMessage(this.Page, "Tanggal Janji tidak valid");
                    return;
                }
            }

            try
            {
                DateTime dtNEXTACT = new DateTime(
                    Convert.ToInt16(TXT_YEAR_NA.Text),
                    Convert.ToInt16(DDL_MONTH_NA.SelectedValue),
                    Convert.ToInt16(TXT_DAY_NA.Text),
                    Convert.ToInt16(TXT_HOUR_NA.Text),
                    Convert.ToInt16(TXT_MIN_NA.Text),
                    0);
                LBL_NEXTACTION = dtNEXTACT.ToString("yyyy/MM/dd HH:mm:ss");
            }
            catch
            {
                if (TXT_DAY_NA.Text != "")
                {
                    MyPage.popMessage(this.Page, "Tanggal Rekomendasi tidak valid");
                    return;
                }
            }

            OBJ_PARAM = new object[43];
            OBJ_PARAM[0] = HttpUtility.HtmlEncode(Session["USERID"].ToString());
            OBJ_PARAM[1] = HttpUtility.HtmlEncode(AccNo);
            OBJ_PARAM[2] = HttpUtility.HtmlEncode(DDL_OFF_NAME.SelectedValue);
            OBJ_PARAM[3] = HttpUtility.HtmlEncode(RELATIONSHIP.Value);
            OBJ_PARAM[4] = HttpUtility.HtmlEncode(TXT_NOTES.Text);
            OBJ_PARAM[5] = HttpUtility.HtmlEncode(LBL);
            OBJ_PARAM[6] = HttpUtility.HtmlEncode(TXT_CUST_ADDR.Text);
            OBJ_PARAM[7] = RESULT.Value;
            OBJ_PARAM[8] = HttpUtility.HtmlEncode(DDL_TUJUAN.SelectedValue);
            OBJ_PARAM[9] = LBL_RESULT;
            //OBJ_PARAM[10] = DDL_LossEvent.SelectedIndex > 0 ? HttpUtility.HtmlEncode(DDL_LossEvent.SelectedValue) : null;
            OBJ_PARAM[10] = DDL_NEXTACTION.SelectedIndex > 0 ? HttpUtility.HtmlEncode(DDL_NEXTACTION.SelectedValue) : null;
            OBJ_PARAM[11] = LBL_NEXTACTION;
            OBJ_PARAM[12] = HttpUtility.HtmlEncode(KEMAMPUAN_DEBITUR.Text);
            OBJ_PARAM[13] = getVisitResult()[0];
            OBJ_PARAM[14] = getVisitResult()[1];
            OBJ_PARAM[15] = getVisitResult()[2];
            OBJ_PARAM[16] = getVisitResult()[3];
            OBJ_PARAM[17] = getVisitResult()[4];
            OBJ_PARAM[18] = getVisitResult()[5];
            OBJ_PARAM[19] = getVisitResult()[6];
            OBJ_PARAM[20] = getVisitResult()[7];
            OBJ_PARAM[21] = getVisitResult()[8];
            OBJ_PARAM[22] = null;
            OBJ_PARAM[23] = null;
            OBJ_PARAM[24] = null;
            OBJ_PARAM[25] = null;
            OBJ_PARAM[26] = getVisitResult()[9];
            OBJ_PARAM[27] = getVisitResult()[10];
            OBJ_PARAM[28] = null;
            OBJ_PARAM[29] = null;
            OBJ_PARAM[30] = null;
            //OBJ_PARAM[31] = null;
            OBJ_PARAM[31] = getVisitResult()[11];
            OBJ_PARAM[32] = getVisitResult()[12];
            OBJ_PARAM[33] = getVisitResult()[13];
            OBJ_PARAM[34] = getVisitResult()[14];
            OBJ_PARAM[35] = getVisitResult()[15];
            OBJ_PARAM[36] = getVisitResult()[16];
            OBJ_PARAM[37] = TXT_PERSONVISIT.Text;
            OBJ_PARAM[38] = DDL_SPADESC.SelectedItem.ToString();
            OBJ_PARAM[39] = getVisitResult()[17];
            OBJ_PARAM[40] = PICKUP_AMOUNT.Value;
            OBJ_PARAM[41] = TXT_PTP_AMOUNT.Value;
            OBJ_PARAM[42] = DDL_PAYMENT_TYPE.SelectedIndex > 0 ? DDL_PAYMENT_TYPE.SelectedValue : null;


            conn.ExecuteNonQuery("exec SAVE_VISIT_HISTORY @1, @2, @3, @4, @5, @6, @7," +
                " @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19," +
                " @20, @21, @22, @23, @24, @25, @26, @27, @28, @29, @30, @31, @32, @33," +
                " @34, @35, @36, @37, @38, @39, @40, @41, @42, @43", OBJ_PARAM, 600);
            UploadUserControl1.MovePostedFilesTo("Upload/VisitFiles/" + AccNo + "/", AccNo, "VISIT");

            string strClientScript = "if(parent.window.opener.window.AfterAction) {" +
                "   parent.window.opener.window.AfterAction('" + AccNo + "'); " +
                "}";

            DataTable dtPar = conn.GetDataTable("exec usp_IsNextActionTrans @1,@2", new object[] { ActionID, DDL_NEXTACTION.SelectedValue }, dbtimeout);
            if (dtPar.Rows.Count > 0 && dtPar.Rows[0]["transfered"].ToString() == "1")
            {
                strClientScript += "parent.window.close();";
            }
            else
            {
                strClientScript += "if (parent.window.document.getElementById('IFR_ISI')!=undefined){ " +
                                    "parent.window.document.getElementById('IFR_ISI').src='';}";
            }
            Response.Write(@"<script type=""text/javascript"">" + strClientScript + "</script>");
        }

        protected void initDropDown()
        {
            //RELATIONSHIP.FillDDL();
            staticFramework.reff(DDL_TUJUAN, "SELECT P_ID,P_DESC FROM RFPURPOSE WHERE ACTIVE=1",
                null, conn);

            staticFramework.reff(DDL_OFF_NAME, "exec SP_GET_FIELD_OFFICER @1",
                new object[1] { Session["USERID"].ToString() }, conn);
            staticFramework.reff(DDL_CUST_ADDR, "exec dbo.usp_GetAddrList @1", new object[1] { AccNo }, conn);
            staticFramework.reff(DDL_NEXTACTION, "exec usp_GetNextActionList @1",
                new object[1] { ActionID }, conn);
            MyPage.initDateForm(txt_DAY_exp, ddl_MONTH_exp, txt_YEAR_exp, true);
            MyPage.initDateForm(TXT_DAY_RESULT, DDL_MONTH_RESULT, TXT_YEAR_RESULT, true);
            MyPage.initDateForm(TXT_DAY_NA, DDL_MONTH_NA, TXT_YEAR_NA, true);
            staticFramework.reff(REASON_NON_PAYMENT, "exec usp_GetReasonList @1", new object[] { ActionID }, conn);
            //staticFramework.reff(DDL_LossEvent, "ExEC sp_vw_LossEventAcc @1", new object[] { AccNo }, conn);
            staticFramework.reff(DDL_PAYMENT_TYPE, "EXEC usp_GetPMTTypeList", null, conn);

            if (DDL_OFF_NAME.Items.Count == 1)
            {
                retrieve_data(DDL_OFF_NAME.SelectedValue);
            }

        }
        
        private void enableText(string STR_VALUE, TextBox TXT)
        {
            if (STR_VALUE.ToLower() == "berubah menjadi")
            {
                TXT.ReadOnly = false;
            }
            else
            {
                TXT.ReadOnly = true;
            }
        }

        private void enableText(string STR_VALUE, TextBox TXT, bool BLO)
        {
            if (BLO)
            {
                if (STR_VALUE.Trim() != "Tetap")
                {
                    TXT.ReadOnly = false;
                }
                else
                {
                    TXT.ReadOnly = true;
                }
            }
            else
            {
                if (STR_VALUE.Trim() == "Lainnya")
                {
                    TXT.ReadOnly = false;
                }
                else
                {
                    TXT.ReadOnly = true;
                }
            }
        }
        public string[] getVisitResult()
        {
            string[] OBJ_PARAM =
                new string[18]{   DDL_SPADESC.SelectedIndex>0?DDL_SPADESC.SelectedValue:null,
                                  DDL_HOUSEPHONEDESC.SelectedIndex > 0?DDL_HOUSEPHONEDESC.SelectedValue:null,
                                  TXT_HOUSEPHONENEW.Text.Length > 0?TXT_HOUSEPHONENEW.Text.Trim():null,
                                  DDL_OFFICEPHONEDESC.SelectedIndex > 0?DDL_OFFICEPHONEDESC.SelectedValue:null,
                                  TXT_OFFICEPHONENEW.Text.Length > 0?TXT_OFFICEPHONENEW.Text.Trim():null,
                                  DDL_HPDESC.SelectedIndex > 0?DDL_HPDESC.SelectedValue:null,
                                  TXT_HPNEW.Text.Length > 0?TXT_HPNEW.Text.Trim():null,
                                  DDL_CORRESPADDRDESC.SelectedIndex > 0?DDL_CORRESPADDRDESC.SelectedValue:null,
                                  TXT_CORRESPADDRNEW.Text.Length > 0?TXT_CORRESPADDRNEW.Text.Trim():null,
                                  DDL_HOUSEADDRDESC.SelectedIndex > 0?DDL_HOUSEADDRDESC.SelectedValue:null,
                                  TXT_HOUSEADDRNEW.Text.Length > 0?TXT_HOUSEADDRNEW.Text.Trim():null,
                                  DDL_OFFICEADDRDESC.SelectedIndex > 0?DDL_OFFICEADDRDESC.SelectedValue:null,
                                  TXT_OFFICEADDRNEW.Text.Length > 0?TXT_OFFICEADDRNEW.Text.Trim():null,
                                  DDL_COLLSTATDESC.SelectedIndex > 0?DDL_COLLSTATDESC.SelectedValue:null,
                                  TXT_COLLSTATNEW.Text.Length > 0?TXT_COLLSTATNEW.Text.Trim():null,
                                  DDL_COLLCONDDESC.SelectedIndex > 0?DDL_COLLCONDDESC.SelectedValue:null,
                                  TXT_COLLCONDNEW.Text.Length > 0?TXT_COLLCONDNEW.Text.Trim():null,
                                  REASON_NON_PAYMENT.SelectedIndex > 0?REASON_NON_PAYMENT.SelectedValue:null,
                };
            return OBJ_PARAM;
        }
                
        protected void cp1_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            if (e.Parameter.StartsWith("GetColl"))
            {
                DataTable dt = conn.GetDataTable("SELECT * FROM SCUSER WHERE USERID=@1",
                    new object[] { e.Parameter.Substring(8).ToString() },
                    dbtimeout);
                if (dt.Rows.Count > 0)
                {
                    TXT_OFF_CONTACT_NO.Text = dt.Rows[0]["HP_NO"].ToString();
                }

            }
        }

        protected void cp2_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            if (e.Parameter.StartsWith("GetColl"))
            {
                DataTable dt = conn.GetDataTable("SELECT * FROM SCUSER WHERE USERID=@1",
                    new object[] { e.Parameter.Substring(8).ToString() },
                    dbtimeout);
                if (dt.Rows.Count > 0)
                {
                    TXT_CONTACT_ID_NO.Text = dt.Rows[0]["NIP"].ToString();
                }

            }
        }

        protected void retrieve_data(string userid)
        {
            DataTable dt = conn.GetDataTable("SELECT * FROM SCUSER WHERE USERID=@1",
                    new object[] { userid },
                    dbtimeout);
            if (dt.Rows.Count > 0)
            {
                TXT_CONTACT_ID_NO.Text = dt.Rows[0]["NIP"].ToString();
            }
            DataTable dt2 = conn.GetDataTable("SELECT * FROM SCUSER WHERE USERID=@1",
                    new object[] { userid },
                    dbtimeout);
            if (dt.Rows.Count > 0)
            {
                TXT_OFF_CONTACT_NO.Text = dt.Rows[0]["HP_NO"].ToString();
            }
        }

        public void DGR_FILEUPLOAD_Load(object sender, EventArgs e)
        {

            DataTable dt;
            dt = conn.GetDataTable("exec SP_FileUploadVisit @1", new object[1] { Request.QueryString["ACC"] }, dbtimeout);
            staticFramework.GridBind(FileUploadList, dt);

        }

        protected void panelupload_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            string[] par = e.Parameter.Split(':');
            if (par[0].ToString() == "d")
            {
                conn.ExecNonQuery("EXEC dbo.SP_DelUploadVisit @1", new object[] { par[1] }, dbtimeout);
                panelupload.JSProperties["cp_alert"] = "File telah terhapus";
                DGR_FILEUPLOAD_Load(sender, e);
            }
        }

        //private void GenLetterDocXext(string bulkID)
        //{
        //    string templatePath = Server.MapPath("~") + "Files\\Template\\Letter\\";
        //    string targetFileName = "";
        //    DataTable dtList = new DataTable();
        //    dtList.Columns.Add("BulkID");
        //    dtList.Columns.Add("AccNo");
        //    dtList.Columns.Add("TemplateID");
        //    divMessage.InnerHtml = "";

        //    //System.Collections.Generic.List<object> listGen;
        //    if (bulkID == null || bulkID.Trim() == "")
        //    {
        //        bulkID = Guid.NewGuid().ToString();
        //        //listGen = DGR_BULK_GEN.GetSelectedFieldValues(new string[] { DGR_BULK_GEN.KeyFieldName, "Kode Jenis Surat" });
        //        //foreach (object[] lst in listGen)
        //        //{
        //        //TEMPLATE ID diganti berdasarkan pilihan tipe surat
        //        dtList.Rows.Add(new object[]{
        //                    bulkID,
        //                   AccNo.ToString(),
        //                   "surat_SP1"}
        //            );
        //        //}
        //        targetFileName = Server.MapPath("~") + "Files\\Generated\\Letter\\" + "surat_SP1_" + USERID + "_" + DateTime.Today.ToString("yyyyMMdd") + ".docx";
        //    }
        //    //else
        //    //{
        //    //    DataTable dt = conn.GetDataTable("EXEC dbo.usp_ViewBulkLetterRegen @1",
        //    //        new object[] { bulkID }, dbtimeout);
        //    //    if (dt.Rows.Count == 0)
        //    //    {
        //    //        divMessage.InnerHtml = "Tidak ada data untuk di Regenerate";
        //    //    }
        //    //    foreach (DataRow dr in dt.Rows)
        //    //    {
        //    //        dtList.Rows.Add(new object[]{
        //    //                bulkID,
        //    //                dr["AccNo"].ToString(),
        //    //                dr["SU_TYPE"].ToString()}
        //    //            );

        //    //    }
        //    //    targetFileName = Server.MapPath("~") + "Files\\Generated\\Letter\\" + "surat_SP1_"  + dt.Rows[0]["BulkFile"].ToString();
        //    //    if (File.Exists(targetFileName))
        //    //        File.Delete(targetFileName);
        //    //}

        //    MailMerger mm = new MailMerger();
        //    mm.conn = conn;
        //    mm.dbtimeout = dbtimeout;
        //    mm.ReceiptTemplateFile = templatePath + "letter_Receipt.dotx";
        //    mm.UserID = USERID;
        //    mm.MailMergeToSingleFile(dtList, templatePath, targetFileName);


        //    foreach (string s in mm.ErrorList)
        //    {
        //        divMessage.InnerHtml += s + "<br />";
        //    }
        //    divMessage.Style["color"] = "red";
        //    dtList.Dispose();

        //}
    }
}