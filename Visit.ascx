<%@ Control Language="c#" AutoEventWireup="True" Codebehind="Visit.ascx.cs" Inherits="Collection.Controls.Visit" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register src="UploadUserControl.ascx" tagname="UploadUserControl" tagprefix="uc1" %>
<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.2" namespace="DevExpress.Web.ASPxEditors" tagprefix="dxe" %>
<%--<%@ Register assembly="DevExpress.Web.ASPxGridView.v9.2" namespace="DevExpress.Web.ASPxGridView" tagprefix="dxwgv" %>--%>
<%--<%@ Register src="GRD_Upload.ascx" tagname="GRD_Upload" tagprefix="uc1" %>--%>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallback" tagprefix="dxcb" %>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxCallbackPanel" tagprefix="dxcp" %>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPanel" tagprefix="dxp" %>
<%@ Register src="../UserControl/USC_DDL_Cascade.ascx" tagname="USC_DDL_Cascade" tagprefix="uc1" %>
<%@ Register TagPrefix="dxp" Namespace="DevExpress.Web.ASPxPanel" Assembly="DevExpress.Web.v9.2" %>
<%@ Register Assembly="DevExpress.Web.ASPxGridView.v9.2, Version=9.2.4.0, Culture=neutral" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register assembly="DMSControls" namespace="DMSControls" tagprefix="cc1" %>

<style type="text/css">
    .auto-style1 {
        height: 19px;
        width: 430px;
    }
    .auto-style2 {
        height: 28px;
        width: 430px;
    }
    .auto-style3 {
        height: 15px;
        width: 430px;
    }
    .auto-style4 {
        width: 430px;
    }
</style>

<script type="text/javascript">
    var VisitStateID = 0;

    function ResultChange(svalue) {
        if (svalue == "R0020" || svalue == "R0013") {
            document.getElementById("<%=TXT_DAY_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=DDL_MONTH_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=TXT_YEAR_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=Lbl_Time.ClientID %>").style.display = "";
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID %>").style.display = "none";
            document.getElementById("<%=REKOMENDASI.ClientID %>").style.display = "none";
        }
        else if (svalue == "R0025"|| svalue == "R0014"||svalue == "R0015"||svalue == "R0022"||svalue == "R0030" ||svalue == "R0018"|| svalue == "R0026"|| svalue == "R0032") {
            document.getElementById("<%=TXT_DAY_RESULT.ClientID %>").style.display = "none";
            document.getElementById("<%=DDL_MONTH_RESULT.ClientID %>").style.display = "none";
            document.getElementById("<%=TXT_YEAR_RESULT.ClientID %>").style.display = "none";
            document.getElementById("<%=PickUp.ClientID %>").style.display = "none";
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID %>").style.display = "none";
            document.getElementById("<%=REKOMENDASI.ClientID %>").style.display = "none";
            document.getElementById("<%=tdUploadFile.ClientID %>").style.display = "none";
            document.getElementById("<%=TR_Note.ClientID %>").style.display = "none";
            document.getElementById("<%=JANJIBAYAR3.ClientID %>").style.display = "none";
            document.getElementById("<%=ResultDate.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_Time.ClientID %>").style.display = "none";
            document.getElementById("<%=TXT_HOUR_RESULT.ClientID %>").style.display = "none";
            document.getElementById("<%=TXT_MIN_RESULT.ClientID %>").style.display = "none";
            document.getElementById("<%=JANJIBAYAR1.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_Sparator.ClientID %>").style.display = "none";            
        }
        else {
            document.getElementById("<%=TXT_DAY_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=DDL_MONTH_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=TXT_YEAR_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=PickUp.ClientID %>").style.display = "none";
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID %>").style.display = "";
            document.getElementById("<%=REKOMENDASI.ClientID %>").style.display = "";
            document.getElementById("<%=tdUploadFile.ClientID %>").style.display = ""; 
            document.getElementById("<%=TR_Note.ClientID %>").style.display = "";
            document.getElementById("<%=JANJIBAYAR1.ClientID %>").style.display = "";
            document.getElementById("<%=JANJIBAYAR3.ClientID %>").style.display = "";
            document.getElementById("<%=ResultDate.ClientID %>").style.display = "";
            document.getElementById("<%=Lbl_Time.ClientID %>").style.display = "none";
            document.getElementById("<%=TXT_HOUR_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=TXT_MIN_RESULT.ClientID %>").style.display = "";
            document.getElementById("<%=Lbl_Sparator.ClientID %>").style.display = "";
            
        }
        parent.resizeFrame();
    }
        
    function addr_change()
    {
        document.getElementById("<%=TXT_CUST_ADDR.ClientID%>").value=document.getElementById("<%=DDL_CUST_ADDR.ClientID%>").value;
    }
    function next_change()
    {
        if(document.getElementById("<%=DDL_NEXTACTION.ClientID%>").value=="00021")
        {
            document.getElementById("TR_DEBITUR_AMOUNT").style.display="block";
        }
        else if(document.getElementById("<%=DDL_NEXTACTION.ClientID%>").value=="00032")
        {
            document.getElementById("TR_Downolad").style.display="";
        }
        else
        {
            document.getElementById("TR_DEBITUR_AMOUNT").style.display="none";
        }
    }  

  function GetColl()
    {
        cp1.PerformCallback("GetColl:"+document.getElementById("<%=DDL_OFF_NAME.ClientID %>").value);
        cp2.PerformCallback("GetColl:"+document.getElementById("<%=DDL_OFF_NAME.ClientID %>").value);
    }
    function Save()
    {
        if(!cek_mandatory(document.Form1))
        {
            return false;
        }
        else
        {
            if(UploadControl.GetText() != "")
            {
                UploadControl.Upload();         
            }else
            {
                document.getElementById("<%=BTN_SAVE_VISIT.ClientID %>").click();
            }      
        }
    }
    function FilesUploadComplete(s, e) {
        document.getElementById("<%=BTN_SAVE_VISIT.ClientID %>").click();
        //panelupload.PerformCallback("BindUpload:");
    }
</script>
<table width="100%">
	<tr>
		<td class="TDBGColor1" id="TDL_EXPIRYDATE" width="20%">Tgl Kunjungan (dd-mm-yyyy)</td>
		<td id="TD_S1" style="WIDTH: 8px; HEIGHT: 19px">:</td>
		<td class="auto-style1" id="TDL_CALENDAR">
			<asp:textbox onkeypress="return numbersonly()" id="txt_DAY_exp" runat="server" Columns="4" MaxLength="2"
				CssClass="mandatory"></asp:textbox>
			<asp:dropdownlist id="ddl_MONTH_exp" runat="server" CssClass="mandatory"></asp:dropdownlist>
			<asp:textbox onkeypress="return numbersonly()" id="txt_YEAR_exp" runat="server" Columns="4" MaxLength="4"
				CssClass="mandatory"></asp:textbox>
            <br>*Tanggal harus sesuai dengan Bulan hari ini</br>
		</td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="TDL_AIM">Tujuan</td>
		<td id="TDL_S1" style="WIDTH: 8px; HEIGHT: 28px">:</td>
		<td class="auto-style2" id="TDL_AIM1" runat="server">
            <asp:dropdownlist id="DDL_TUJUAN" runat="server" CssClass="mandatory">
			</asp:dropdownlist></td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="TDL_NAME">Nama Petugas</td>
		<td id="TD_S2" style="WIDTH: 8px; HEIGHT: 15px">:</td>
		<td class="auto-style3" id="TDL_NAME1">
            <asp:dropdownlist id="DDL_OFF_NAME" runat="server" CssClass="mandatory" 
                onchange="GetColl();" Width="120px"></asp:dropdownlist></td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="TDL_CONTACTNO">No. Telpon</td>
		<td id="TD_S3" style="WIDTH: 8px">:</td>
		<%--<td class="auto-style4" id="TDL_CONTACTNO1">
		    <dxcp:ASPxCallbackPanel ID="cp1" runat="server" ClientInstanceName="cp1" 
                oncallback="cp1_Callback" Width="200px">
                <PanelCollection>
                <dxp:PanelContent runat="server">
                        <asp:TextBox ID="TXT_OFF_CONTACT_NO" runat="server" Columns="25" 
                        MaxLength="100" ReadOnly="True"></asp:TextBox>
                </dxp:PanelContent>
                </PanelCollection>
            </dxcp:ASPxCallbackPanel>
		</td>--%>
        <td>
            <asp:TextBox onkeypress="return numbersonly()" ID="TXT_OFF_CONTACT_NO" runat="server" CssClass="mandatory"></asp:TextBox>
        </td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="TDL_IDNO">No. Pengenal</td>
		<td id="TD_S4" style="WIDTH: 8px">:</td>	
		<%--<td class="auto-style4">
		    <dxcp:ASPxCallbackPanel ID="cp2" runat="server" ClientInstanceName="cp2" 
                oncallback="cp2_Callback" Width="200px">
                <PanelCollection>
                <dxp:PanelContent runat="server">
                    <asp:TextBox ID="TXT_CONTACT_ID_NO" runat="server" Columns="25" MaxLength="100" 
                        ReadOnly="True"></asp:TextBox>
                </dxp:PanelContent>
                </PanelCollection>
            </dxcp:ASPxCallbackPanel>
		</td>--%>	
        <td>
            <asp:TextBox onkeypress="return numbersonly()" ID="TXT_CONTACT_ID_NO" runat="server" CssClass="mandatory"></asp:TextBox>
        </td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="TDL_CUSTOMERADDRESS">Alamat yg dikunjungi</td>
		<td id="TD_S5" style="WIDTH: 8px">:</td>
		<td class="auto-style4" id="TDL_CUSTADDR1">
            <asp:dropdownlist id="DDL_CUST_ADDR" runat="server"></asp:dropdownlist>
			<input type="button" value="Add Contact" onclick="PopupPage('../CommonPage/List.aspx?ControlID=00015&ControlParent=&ACC=<%= Request.QueryString["ACC"] %>&CUST=<%= Request.QueryString["CUST"] %>'),600,400"/>
            <br />
            <asp:textbox id="TXT_CUST_ADDR" 
                runat="server" Width="500px" CssClass="mandatory" MaxLength="240"
				Columns="25" Rows="2" TextMode="MultiLine"></asp:textbox></td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="TD1">Orang yg dikunjungi</td>
		<td style="WIDTH: 8px; HEIGHT: 15px">:</td>
		<td class="auto-style3">
			<asp:TextBox id="TXT_PERSONVISIT" runat="server" CssClass="mandatory"></asp:TextBox> *Nama yang ditemui
		</td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="TDL_RELATIONSHIP">Hubungan yg dikunjungi</td>
		<td id="TD2">:</td>
		<td id="TDL_REL1" runat="server" class="auto-style4">
            <uc1:USC_DDL_Cascade ID="RELATIONSHIP" runat="server" />
        </td>
	</tr>
	<tr id="TRL_RESULT" runat="server">
		<td class="TDBGColor1" id="TDL_RESULT">Hasil kunjungan</td>
		<td id="TDL_S7" style="WIDTH: 8px">:</td>
		<td class="auto-style4" id="TDL_RESULT1" runat="server">
            <uc1:USC_DDL_Cascade ID="RESULT" runat="server" style="display:block;"/>&nbsp;
            <asp:Label ID="ResultDate" runat="server">Tanggal (dd-mm-yyyy) :</asp:Label>
            &nbsp;
			<asp:textbox onkeypress="return numbersonly()" id="TXT_DAY_RESULT" runat="server" Columns="4" MaxLength="2" Width="32px"></asp:textbox>
			<asp:dropdownlist id="DDL_MONTH_RESULT" runat="server" ></asp:dropdownlist>
			<asp:textbox onkeypress="return numbersonly()" id="TXT_YEAR_RESULT" runat="server" Columns="4" MaxLength="4" ></asp:textbox>
			&nbsp;
            <asp:Label ID="Lbl_Time" runat="server">Jam(hh:mm) </asp:Label>
            &nbsp;
			<asp:textbox onkeypress="return numbersonly()" id="TXT_HOUR_RESULT" runat="server" Columns="4" MaxLength="2" Text="0"></asp:textbox>
            <asp:Label ID="Lbl_Sparator" runat="server">:</asp:Label>
			<asp:textbox onkeypress="return numbersonly()" id="TXT_MIN_RESULT" runat="server" Columns="4" MaxLength="2" Text="0"></asp:textbox>
	    </td>
				
	</tr>
    <tr id="REASONFORNONPAYMENT" runat="server">
	    <td class="TDBGColor1" id="TDL_REASONFORNONPAYMENT">Alasan tidak bayar</td>
	    <td id="TD3">:</td>
	    <td id="TDL_REASON1" runat="server" class="auto-style4">	       
            <asp:dropdownlist id="REASON_NON_PAYMENT" runat="server"></asp:dropdownlist>	       
        </td>
    </tr>	
    <%--<tr id="trKriteriaMenunggak" runat="server">
	    <td class="TDBGColor1" id="tdltrKriteriaMenunggak">Loss Event</td>
	    <td>:</td>
	    <td id="tdtrKriteriaMenunggak" runat="server" class="auto-style4">
	        <asp:DropDownList ID="DDL_LossEvent" runat="server"></asp:DropDownList>
        </td>
    </tr>	--%>
	<tr id="REKOMENDASI" runat="server" style="display: block">
		<td class="TDBGColor1" id="TDL_NextAction">Rekomendasi</td>
		<td id="TDL_S8" style="WIDTH: 8px">:</td>
		<td class="auto-style4" id="TDL_NextAction1"><asp:dropdownlist id="DDL_NEXTACTION" runat="server" ></asp:dropdownlist>&nbsp;Tanggal 
			(dd-mm-yyyy) :&nbsp;
			<asp:textbox onkeypress="return numbersonly()" id="TXT_DAY_NA" runat="server" Columns="4" MaxLength="2"></asp:textbox>
			<asp:dropdownlist id="DDL_MONTH_NA" runat="server"></asp:dropdownlist>
			<asp:textbox onkeypress="return numbersonly()" id="TXT_YEAR_NA" runat="server" Columns="4" MaxLength="4"></asp:textbox>
			&nbsp;Jam(hh:mm)
			<asp:textbox onkeypress="return numbersonly()" id="TXT_HOUR_NA" runat="server" Columns="4" MaxLength="2" Text="0"></asp:textbox>:
			<asp:textbox onkeypress="return numbersonly()" id="TXT_MIN_NA" runat="server" 
                Columns="4" MaxLength="2" Text="0" Width="32px"></asp:textbox>
		</td>
	</tr>
	<tr ID="TR_DEBITUR_AMOUNT" style="display: none">
		<td class="TDBGColor1">Kemampuan Debitur
		</td>
		<td style="WIDTH: 8px">:</td>
		<td class="auto-style4">
		    <asp:textbox onkeypress="return numbersonly()" id="KEMAMPUAN_DEBITUR" runat="server" Text="0"></asp:textbox>
		</td>
	</tr>
    <tr id="JANJIBAYAR1" runat="server">
		<td class="TDBGColor1">Tipe Pembayaran</td>
		<td>:</td>
		<td>		
            <asp:dropdownlist id="DDL_PAYMENT_TYPE" runat="server"></asp:dropdownlist>
        </td>
	</tr>	
    <tr id="PickUp" runat="server">
		<td class="TDBGColor1">Pick Up Money</td>
		<td>: &nbsp;</td>
		<td runat="server">	
        <asp:Label ID="Lbl_Rp" runat="server"> Rp.</asp:Label>	
        <cc1:TXT_CURRENCY ID="PICKUP_AMOUNT" runat="server" Width="155px"></cc1:TXT_CURRENCY>
        </td>
	</tr>
    <tr id="JANJIBAYAR3" runat="server">
		<td class="TDBGColor1">Jumlah yang Akan Setor</td>
		<td>: &nbsp;</td>
		<td runat="server">		
        <cc1:TXT_CURRENCY ID="TXT_PTP_AMOUNT" runat="server" Width="155px"></cc1:TXT_CURRENCY>
        </td>
	</tr>	
    <tr ID="TR_Downolad" style="display: none">
		<td class="TDBGColor1">Cetak Tagihan
		</td>
		<td style="WIDTH: 8px">:</td>
		<td class="auto-style4">
		    <input type="button" id="btn_GenLetter" value="Download" onclick="btn_GenLetter_Click"/>
          <%-- off duulu on clicknya yg bawah --%>
<%--            <asp:button id="btn_GenLetter" runat="server" CssClass="Bt1" Text="Download" onclick="btn_GenLetter_Click"></asp:button>
        --%>
		</td>
	</tr>
	<%--<tr>
		<td class="TDBGColor1" id="TDL_NOTES">Upload File</td>
		<td id="TD_S8">&nbsp;</td>
		<td class="auto-style4" id="TDL_NOTES1">
            <uc1:UploadUserControl ID="UploadUserControl1" runat="server" />
            <uc1:GRD_Upload ID="GRD_UploadUserControl" runat="server" />
        </td>
	</tr>--%>
    <tr id="tdUploadFile" runat="server">
		<td class="TDBGColor1" id="TDL_NOTES">Upload File</td>
		<td id="TD_S8">: &nbsp;</td>
		<td class="auto-style4" id="TDL_NOTES1">
            <table cellpadding="0" cellspacing="0" border="0" width="100%"  id= "TBL_NOTES" runat="server" ClientInstanceName="TBL_NOTES" 
            OnCallback="TBL_NOTES_Callback">
                <tr style="display:">
                    <td>
                        <uc1:UploadUserControl ID="UploadUserControl1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>        
                         <%--<dxwgv:ASPxGridView ID="ASPxGridView2" ClientInstanceName="DGR_FILEUPLOAD" 
                                        runat="server" AutoGenerateColumns="True" 
                                        width="100%" onload="DGR_FILEUPLOAD_Load" 
                                        KeyFieldName="USERID">
                                        <settingsbehavior allowmultiselection="True" confirmdelete="True" />
                                    </dxwgv:ASPxGridView> --%>  

                        <dxcp:ASPxCallbackPanel ID="panelupload" runat="server" ClientInstanceName="panelupload" 
                           Width="200px" OnCallback="panelupload_Callback">
                            <PanelCollection>
                                <dxp:PanelContent runat="server">
                                    <dxwgv:ASPxGridView ID="FileUploadList" ClientInstanceName="DGR_FILEUPLOAD" 
                                        runat="server" AutoGenerateColumns="True" 
                                        width="100%" onload="DGR_FILEUPLOAD_Load" 
                                        KeyFieldName="Nama File">
                                        <settingsbehavior allowmultiselection="True" confirmdelete="True" />
                                    </dxwgv:ASPxGridView>                                                                            
                                </dxp:PanelContent>
                            </PanelCollection>
                        </dxcp:ASPxCallbackPanel>
                    </td>
                    
                </tr>
                
            </table>            
        </td>
	</tr>
	<tr id="TR_Note" runat="server">
		<td class="TDBGColor1" id="TDL_NOTE">Catatan</td>
		<td id="TD_S9">:</td>
		<td class="auto-style4" id="TDL_NOTE1"><asp:textbox id="TXT_NOTES" 
                runat="server" Width="500px" MaxLength="512" Columns="25" TextMode="MultiLine" 
                Rows="3"></asp:textbox></td>
	</tr>
	<tr>
		<td class="tdHeader1" colSpan="3">Hasil Kunjungan</td>
	</tr>
	<tr>
		<td id="TDL_VISITRESULT" colSpan="3" runat="server">
			<table id="table2" borderColor="#c0c0c0" cellSpacing="0" cellPadding="1" width="100%" border="1">
				<tr>
					<td class="TDBGColor1" id="TDL_HOUSEPHONE">Telp Rumah</td>
					<td width="1%">:</td>
					<td width="32%">
						<asp:dropdownlist id="DDL_HOUSEPHONEDESC" runat="server" >
							<asp:ListItem Value="Tetap" Selected="True">Tetap</asp:ListItem>
							<asp:ListItem Value="Berubah menjadi">Berubah menjadi</asp:ListItem>
							<asp:ListItem Value="Tidak ada">Tidak ada</asp:ListItem>
							<asp:ListItem Value="lainnya">lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:textbox id="TXT_HOUSEPHONENEW" runat="server" MaxLength="50"></asp:textbox></td>
					<td class="TDBGColor1" width="15%">Alamat Rumah</td>
					<td width="1%">:</td>
					<td width="30%">
						<asp:dropdownlist id="DDL_HOUSEADDRDESC" runat="server" Width="120px">
							<asp:ListItem Value="Tetap" Selected="True">Tetap</asp:ListItem>
							<asp:ListItem Value="Pindah ke">Pindah ke</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:TextBox id="TXT_HOUSEADDRNEW" runat="server" MaxLength="120"></asp:TextBox></td>
				</tr>
				<tr>
					<td class="TDBGColor1">Telp Kantor</td>
					<td>:</td>
					<td>
						<asp:dropdownlist id="DDL_OFFICEPHONEDESC" runat="server" >
							<asp:ListItem Value="Tetap" Selected="True">Tetap</asp:ListItem>
							<asp:ListItem Value="Berubah menjadi">Berubah menjadi</asp:ListItem>
							<asp:ListItem Value="Tidak ada">Tidak ada</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:textbox id="TXT_OFFICEPHONENEW" runat="server" MaxLength="50"></asp:textbox></td>
					<td class="TDBGColor1">Alamat Kantor</td>
					<td>:</td>
					<td>
						<asp:dropdownlist id="DDL_OFFICEADDRDESC" runat="server" Width="120px" >
							<asp:ListItem Value="Tetap" Selected="True">Tetap</asp:ListItem>
							<asp:ListItem Value="Pindah ke">Pindah ke</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:textbox id="TXT_OFFICEADDRNEW" runat="server" MaxLength="120"></asp:textbox></td>
				</tr>
				<tr>
					<td class="TDBGColor1">Telp Selular</td>
					<td>:</td>
					<td>
						<asp:dropdownlist id="DDL_HPDESC" runat="server" >
							<asp:ListItem Value="Tetap" Selected="True">Tetap</asp:ListItem>
							<asp:ListItem Value="Berubah menjadi">Berubah menjadi</asp:ListItem>
							<asp:ListItem Value="Tidak ada">Tidak ada</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:textbox id="TXT_HPNEW" runat="server" MaxLength="50"></asp:textbox></td>
					<td class="TDBGColor1">Status Jaminan</td>
					<td>:</td>
					<td>
						<asp:dropdownlist id="DDL_COLLSTATDESC" runat="server" Width="120px">
							<asp:ListItem Value="-SELECT-" Selected="True">-SELECT-</asp:ListItem>
							<asp:ListItem Value="Ditempati">Ditempati</asp:ListItem>
							<asp:ListItem Value="Kosong">Kosong</asp:ListItem>
							<asp:ListItem Value="Dikontrakkan">Dikontrakkan</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:textbox id="TXT_COLLSTATNEW" runat="server" MaxLength="100"></asp:textbox></td>
				</tr>
				<tr>
					<td class="TDBGColor1">Alamat Korespondensi</td>
					<td>:</td>
					<td>
						<asp:dropdownlist id="DDL_CORRESPADDRDESC" runat="server" Width="120px" >
							<asp:ListItem Value="Tetap" Selected="True">Tetap</asp:ListItem>
							<asp:ListItem Value="Pindah ke">Pindah ke</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:textbox id="TXT_CORRESPADDRNEW" runat="server" MaxLength="120"></asp:textbox></td>
					<td class="TDBGColor1">Kondisi Jaminan</td>
					<td>:</td>
					<td>
						<asp:dropdownlist id="DDL_COLLCONDDESC" runat="server" Width="120px">
							<asp:ListItem Value="-SELECT-" Selected="True">-SELECT-</asp:ListItem>
							<asp:ListItem Value="Terawat">Terawat</asp:ListItem>
							<asp:ListItem Value="Tidak terawat">Tidak terawat</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist>
						<asp:textbox id="TXT_COLLCONDNEW" runat="server" MaxLength="100"></asp:textbox></td>
				</tr>
				<tr>
					<td class="TDBGColor1">Surat</td>
					<td>:</td>
					<td><asp:dropdownlist id="DDL_SPADESC" runat="server">
							<asp:ListItem Value="-SELECT-" Selected="True">-SELECT-</asp:ListItem>
							<asp:ListItem Value="Sudah terima">Sudah terima</asp:ListItem>
							<asp:ListItem Value="Belum">Belum</asp:ListItem>
							<asp:ListItem Value="Lainnya">Lainnya</asp:ListItem>
						</asp:dropdownlist></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td class="TDBGColor2" id="TDL_FOOTER" align="center" colspan="3">
			<input id="btn_simpan" type="button" value="Simpan" onclick="Save();" 
                class="Bt1" style="width: 100px"/>
			<div style="display:none">
			<asp:button 
                id="BTN_SAVE_VISIT" runat="server" CssClass="Bt1" Text="Simpan" 
                onclick="BTN_SAVE_VISIT_Click"></asp:button>
            </div>
                &nbsp;
            <input type="button" id="btnHistory" runat="server" class="Bt1" 
                style="width: 100px" value="Riwayat" />

         </td>
	</tr>
</table>
<div id="divMessage" runat="server" style="width:100%"></div>
