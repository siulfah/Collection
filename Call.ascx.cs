using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using DMS.Tools;
using DMS.Framework;
using DevExpress.Web.ASPxEditors;

/*kebutuhan untuk cisco telecoll*/
using Collection.CWebDialer;
using System.Net;
using System.Security.Cryptography.X509Certificates;
using Collection.Framework;

namespace Collection.Controls
{
    public class MyPolicy : System.Net.ICertificatePolicy
    {
        public bool CheckValidationResult(System.Net.ServicePoint sp,
        System.Security.Cryptography.X509Certificates.X509Certificate cert,
        System.Net.WebRequest request, int problem)
        {
            return true;
        }
    }

	public partial class Call : MasterUserControl
	{
		#region "Variables"	
		string AccNo, CustID, ActionID=string.Empty;
		protected System.Web.UI.HtmlControls.HtmlTableRow TRL_TITLE;
		protected System.Web.UI.HtmlControls.HtmlTableCell TDL_CALL;
		//Controls.CallVisitResult CVR;
		#endregion

        #region "Variable for CISCO TeleColl"
        WebdialerSoap wd = new WebdialerSoap();
        Credential crd = new Credential();
        UserProfile uf = new UserProfile();
        CallResponse cr;
        GetConfigResponse gcr;        
        string DeviceName = "";
        #endregion

        #region "Events"
        

        protected void Page_Load(object sender, System.EventArgs e)
        {
            /*for by pass ssl*/
            System.Net.ServicePointManager.CertificatePolicy = new MyPolicy();
            /**/

            AccNo = Request.QueryString["ACC"].Trim();
            CustID = Request.QueryString["CUST"].Trim();
            ActionID = Request.QueryString["ActionID"];

            RELATIONSHIP.conn = conn;
            RELATIONSHIP.QueryString = "SELECT REL_ID, REL_DESC FROM RFRELATIONSHIP";
            RELATIONSHIP.JavaScript = RESULT.JSCallback();
            RELATIONSHIP.FillDDL();

            RESULT.conn = conn;
            RESULT.QueryString = "EXEC usp_GetResultList @1, @2";
            RESULT.QueryParam = new object[] { ActionID, RELATIONSHIP };
            RESULT.JavaScript = "ResultChange(document.getElementById('" + RESULT.DDL.ClientID+ "').value);";

            if (!IsPostBack)
            {
                initDropDown();
                LoadColl();
                LoadDDL();
            }
            string CTIRegSta = (string)Session["CTIRegSta"];
            if (CTIRegSta.ToUpper() != "SUCCESS")
            {
                btnDialHangup.Disabled = true;
            }


            btnSave.Attributes.Add("onclick", "if(!cek_mandatory(document.Form1)){return false;}");
            btnHistory.Attributes.Add("onclick", "PopupPage('../History/History.aspx?ActionID=" + ActionID + "&ACC=" + AccNo + "&CUST=" + CustID + "',null,600);");
            DDL_NEXT_ACT.Attributes.Add("onchange", "next_change();");
            
		}

        protected void btnSave_Click(object sender, System.EventArgs e)
		{

            CTIHangUp();
		    SaveInputan();
		}

		#endregion		

		#region "Method"
                
		private void SaveInputan()
		{
                string TGL_RESULT = null, TGL_NEXTACT = null;
                try
                {
                    TGL_RESULT = RESULT_DATE.getDate.ToString("yyyyMMdd") + " " + RESULT_HH.Text + ":" + RESULT_MM.Text + ":00";
                }
                catch {

                    MyPage.popMessage(this.Page, "Tanggal janji tidak valid");
                    return;
                }

                try
                {
                    TGL_NEXTACT = DATE_ACTION.getDate.ToString("yyyyMMdd") + " " + NEXT_HH.Text + ":" + NEXT_MM.Text + ":00";
                }
                catch
                {

                    MyPage.popMessage(this.Page, "Tanggal Rekomendasi tidak valid");
                    return;
                }
                try
                {
                    conn.ExecReader("EXEC usp_GetActResultMaxDay @1,@2",
                        new object[]{
                            RESULT.DDL.SelectedValue,
                            RESULT_DATE.getDate
                        }, dbtimeout);
                    if (conn.hasRow())
                    {
                        MyPage.popMessage(this.Page, "Tanggal janji debitur " + RESULT.DDL.SelectedItem.Text + " Tidak boleh lebih dari " + conn.GetFieldValue(0));
                        return;
                    }

                }
                catch {

                }
                
                string phoneNum = string.Empty;                
                DataTable dt = conn.GetDataTable("EXEC usp_GetContactByID @1, @2", 
                    new object[] { CustID, CC_ID.Value }, dbtimeout);
                if (dt.Rows.Count > 0)
                {
                    phoneNum = dt.Rows[0]["CONTACTNO"].ToString();
                }

                NameValueCollection nvcKeys = new NameValueCollection();
                NameValueCollection nvcFields = new NameValueCollection();
                
                
				object[] OBJ_PARAM = new object[39];
				OBJ_PARAM[0] = AccNo; 
                OBJ_PARAM[1] = USERID;				
				OBJ_PARAM[2] = RESULT.Value;
                OBJ_PARAM[3] = REASON_NON_PAYMENT.SelectedValue;
				OBJ_PARAM[4] = TGL_NEXTACT;
				OBJ_PARAM[5] = DDL_NEXT_ACT.SelectedValue;
                OBJ_PARAM[6] = phoneNum;
				OBJ_PARAM[7] = RELATIONSHIP.Value;
				OBJ_PARAM[8] = HttpUtility.HtmlEncode(TXT_SpokeTo.Text);
				OBJ_PARAM[9] = TUJUAN.SelectedValue;
				OBJ_PARAM[10] = TGL_RESULT;
				OBJ_PARAM[11] = getCallResult()[0];
                OBJ_PARAM[12] = getCallResult()[1]; 
                OBJ_PARAM[13] = getCallResult()[2];
                OBJ_PARAM[14] = getCallResult()[3]; 
                OBJ_PARAM[15] = getCallResult()[4];
                OBJ_PARAM[16] = getCallResult()[5]; 
                OBJ_PARAM[17] = getCallResult()[6];
                OBJ_PARAM[18] = getCallResult()[7]; 
                OBJ_PARAM[19] = getCallResult()[8];
                OBJ_PARAM[20] = getCallResult()[9]; 
                OBJ_PARAM[21] = getCallResult()[10];
                OBJ_PARAM[22] = getCallResult()[11]; 
                OBJ_PARAM[23] = getCallResult()[12];
                OBJ_PARAM[24] = getCallResult()[13]; 
                OBJ_PARAM[25] = getCallResult()[14];
                OBJ_PARAM[26] = getCallResult()[15]; 
                OBJ_PARAM[27] = getCallResult()[16];
                OBJ_PARAM[28] = getCallResult()[17];
                OBJ_PARAM[29] = getCallResult()[18];
                OBJ_PARAM[30] = getCallResult()[19];
                OBJ_PARAM[31] = getCallResult()[20];
                OBJ_PARAM[32] = TXT_NOTES.Text.Replace("'", "`");
                OBJ_PARAM[33] = DDL_SPADESC.SelectedItem.Text.ToString();
                OBJ_PARAM[34] = HttpUtility.HtmlEncode(KEMAMPUAN_DEBITUR.Text);
                OBJ_PARAM[35] = TXT_PTP_AMOUNT.Value;
                OBJ_PARAM[36] = DDL_PAYMENT_TYPE.SelectedIndex > 0 ? DDL_PAYMENT_TYPE.SelectedValue : null;
                OBJ_PARAM[37] = DDL_PTP_PERSON.SelectedIndex > 0 ? DDL_PTP_PERSON.SelectedValue : null;
                OBJ_PARAM[38] = hdnRequestID.Value;

                try
                {
                    conn.ExecuteNonQuery("exec SAVE_CALL_HISTORY @1, @2, @3, @4, @5, @6, @7," +
                        " @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, "
                        + " @21, @22, @23, @24, @25, @26, @27, @28, @29, @30, @31, @32, "
                        + "@33, @34, @35, @36, @37, @38, @39", OBJ_PARAM, dbtimeout);               

                    //save status and condition collateral
                    string colid = "";
                    DropDownList ddlColSta, ddlColCond;
                    foreach (GridViewRow grdRow in gvCollateral.Rows)
                    {
                        colid = gvCollateral.Rows[grdRow.RowIndex].Cells[0].Text;
                        ddlColSta = (DropDownList)(gvCollateral.Rows[grdRow.RowIndex].Cells[2].FindControl("DDL_COLLSTA"));
                        ddlColCond = (DropDownList)(gvCollateral.Rows[grdRow.RowIndex].Cells[3].FindControl("DDL_COLLCOND"));

                        if (ddlColSta.SelectedValue.Trim() != "" || ddlColCond.SelectedValue.Trim() != "")
                        {
                            conn.ExecNonQuery("EXEC SP_UpdCollStaCond @1, @2, @3, @4",
                                new object[] { AccNo, colid, ddlColSta.SelectedValue, ddlColCond.SelectedValue }, dbtimeout);
                        }
                    }

                    string strClientScript = "if(parent.window.opener.window.AfterAction) {" +
                                    " parent.window.opener.window.AfterAction('" + AccNo + "'); " +
                                    "}";

                    DataTable dtPar = conn.GetDataTable("exec usp_IsNextActionTrans @1, @2", new object[] { ActionID, DDL_NEXT_ACT.SelectedValue }, dbtimeout);
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
                }catch(Exception exp)
                {
                    Response.Write("<!--" + exp.Message.ToString() + "-->");
                }
		}
		protected void initDropDown()
        {                
            staticFramework.reff(TUJUAN, "SELECT P_ID,P_DESC FROM RFPURPOSE WHERE ACTIVE=1",null, conn);                
            staticFramework.reff(DDL_ContactNo, "exec usp_GetContactList @1, @2", new object[2] { AccNo, "COMB" }, conn);                
            staticFramework.reff(DDL_PTP_PERSON, "exec usp_GetContactList @1, @2", new object[] { AccNo, "NAMA" }, conn);            
            staticFramework.reff(DDL_PAYMENT_TYPE, "EXEC usp_GetPMTTypeList", null, conn);
            staticFramework.reff(REASON_NON_PAYMENT, "exec usp_GetReasonList @1", new object[] { ActionID }, conn);
            staticFramework.reff(DDL_NEXT_ACT, "exec  usp_GetNextActionList   @1", new object[1] { ActionID }, conn);
            staticFramework.reff(DDL_HMPHNSTA, "select ccsta_code, ccsta_desc  FROM RFCONTACT_STATUS where active=1", null, conn);
            staticFramework.reff(DDL_OFFPHNSTA, "select ccsta_code, ccsta_desc FROM RFCONTACT_STATUS where active=1", null, conn);
            staticFramework.reff(DDL_HPSTA, "select ccsta_code, ccsta_desc FROM RFCONTACT_STATUS where active=1", null, conn);
            staticFramework.reff(DDL_OFFICEADDRSTA, "select casta_code, casta_desc from RFADDR_STATUS where active=1 and casta_code<>'03'", null, conn);
            staticFramework.reff(DDL_CORRESPADDRSTA, "select casta_code, casta_desc from RFADDR_STATUS where active=1 and casta_code<>'02'", null, conn);
            staticFramework.reff(DDL_HOUSEADDRSTA, "select casta_code, casta_desc from RFADDR_STATUS where active=1 and casta_code<>'03' ", null, conn);
            staticFramework.reff(DDL_SPADESC, "EXEC dbo.usp_GetResultList @1", new object[] { "00003" }, conn);

            staticFramework.reff(CC_CONTACTTYPE, "select CT_CODE,CT_DESC from RFCONTACTTYPE WHERE ACTIVE=1", null, conn);               
            string strScriptContent;
            divScript.InnerHtml = "";
            DataTable dtScript = conn.GetDataTable("exec usp_GetCallScript @1", new object[] { AccNo }, dbtimeout);
            if (dtScript.Rows.Count > 0)
            {
                strScriptContent = dtScript.Rows[0]["TEMPLATE"].ToString();

                DataTable dtLoanInfo = conn.GetDataTable("EXEC usp_vw_CustAccDetail @1", new object[] { AccNo }, dbtimeout);
                if (dtLoanInfo.Rows.Count > 0)
                {
                    strScriptContent = DataTableHelper.ProcessTemplate(strScriptContent, dtLoanInfo);
                }
                divScript.InnerHtml = strScriptContent;
            }
            DataTable dtInit = conn.GetDataTable("exec usp_GetInitSetting", null, dbtimeout);
            if (dtInit.Rows.Count > 0)
            {
                hdnTelePrefixNum.Value = dtInit.Rows[0]["TelePrefixNum"].ToString();
            }
		}


		private void enableText(string STR_VALUE, TextBox TXT)
		{
			if(STR_VALUE.ToLower() == "berubah menjadi")
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
			if(BLO)
			{
				if(STR_VALUE.Trim() != "Tetap")
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
				if(STR_VALUE.Trim() == "Lainnya")
				{
					TXT.ReadOnly = false;
				}
				else
				{
					TXT.ReadOnly = true;
				}
			}
		}

        private void LoadColl()
        {
            DataTable dt = conn.GetDataTable("EXEC ups_GetCollateralList @1", new object[] { AccNo }, dbtimeout);
            gvCollateral.DataSource = dt;
            gvCollateral.DataBind();
            gvCollateral.Columns[0].Visible = false;
        }

        private void LoadDDL()
        {
            DropDownList ddlColSta, ddlColCond;
            foreach (GridViewRow grdRow in gvCollateral.Rows)
            { 
                ddlColSta=(DropDownList)(gvCollateral.Rows[grdRow.RowIndex].Cells[2].FindControl("DDL_COLLSTA"));
                ddlColCond=(DropDownList)(gvCollateral.Rows[grdRow.RowIndex].Cells[2].FindControl("DDL_COLLCOND"));
                if (ddlColSta != null)
                {
                    staticFramework.reff(ddlColSta, "select colsta_code, colsta_desc FROM RFCOLSTATUS where active=1 and col_type=@1", new object[] { "TB" }, conn);
                }

                if (ddlColCond != null)
                {
                    staticFramework.reff(ddlColCond, "SELECT COLCON_CODE, COLCON_DESC FROM RFCOLCONDITION WHERE active=1 and COL_TYPE=@1", new object[] { "TB" }, conn);

                }
            }
        }

		public string[] getCallResult()
		{
            string[] OBJ_PARAM =
                new string[]{   DDL_SPADESC.SelectedIndex>0?DDL_SPADESC.SelectedValue:null,
								  DDL_HMPHNSTA.SelectedIndex > 0?DDL_HMPHNSTA.SelectedValue:null,
                                  TXT_HOUSEPHONEAREA.Text.Length>0?TXT_HOUSEPHONEAREA.Text.Trim():null,
								  TXT_HOUSEPHONENEW.Text.Length > 0?TXT_HOUSEPHONENEW.Text.Trim():null,
								  DDL_OFFPHNSTA.SelectedIndex > 0?DDL_OFFPHNSTA.SelectedValue:null,
                                  TXT_OFFICEPHONEAREA.Text.Length > 0?TXT_OFFICEPHONEAREA.Text.Trim():null,                    
								  TXT_OFFICEPHONENEW.Text.Length > 0?TXT_OFFICEPHONENEW.Text.Trim():null,
								  DDL_HPSTA.SelectedIndex > 0?DDL_HPSTA.SelectedValue:null,
								  TXT_HPNEW.Text.Length > 0?TXT_HPNEW.Text.Trim():null,
								  DDL_CORRESPADDRSTA.SelectedIndex > 0?DDL_CORRESPADDRSTA.SelectedValue:null,
								  TXT_CORRESPADDRNEW.Text.Length > 0?TXT_CORRESPADDRNEW.Text.Trim():null,
                                  TXT_CORRESPADDRNEW2.Text.Length > 0?TXT_CORRESPADDRNEW2.Text.Trim():null,
                                  TXT_CORRESPCITY.Text.Length > 0?TXT_CORRESPCITY.Text.Trim():null,
                                  TXT_CORRESPADDRKODEPOS.Text.Length > 0?TXT_CORRESPADDRKODEPOS.Text.Trim():null,
								  DDL_HOUSEADDRSTA.SelectedIndex > 0?DDL_HOUSEADDRSTA.SelectedValue:null,
								  TXT_HOUSEADDRNEW.Text.Length > 0?TXT_HOUSEADDRNEW.Text.Trim():null,
                                  TXT_HOUSEADDRNEW2.Text.Length > 0?TXT_HOUSEADDRNEW2.Text.Trim():null,
                                  TXT_HOUSECITY.Text.Length > 0?TXT_HOUSECITY.Text.Trim():null,
                                  TXT_HOUSEZIPCODE.Text.Length > 0?TXT_HOUSEZIPCODE.Text.Trim():null,
								  DDL_OFFICEADDRSTA.SelectedIndex > 0?DDL_OFFICEADDRSTA.SelectedValue:null,
								  TXT_OFFICEADDRNEW.Text.Length > 0?TXT_OFFICEADDRNEW.Text.Trim():null};
			return OBJ_PARAM;
		}

        private void SaveNewContact() { 
        
        }
		#endregion



        #region "CTI TeleColl Method"

        private void OutboundCallStateEvent(object sender, CTI.GetOutboundCallStateCompletedEventArgs e)
        {
            OutboundInfo infoState = (OutboundInfo)e.UserState;
            if (e.ErrMsg == "TIMEOUT")
            {
                lblMsg.InnerText = "TIMEOUT-" + infoState.WaitingForState.ToString();
                infoState.objWS.GetOutboundCallStateAsync(infoState.RequestID, infoState.Destination, infoState.WaitingForState, null, infoState);
                return;
            }
            if (e.Result == CTI.OutboundCallStateEnum.RINGOUT)
            {
                lblMsg.InnerText = e.Result.ToString();
                infoState.WaitingForState = CTI.OutboundCallStateEnum.ANSWER;
                infoState.objWS.GetOutboundCallStateAsync(infoState.RequestID, infoState.Destination, infoState.WaitingForState, null, infoState);
                return;
            }
            if (e.Result == CTI.OutboundCallStateEnum.ANSWER)
            {
                lblMsg.InnerText = e.Result.ToString();
                infoState.WaitingForState = CTI.OutboundCallStateEnum.HANGUP;
                infoState.objWS.GetOutboundCallStateAsync(infoState.RequestID, infoState.Destination, infoState.WaitingForState, null, infoState);
                return;
            }
            if (e.Result == CTI.OutboundCallStateEnum.HANGUP)
            {
                lblMsg.InnerText = e.Result.ToString();
                btnDialHangup.Value = "Dial";
                infoState.WaitingForState = CTI.OutboundCallStateEnum.DISCONNECT;
                infoState.objWS.GetOutboundCallStateAsync(infoState.RequestID, infoState.Destination, infoState.WaitingForState, null, infoState);
                return;
            }
            if (e.Result == CTI.OutboundCallStateEnum.DISCONNECT)
            {
                lblMsg.InnerText = e.Result.ToString();
                btnDialHangup.Value = "Dial";
            }
        }
        private string GetOutStatus(string phoneNumber) 
        {
            string errMSG = "";
            string tmpResult = hdnLastState.Value+":" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
            CTI.CTIServiceStandard objCTI = new CTI.CTIServiceStandard();

            if ((string)Session["CallEntryState"] == "")
            {
                return "Dial:" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
            }
            if ((string)Session["CallEntryState"] == "INIT")
            {
                if (objCTI.GetOutboundCallStateDirect(hdnRequestID.Value, phoneNumber, CTI.OutboundCallStateEnum.DISCONNECT, ref errMSG))
                {
                    return "Dial:" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
                }
                if (objCTI.GetOutboundCallStateDirect(hdnRequestID.Value, phoneNumber, CTI.OutboundCallStateEnum.RINGOUT, ref errMSG))
                {                    
                    Session["CallEntryState"] = "RINGOUT";
                    return "Hangup:" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
                }
            }
            if ((string)Session["CallEntryState"] == "RINGOUT")
            {
                if (objCTI.GetOutboundCallStateDirect(hdnRequestID.Value, phoneNumber, CTI.OutboundCallStateEnum.DISCONNECT, ref errMSG))
                {
                    return "Dial:" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
                }
                if (objCTI.GetOutboundCallStateDirect(hdnRequestID.Value, phoneNumber, CTI.OutboundCallStateEnum.ANSWER, ref errMSG))
                {
                    Session["CallEntryState"] = "ANSWER";
                    return "Hangup:" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
                }
            }
            if ((string)Session["CallEntryState"] == "ANSWER")
            {
                if (objCTI.GetOutboundCallStateDirect(hdnRequestID.Value, phoneNumber, CTI.OutboundCallStateEnum.HANGUP, ref errMSG))
                {
                    Session["CallEntryState"] = "HANGUP";
                    return "Dial:" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
                }
                if (objCTI.GetOutboundCallStateDirect(hdnRequestID.Value, phoneNumber, CTI.OutboundCallStateEnum.DISCONNECT, ref errMSG))
                {
                    return "Dial:" + hdnCallID.Value + ":" + hdnRequestID.Value + ":" + phoneNumber + ":" + errMSG;
                }
            }
           
            return tmpResult;
        }
        private string CTIHangUp()
        {
            Session["CallEntryState"] = "";
            lblMsg.InnerText = CTIInterface.CTIDisconnect((string)Session["UserID"], hdnCallID.Value);
            hdnCallID.Value = "";
            return "Dial::::";
        }
        private string CTIMakeCall(string phoneNumber)
        {
            string tmpResult = "";
            string requestID = "";
            string errMSG = "";
            try
            {
                CTIHangUp();
                CTI.CTIServiceStandard objCTI = new CTI.CTIServiceStandard();
                hdnCallID.Value = objCTI.MakeCall((string)Session["UserID"], phoneNumber, ref requestID, ref errMSG);
                if (errMSG.Trim() == "")
                {
                    hdnRequestID.Value = requestID;
                    Session["CallEntryState"] = "INIT";
                    objCTI.GetOutboundCallStateCompleted += new CTI.GetOutboundCallStateCompletedEventHandler(OutboundCallStateEvent);
                    OutboundInfo infoState = new OutboundInfo(objCTI, requestID, phoneNumber, CTI.OutboundCallStateEnum.RINGOUT);
                    errMSG = "";
                    objCTI.GetOutboundCallStateAsync(requestID, phoneNumber, CTI.OutboundCallStateEnum.RINGOUT, errMSG, infoState);

                }
                else
                {
                    btnDialHangup.Value = "Dial";
                    lblMsg.InnerText = errMSG;
                }
            }
            catch (Exception exp)
            {
                errMSG = exp.Message;
                lblMsg.InnerText = exp.Message;
            }
            tmpResult = "Hangup:" + hdnCallID.Value + ":" + requestID + ":" + phoneNumber + ":" + errMSG;
            return tmpResult;
        }
 
        private void Fillparam()
        {
            crd.userID = USERID;
            crd.password = CISCOPWD;
            uf.deviceName = DeviceName;
            uf.lineNumber = "";
            uf.user = crd.userID;
            uf.locale = "English";

        } 
        #endregion

        #region CISCO Webdialer
        private void Dial(string PhoneNum)
        {
            try
            {
                Fillparam();
                cr = wd.makeCallSoap(crd, PhoneNum, uf);
                lblMsg.InnerText = cr.responseCode.ToString() + ". " + cr.responseDescription.ToString();
            }
            catch
            { 
            }
        }
        private void EndCall()
        {
            Fillparam();
            cr = wd.endCallSoap(crd, uf);
            lblMsg.InnerText = cr.responseCode.ToString() + ". " + cr.responseDescription.ToString();
        }
        private void getUserProfile()
        {
            try
            {
                Fillparam();
                gcr = wd.getProfileSoap(crd, USERID);
                lblMsg.InnerText = gcr.responseCode.ToString() + " " + gcr.description.ToString();
                WDDeviceInfo[] uf_result = gcr.deviceInfoList;

                for (int i = 0; i < uf_result.Length; i++)
                {
                    //td di komen
                    DeviceName = uf_result[i].deviceName.ToString();
                    Response.Write((i + 1).ToString() + ". DeviceName:" + uf_result[i].deviceName);

                    string[] _lines;
                    _lines = uf_result[i].lines;
                    for (int il = 0; il < _lines.Length; il++)
                    {
                        Response.Write((il + 1).ToString() + ". Line: " + _lines[il].ToString());
                    }

                }
            }
            catch { }

        }
        #endregion

        protected void CTICallBack_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            string[] arg = e.Parameter.Split(':');
            string act = arg[0].ToString().ToLower();
            if (act == "dial")
            {
                string phoneNum = string.Empty;
                DataTable dt = conn.GetDataTable("EXEC usp_GetContactByID @1, @2", new object[] { CustID, CC_ID.Value }, dbtimeout);
                if (dt.Rows.Count > 0)
                {
                    phoneNum = hdnTelePrefixNum.Value + dt.Rows[0]["CONTACTNO"].ToString();
                }
                e.Result = CTIMakeCall(phoneNum);
            }
            else if (act == "hangup")
            {
                e.Result = CTIHangUp();
            }
            else if (act == "state")
            {
                e.Result = GetOutStatus(hdnCalledNum.Value);
            }
        }
        protected void pnlContact_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e)
        {
            string cc_id = e.Parameter.Split(':')[1].ToString();
            staticFramework.reff(DDL_ContactNo, "exec usp_GetContactList @1, @2", new object[2] { AccNo, "COMB" }, conn);
            DDL_ContactNo.SelectedValue = CC_ID.Value;
        }
        protected void Callback1_Callback(object source, DevExpress.Web.ASPxCallback.CallbackEventArgs e)
        {
            if (e.Parameter.StartsWith("sc:")) {
                conn.ExecNonQuery("EXEC usp_InsCustContact @1, @2, @3, @4, @5, @6, @7, @8",
                    new object[] { CustID, CC_CONTACTNAME.Value, null, CC_CONTACTTYPE.SelectedValue, CC_CONTACTAREA.Value, CC_CONTACTNO.Value, CC_CONTACTEXT.Value, 0 }, dbtimeout);

            }        
        }
       
    }
}
