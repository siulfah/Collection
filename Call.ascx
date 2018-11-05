<%@ Control Language="c#"  EnableViewState="true" AutoEventWireup="True" Codebehind="Call.ascx.cs" Inherits="Collection.Controls.Call" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v9.2, Version=9.2.4.0, Culture=neutral" namespace="DevExpress.Web.ASPxEditors" tagprefix="dxe" %>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral" namespace="DevExpress.Web.ASPxCallback" tagprefix="dxcb" %>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral" namespace="DevExpress.Web.ASPxPanel" tagprefix="dxp" %>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral" namespace="DevExpress.Web.ASPxCallbackPanel" tagprefix="dxcp" %>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dxpc" %>
<%@ Register assembly="DevExpress.Web.v9.2, Version=9.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxLoadingPanel" tagprefix="dxlp" %>
<%@ Register assembly="DMSControls" namespace="DMSControls" tagprefix="cc1" %>

<%@ Register src="../UserControl/USC_DDL_Cascade.ascx" tagname="USC_DDL_Cascade" tagprefix="uc1" %>


<%@ Register assembly="DevExpress.Web.v9.2" namespace="DevExpress.Web.ASPxPanel" tagprefix="dxp" %>
<%@ Register assembly="DevExpress.Web.v9.2" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dxpc" %>


<%--<%@ Register assembly="DevExpress.Web.v9.2" namespace="DevExpress.Web.ASPxPanel" tagprefix="dxp" %>
<%@ Register assembly="DevExpress.Web.v9.2" namespace="DevExpress.Web.ASPxPopupControl" tagprefix="dxpc" %>--%>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
</style>


<script type="text/javascript" language="javascript">
    var CallStateID = 0;
    function ResultChange(svalue) {

        //SELECT ADDDATE('2008-01-02', INTERVAL 31 DAY);
        //-> '2008-02-02'
        if (svalue == "R0020" || svalue == "R0013")
        {
            document.getElementById("<%=JANJIBAYAR1.ClientID %>").style.display = "";
            document.getElementById("<%=JANJIBAYAR2.ClientID %>").style.display = "";
            document.getElementById("<%=JANJIBAYAR3.ClientID %>").style.display = "";
            document.getElementById("<%=RESULT_DATE.ClientID %>_DD").className = "mandatory";
            document.getElementById("<%=RESULT_DATE.ClientID %>_MM").className = "mandatory";
            document.getElementById("<%=RESULT_DATE.ClientID %>_YY").className = "mandatory";
            document.getElementById("<%=TXT_PTP_AMOUNT.ClientID %>").className = "mandatory";
            document.getElementById("<%=DDL_PAYMENT_TYPE.ClientID %>").className = "mandatory";
            document.getElementById("<%=TRL_NEXTACTION.ClientID %>").style.display = "none";
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID%>").style.display = "none";
            document.getElementById("<%=TR_NOTES.ClientID%>").style.display = "none";
        }
        else if (svalue == "R0025") {
            document.getElementById("<%=JANJIBAYAR1.ClientID %>").style.display = ""
            document.getElementById("<%=JANJIBAYAR2.ClientID %>").style.display = "none"
            document.getElementById("<%=JANJIBAYAR3.ClientID %>").style.display = "none"
            document.getElementById("<%=RESULT_DATE.ClientID %>_DD").style.display = "none"
            document.getElementById("<%=RESULT_DATE.ClientID %>_MM").style.display = "none"
            document.getElementById("<%=RESULT_DATE.ClientID %>_YY").style.display = "none"
            document.getElementById("<%=TXT_PTP_AMOUNT.ClientID %>").style.display = "none"
            document.getElementById("<%=DDL_PAYMENT_TYPE.ClientID %>").style.display = ""
            document.getElementById("<%=TRL_NEXTACTION.ClientID %>").style.display = "none";
            document.getElementById("<%=REASON_NON_PAYMENT.ClientID%>").style.display = "none"
            document.getElementById("<%=TR_NOTES.ClientID%>").style.display = "none"
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_ResultDate.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_ResultTime.ClientID %>").style.display = "none";
            document.getElementById("<%=RESULT_HH.ClientID %>").style.display = "none";
            document.getElementById("<%=RESULT_MM.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_Sparator.ClientID %>").style.display = "none";
        }
        else if (svalue == "R0014"||svalue == "R0015"||svalue == "R0022"||svalue == "R0030") {
            document.getElementById("<%=JANJIBAYAR1.ClientID %>").style.display = "none"
            document.getElementById("<%=JANJIBAYAR2.ClientID %>").style.display = "none"
            document.getElementById("<%=JANJIBAYAR3.ClientID %>").style.display = "none"
            document.getElementById("<%=RESULT_DATE.ClientID %>_DD").style.display = "none"
            document.getElementById("<%=RESULT_DATE.ClientID %>_MM").style.display = "none"
            document.getElementById("<%=RESULT_DATE.ClientID %>_YY").style.display = "none"
            document.getElementById("<%=TXT_PTP_AMOUNT.ClientID %>").style.display = "none"
            document.getElementById("<%=DDL_PAYMENT_TYPE.ClientID %>").style.display = "none"
            document.getElementById("<%=TRL_NEXTACTION.ClientID %>").style.display = "none";
            document.getElementById("<%=REASON_NON_PAYMENT.ClientID%>").style.display = "none"
            document.getElementById("<%=TR_NOTES.ClientID%>").style.display = "none"
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_ResultDate.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_ResultTime.ClientID %>").style.display = "none";
            document.getElementById("<%=RESULT_HH.ClientID %>").style.display = "none";
            document.getElementById("<%=RESULT_MM.ClientID %>").style.display = "none";
            document.getElementById("<%=Lbl_Sparator.ClientID %>").style.display = "none";
        }
        else if (svalue == "R0018" || svalue == "R0026") {
            document.getElementById("<%=JANJIBAYAR1.ClientID %>").style.display = "none";
            document.getElementById("<%=JANJIBAYAR2.ClientID %>").style.display = "none";
            document.getElementById("<%=JANJIBAYAR3.ClientID %>").style.display = "none";
            document.getElementById("<%=RESULT_DATE.ClientID %>_DD").style.display = "";
            document.getElementById("<%=RESULT_DATE.ClientID %>_MM").style.display = "";
            document.getElementById("<%=RESULT_DATE.ClientID %>_YY").style.display = "";
            document.getElementById("<%=TXT_PTP_AMOUNT.ClientID %>").style.display = "none";
            document.getElementById("<%=DDL_PAYMENT_TYPE.ClientID %>").style.display = "none";
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID %>").style.display = "none";
            document.getElementById("<%=TR_NOTES.ClientID %>").style.display = "none";
            document.getElementById("<%=REASONFORNONPAYMENT.ClientID %>").style.display = "none";
            document.getElementById("<%=TRL_NEXTACTION.ClientID %>").className = "";
            document.getElementById("<%=REASON_NON_PAYMENT.ClientID%>").style.display = "none";
        }
        else {
            document.getElementById("<%=JANJIBAYAR1.ClientID %>").style.display = "none";
            document.getElementById("<%=JANJIBAYAR2.ClientID %>").style.display = "none";
            document.getElementById("<%=JANJIBAYAR3.ClientID %>").style.display = "none";
            document.getElementById("<%=RESULT_DATE.ClientID %>_DD").className = "";
            document.getElementById("<%=RESULT_DATE.ClientID %>_MM").className = "";
            document.getElementById("<%=RESULT_DATE.ClientID %>_YY").className = "";
            document.getElementById("<%=TXT_PTP_AMOUNT.ClientID %>").className = "";
            document.getElementById("<%=DDL_PAYMENT_TYPE.ClientID %>").className = "";
        }
        parent.resizeFrame();
    }

    function next_change()
    {
       if(document.getElementById("<%=DDL_NEXT_ACT.ClientID%>").value=="00021")
        {
            document.getElementById("TR_DEBITUR_AMOUNT").style.display="block";
        }
        else
        {
            document.getElementById("TR_DEBITUR_AMOUNT").style.display="none";
        }
    }
    
    function CheckCallSta() {
        var hdnCalledNum = document.getElementById("<%=hdnCalledNum.ClientID %>");
        CTICallBack.PerformCallback('state:');

        var test = document.getElementById("test");
        test.value = parseInt(test.value) + 1;
    }

    function DialHangup() {

        var cc_id = document.getElementById('<%=CC_ID.ClientID%>').value;
        var act = document.getElementById('<%=btnDialHangup.ClientID%>').value;
        var btnDialHangup = document.getElementById('<%=btnDialHangup.ClientID %>');
        if (cc_id == '' || cc_id==-1) {
            alert('Pilih nomor yang akan dihubungi');
            return;
        }
        if (btnDialHangup.value.toUpperCase() == 'DIAL') {            
            document.getElementById('<%=lblMsg.ClientID %>').InnerHTML = '';
            document.getElementById('<%=hdnCallID.ClientID %>').value = '';
            document.getElementById('<%=hdnRequestID.ClientID %>').value = '';
            document.getElementById('<%=hdnCalledNum.ClientID %>').value = '';
        }
        clearTimeout(CallStateID);
        btnDialHangup.disabled = true;
        CTICallBack.PerformCallback(act+':');
    }
    function OnDialCallbackComplete(s, e) {
        var btnDialHangup = document.getElementById('<%=btnDialHangup.ClientID %>');
        var lblMsg = document.getElementById('<%=lblMsg.ClientID %>');
        var hdnCallID = document.getElementById('<%=hdnCallID.ClientID %>');
        var hdnRequestID = document.getElementById('<%=hdnRequestID.ClientID %>');
        var hdnCalledNum = document.getElementById('<%=hdnCalledNum.ClientID %>');
        var hdnLastState = document.getElementById('<%=hdnLastState.ClientID %>');
        
        var arg = e.result.split(':');
        var callState = arg[0];
        var callID = arg[1];
        var requestID = arg[2];
        var calledNum = arg[3];
        var errMsg = arg[4];
        clearTimeout(CallStateID);
        if (callState.toUpperCase() != 'DIAL') { //&& callID!=''
            CallStateID = setTimeout('CheckCallSta()', 2000);
            hdnCallID.value = callID;
            hdnRequestID.value = requestID;
            hdnCalledNum.value = calledNum;
            hdnLastState.value = callState;
        }        
        btnDialHangup.disabled = TRUE;
        btnDialHangup.value = callState;
        lblMsg.InnerHTML = 'Error:' + errMsg;
        if (errMsg != "") {
            alert(errMsg);
        }
    }

    function ClearNewContact() {
        document.getElementById('<%=CC_CONTACTTYPE.ClientID %>').value = '';
        document.getElementById('<%=CC_CONTACTAREA.ClientID %>').value = '';
        document.getElementById('<%=CC_CONTACTNO.ClientID %>').value = '';
        document.getElementById('<%=CC_CONTACTEXT.ClientID %>').value = '';
    }
    function ShowWindowByName(name, x, y) {
        var window = popupControl.GetWindowByName(name);
        if (name == 'winCallScript') {
            popupControl.SetWindowSize(window, 350, 250);
        } else if (name == 'winAddContact') {
            popupControl.SetWindowSize(window, 450, 50);
            ClearNewContact();
        }
        popupControl.ShowWindowAtElementByID(window, element);
        popupControl.ShowWindowAtPos(window, x, y);
    } 

    function HideWindow(name) {
        var window = popupControl.GetWindowByName(name);
        popupControl.HideWindow(window);
    }

    function ShowScript() {
        
        var DDL_ContactNo = document.getElementById("<%=btnScript.ClientID%>");
        var xpos = findPosX(DDL_ContactNo);
        var ypos = findPosY(DDL_ContactNo);
        ShowWindowByName('winCallScript', xpos + DDL_ContactNo.offsetWidth, ypos);
    }
    function ShowAddContact() {
        var btnAddContact = document.getElementById("btnAddContact");
        var xpos = findPosX(btnAddContact);
        var ypos = findPosY(btnAddContact);
        ShowWindowByName('winAddContact', xpos + btnAddContact.offsetWidth, ypos);

    }
    function ddlContactChange(cc_id) {
        document.getElementById('<%=CC_ID.ClientID %>').value = cc_id;
    }

    function SaveContact() {
        var cc_type = document.getElementById('<%=CC_CONTACTTYPE.ClientID %>').value;
        var cc_name = document.getElementById('<%=CC_CONTACTNAME.ClientID %>').value;
        var cc_no = document.getElementById('<%=CC_CONTACTNO.ClientID %>').value;
        if(cc_type=='' || cc_name=='' || cc_no==''){
        
            alert('Jenis contact, Nama contact, Nomor Contact Harus diisi!!!');
            return;
        }
        Callback1.PerformCallback('sc:')
    }

</script>
<table id="tblCallInput" borderColor="#c0c0c0" cellspacing="0" cellpadding="1" width="100%" border="1">
	<tr id="TRL_CALLAIM" runat="server">
		<td class="TDBGColor1" id="TDL_AIM" width="13%">Tujuan</td>
		<td id="TDL_S0" width="1%">:</td>
		<td id="TDL_AIM1" runat="server">
            <asp:dropdownlist id="TUJUAN" runat="server" 
                CssClass="mandatory">
			</asp:dropdownlist>			
	    </td>
	</tr>
	<tr id="TRL_CONTACTNO" runat="server">
		<td class="TDBGColor1" id="TDL_CONTACTNO">No. yang dihubungi</td>
		<td id="TDL_S1">:</td>
		<td id="TDL_CONTACTNO1" runat="server">
		    <table style="border-style: none; border-color: inherit; border-width: 0px; padding: 0px;" class="auto-style1">		    
		        <tr>
		            <td style="width:1px;">
		                <dxcp:ASPxCallbackPanel ID="pnlContact" ClientInstanceName="pnlContact" runat="server"
		                    OnCallback="pnlContact_Callback" Width="100%" 
                            HideContentOnCallback="False">
		                    <PanelCollection>
		                        <dxp:PanelContent runat="server">
		                            <asp:dropdownlist id="DDL_ContactNo" runat="server" CssClass="mandatory" onclick="ddlContactChange(this.value);"></asp:dropdownlist>        
		                        </dxp:PanelContent>
		                    </PanelCollection>
		                    <ClientSideEvents EndCallback="function(s,e){
		                        
		                    }" 
		                    
		                    />
		                </dxcp:ASPxCallbackPanel>		                
		                <input type="text" id="CC_ID" runat="server" style="display:none;"/>
		            </td>
		            <td style="width:1px;">
		                <%--<input type="button" id="btnAddContact" value="Add Contact" onclick="ShowAddContact();"/>--%>
                        <input type="button" id="btnAddContact" value="Add Contact" onclick="PopupPage('../CommonPage/List.aspx?ControlID=00015&ControlParent=&ACC=<%= Request.QueryString["ACC"] %>    &CUST=<%= Request.QueryString["CUST"] %>    '),600,400"/>
		            </td>
		            <td id="tdDial">
                        <input type="button" id="btnDialHangup" runat="server" onclick="DialHangup();" style=""  value="Dial"/>                                        
		            </td>
		            <td style="text-align:left;">		                
		                <input type="text" id="hdnCallID" runat="server" style="display:none;"/>	                
		                <input type="text" id="hdnRequestID" runat="server" style="display:none;" />	 
		                <input type="text" id="hdnCalledNum" runat="server" style="display:none;"/>  
		                <input type="text" id="hdnTelePrefixNum" runat="server" style="display:none;"/>
		                <input type="text" id="hdnLastState"  runat="server" style="display:none;"/>
		                <input type="text" id="test" value="0" style="display:none;"/>
		                
		                <div id="lblMsg" runat="server" style="width:100%;"></div>	
		            </td>
		        </tr>
		    </table>		    
        </td>
	</tr>
	<tr>
		<td class="TDBGColor1">Berbicara dengan</td>
		<td>:</td>
		<td>
		    <asp:textbox id="TXT_SpokeTo" runat="server" Width="152px" Columns="25" MaxLength="100"></asp:textbox>
            <input type="button" id="btnScript" value="Show Script" runat="server" onclick="ShowScript();" class="Bt1"/>
        </td>
	</tr>
	<tr id="TRL_RELATIONSHIP" runat="server">
		<td class="TDBGColor1" id="TDL_RELATIONSHIP">Hubungan</td>
		<td id="TD_S2">:</td>
		<td id="TDL_REL1" runat="server">
            <uc1:USC_DDL_Cascade ID="RELATIONSHIP" runat="server" />
        </td>
	</tr>
	<tr id="TRL_RESULT" runat="server">
		<td class="TDBGColor1" id="TDL_RESULT">Hasil call</td>
		<td id="TD_S4">:</td>
		<td id="TDL_RES1" runat="server">
		    <uc1:USC_DDL_Cascade ID="RESULT" runat="server" style="display:block;"/>&nbsp;		    
            <asp:Label ID="Lbl_ResultDate"  runat="server"> Tanggal (dd-mm-yyyy)</asp:Label>
                &nbsp;:<cc1:CC_Date ID="RESULT_DATE" runat="server" ImgShown="false" />&nbsp;
            <asp:Label ID="Lbl_ResultTime"  runat="server">Jam(hh:mm)</asp:Label>
			<asp:textbox onkeypress="return numbersonly();" onblur="CheckTime(this,null,null);" id="RESULT_HH" runat="server" 
                Columns="4" MaxLength="2" Text="0"></asp:textbox>
            <asp:Label ID="Lbl_Sparator" runat="server">:</asp:Label>
			<asp:textbox onkeypress="return numbersonly();" onblur="CheckTime(null,this,null);" id="RESULT_MM" runat="server" 
                Columns="4" MaxLength="2" Text="0"></asp:textbox></td>
	</tr>	
	<tr id="JANJIBAYAR1" runat="server">
		<td class="TDBGColor1">Tipe Pembayaran</td>
		<td>:</td>
		<td>		
            <asp:dropdownlist id="DDL_PAYMENT_TYPE" runat="server" CssClass="mandatory"></asp:dropdownlist>
        </td>
	</tr>	
	<tr id="JANJIBAYAR2" runat="server">
		<td class="TDBGColor1">Orang yang Akan Setor</td>
		<td>:</td>
		<td>		
            <asp:dropdownlist id="DDL_PTP_PERSON" runat="server"></asp:dropdownlist>
        </td>
	</tr>	
	<tr id="JANJIBAYAR3" runat="server">
		<td class="TDBGColor1">Jumlah yang Akan Setor</td>
		<td>&nbsp;</td>
		<td runat="server">		
        <cc1:TXT_CURRENCY ID="TXT_PTP_AMOUNT" runat="server" Width="155px"></cc1:TXT_CURRENCY>
        </td>
	</tr>	
	
	<tr id="REASONFORNONPAYMENT" runat="server">
		<td class="TDBGColor1" id="TDL_REASONFORNONPAYMENT">Alasan tidak bayar</td>
		<td id="TD_S5">:</td>
		<td id="TDL_REASON1" runat="server">
            
            <asp:dropdownlist id="REASON_NON_PAYMENT" runat="server" CssClass="mandatory"></asp:dropdownlist>
            
        </td>
	</tr>
	<tr id="TRL_NEXTACTION" runat="server">
		<td class="TDBGColor1" id="TDL_NEXTACTION">Rekomendasi</td>
		<td id="TD_S6">:</td>
		<td id="TDL_NEXT1" runat="server">
		    <asp:dropdownlist id="DDL_NEXT_ACT" 
                runat="server" Width="176px"></asp:dropdownlist>&nbsp;Tanggal 
			(dd-mm-yyyy) :
			        <cc1:CC_Date ID="DATE_ACTION" runat="server" ImgShown="false" />
			&nbsp;Jam(hh:mm)
			<asp:textbox onkeypress="return numbersonly();" onblur="CheckTime(this,null,null);" id="NEXT_HH" runat="server" 
                Columns="4" MaxLength="2" Text="0"></asp:textbox>:
			<asp:textbox onkeypress="return numbersonly();" onblur="CheckTime(null,this,null);" id="NEXT_MM" runat="server" 
                Columns="4" MaxLength="2" Text="0"></asp:textbox>
			
			</td>
	</tr>
	<tr ID="TR_DEBITUR_AMOUNT" style="display: none">
		<td class="TDBGColor1">Kemampuan Debitur
		</td>
		<td style="WIDTH: 8px">:</td>
		<td class="TDBGColorValue">
		    <%--<asp:textbox onkeypress="return numbersonly()" id="KEMAMPUAN_DEBITUR" runat="server" Text="0"></asp:textbox>  --%>
            <cc1:TXT_CURRENCY ID="KEMAMPUAN_DEBITUR" runat="server" Width="155px"></cc1:TXT_CURRENCY>
		</td>
	</tr>
	<tr id="TR_NOTES" runat="server">
		<td class="TDBGColor1">Catatan</td>
		<td>:</td>
		<td><asp:textbox id="TXT_NOTES" runat="server" Width="500px" Columns="25" 
                MaxLength="512" Height="45px"
				TextMode="MultiLine" CssClass="mandatory"></asp:textbox></td>
	</tr>
	<tr>
		<td class="tdHeader1" align="left" colSpan="3">Hasil Call</td>
	</tr>
	<tr>
		<td align="left" colSpan="3">

			<table id="table2" borderColor="#c0c0c0" cellSpacing="0" cellPadding="1" width="100%" border="1">
				<tr>
					<td class="TDBGColor1" id="TDL_HOUSEPHONE">Telp Rumah</td>
					<td width="1%">:</td>
					<td width="32%">
					    <asp:dropdownlist id="DDL_HMPHNSTA" runat="server" Width="121px"></asp:dropdownlist>
					    <asp:textbox id="TXT_HOUSEPHONEAREA" runat="server" MaxLength="10" Width="50px"></asp:textbox>-
					    <asp:textbox id="TXT_HOUSEPHONENEW" runat="server" MaxLength="20" Width="100px"></asp:textbox>
					</td>
					<td colspan="3" rowspan="2" valign="top">
                        <asp:GridView ID="gvCollateral" runat="server" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="COLID" Visible="True" />
                                <asp:BoundField DataField="NomorJaminan" HeaderText="Nomor Jaminan" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="DDL_COLLSTA" runat="server">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Kondisi">
                                    <ItemTemplate>
                                        <asp:DropDownList id="DDL_COLLCOND" runat="server">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>						
				</tr>
				<tr>
					<td class="TDBGColor1">Telp Kantor</td>
					<td>:</td>
					<td>
					    <asp:dropdownlist id="DDL_OFFPHNSTA" runat="server" Width="121px"></asp:dropdownlist>
					    <asp:textbox id="TXT_OFFICEPHONEAREA" runat="server" MaxLength="10" Width="50px"></asp:textbox>-
					    <asp:textbox id="TXT_OFFICEPHONENEW" runat="server" MaxLength="20" Width="100px"></asp:textbox>
					 </td>
				</tr>
				<tr>
					<td class="TDBGColor1">Telp Selular</td>
					<td>:</td>
					<td>
					    <asp:dropdownlist id="DDL_HPSTA" runat="server" Width="121px"></asp:dropdownlist>
						<asp:textbox id="TXT_HPNEW" runat="server" MaxLength="50"></asp:textbox>
				    </td>
					<td class="TDBGColor1">Alamat Kantor</td>
					<td>:</td>
					<td>
					    <asp:dropdownlist id="DDL_OFFICEADDRSTA" runat="server" Width="121px"></asp:dropdownlist>
						<asp:textbox id="TXT_OFFICEADDRNEW" runat="server" MaxLength="120"></asp:textbox>
					</td>				    
				</tr>
				<tr>
					<td class="TDBGColor1">Alamat Korespondensi</td>
					<td>:</td>
					<td>   
				        <table cellpadding="0" cellspacing="0" border="0" width="100%">
				            <tr>
				                <td width="121px">
				                    <asp:dropdownlist id="DDL_CORRESPADDRSTA" runat="server" Width="121px">
						            </asp:dropdownlist>
						        </td>
						        <td>
						            <asp:textbox id="TXT_CORRESPADDRNEW" runat="server" MaxLength="40" 
                                        Width="100%"></asp:textbox>
						        </td>
				            </tr>
				            <tr style="display:">
				                <td></td>
				                <td><asp:TextBox ID="TXT_CORRESPADDRNEW2" runat="server" MaxLength="40" 
                                        Height="22px" Width="100%"></asp:TextBox></td>
				            </tr>
				            <tr style="display:">
				                <td>Kota</td>
				                <td>
				                    <asp:TextBox ID="TXT_CORRESPCITY" runat="server" MaxLength="40" 
                                        Height="22px" Width="100%"></asp:TextBox>
				                </td>
				            </tr> 
				            <tr>
				                <td>Kode Pos</td>
				                <td>
				                    <asp:TextBox ID="TXT_CORRESPADDRKODEPOS" runat="server" MaxLength="120" 
                                        Width="100px"></asp:TextBox>
				                </td>
				            </tr>
				        </table>
				    </td>
					<td class="TDBGColor1">Alamat Rumah</td>
					<td>:</td>
					<td valign="top">
					    <table cellpadding="0" cellspacing="0" border="0" width="100%" >
					        <tr>
					            <td width="121PX">
					                <asp:dropdownlist id="DDL_HOUSEADDRSTA" runat="server" Width="121px">
							        </asp:dropdownlist>
						        </td>
						        <td>
						            <asp:textbox id="TXT_HOUSEADDRNEW" runat="server" MaxLength="40" Width="100%"></asp:textbox>
						        </td>
					        </tr>
					        <tr>
					            <td></td>
					            <td>
					                <asp:TextBox ID="TXT_HOUSEADDRNEW2" runat="server" MaxLength="40" Width="100%"></asp:TextBox>
					            </td>
					        </tr>
					        <tr>
					            <td>Kota</td>
					            <td>
					                <asp:TextBox ID="TXT_HOUSECITY" runat="server" MaxLength="40" Width="100%"></asp:TextBox>
					            </td>
					        </tr>
					        <tr>
				                <td>Kode Pos</td>
				                <td>
				                    <asp:TextBox ID="TXT_HOUSEZIPCODE" runat="server" MaxLength="120"></asp:TextBox>
				                </td>
				            </tr>
					    </table>
					</td>
				</tr>
				<tr>
					<td class="TDBGColor1">Surat</td>
					<td>:</td>
					<td>
					    <asp:dropdownlist id="DDL_SPADESC" runat="server">
						</asp:dropdownlist>
					</td>
			        <td colspan="3">
			        </td>
				</tr>
			</table>

		</td>
	</tr>
	<tr id="TRL_FOOTER" runat="server">
		<td class="TDBGColor2" id="TDL_FOOTER" align="center" colspan="3">
            <asp:button id="btnSave" runat="server" CssClass="Bt1" 
                Text="Simpan " onclick="btnSave_Click"></asp:button>
            &nbsp;
            <input type="button" id="btnHistory" runat="server" class="Bt1" 
                style="width: 100px" value="Riwayat"></input>
        </td>
	</tr>
</table>

<dxpc:ASPxPopupControl ID="popupControl" runat="server" 
    ClientInstanceName="popupControl" CloseAction="CloseButton" 
    HeaderText="Skrip Telepon" Width="350px" AllowDragging="True" 
    AllowResize="True" Height="250px">
    <ContentCollection>
        <dxpc:PopupControlContentControl runat="server">    
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <Windows>
        <dxpc:PopupWindow Name="winCallScript" HeaderText="Call Script">
            <ContentCollection>
                <dxpc:PopupControlContentControl runat="server">
                    <div id="divScript" runat="server"></div>
                </dxpc:PopupControlContentControl>
            </ContentCollection>
        </dxpc:PopupWindow>
        <dxpc:PopupWindow Name="winAddContact" HeaderText="Quict Add Contact">
            <ContentCollection>
                <dxpc:PopupControlContentControl runat="server">
                    <table style="border:solid 1px;padding:0px 0px 0px 0px; width:100%">
                    <tr>
                        <td class="B01">Tipe Telepon</td>
                        <td class="BS">:</td>
                        <td class="B11">
                            <asp:DropDownList ID="CC_CONTACTTYPE" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="B01">Nama contact</td>
                        <td class="BS">:</td>
                        <td class="B11">
                            <input type="text" runat="server" id="CC_CONTACTNAME" style="width:100px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="B01">Nomor contact</td>
                        <td class="BS">:</td>
                        <td class="B11">
                            <input type="text" runat="server" id="CC_CONTACTAREA" style="width:30px" onkeypress="return numbersonly();"/>-
                            <input type="text" runat="server" id="CC_CONTACTNO" style="width:150px;" onkeypress="return numbersonly();"/>-
                            &nbsp;
                            <input type="text" runat="server" id="CC_CONTACTEXT" style="width:30px" onkeypress="return numbersonly();"/>                                                
                        &nbsp;                                                
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <input type="button" runat="server" id="btnSaveContact" value="Save" onclick="SaveContact();"/>
                        </td>
                    </tr>
                    </table>                                        
                </dxpc:PopupControlContentControl>
            </ContentCollection>
        </dxpc:PopupWindow>
    </Windows>
</dxpc:ASPxPopupControl>

<dxlp:ASPxLoadingPanel ID="LoadingPanel1" ClientInstanceName="LoadingPanel1" runat="server" 
    Text="Dialing&amp;hellip;" ContainerElementID="tdDial" 
    HorizontalAlign="Right" HorizontalOffset="10">
</dxlp:ASPxLoadingPanel>
<dxcb:ASPxCallback ID="Callback1" ClientInstanceName="Callback1" runat="server"
    OnCallback="Callback1_Callback">
    <ClientSideEvents CallbackComplete="function(s,e){
        HideWindow('winAddContact');
        pnlContact.PerformCallback('r:');
    }
    "/>
</dxcb:ASPxCallback>
<dxcb:ASPxCallback ID="CTICallBack" runat="server" ClientInstanceName="CTICallBack" OnCallback="CTICallBack_Callback" >
    <ClientSideEvents 
        CallbackComplete="function(s, e) {
	OnDialCallbackComplete(s,e);
	LoadingPanel1.Hide();
}" 
        EndCallback="function(s,e){
	LoadingPanel1.Hide();
}"
                                
        BeginCallback="function(s,e){
	LoadingPanel1.Show();
}" 
        CallbackError="function(s, e) {
	LoadingPanel1.Hide();
}"
/>
</dxcb:ASPxCallback>


