<%@ Control Language="c#" AutoEventWireup="True" Codebehind="SuratPeringatan.ascx.cs" Inherits="Collection.Controls.SuratPeringatan" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE id="Table40" cellSpacing="0" cellPadding="0" width="100%">
	<tr>
		<td class="TDBGColor1" width="30%" >No. Surat</td>
		<td width="1px" >:</td>
		<td >
		    <asp:textbox id="TxtNoSurat" runat="server" width="18%"></asp:textbox>
		</td>
	</tr>
    <tr>
		<td class="TDBGColor1" width="30%" >Divisi</td>
		<td width="1px" >:</td>
		<td >
		    <asp:textbox id="TxtDivisi" runat="server" width="18%"></asp:textbox>
		</td>
	</tr>
    <tr>
		<td class="TDBGColor1" id="tdL_Tembusan">Tembusan</td>
		<td>:</td>
		<td>
		    <asp:textbox id="TxtTembusan" runat="server" Width="100%" Rows="4" TextMode="MultiLine" MaxLength="2000"></asp:textbox>
		</td>
	</tr>
    <tr>
		<td class="TDBGColor1" width="30%" >Jenis Surat</td>
		<td width="1px" >:</td>
		<td >
		    <asp:dropdownlist id="DDL_LETTER_TYPE" runat="server" CssClass="mandatory" >
		    </asp:dropdownlist>
			</td>
	</tr>
	<tr>
		<td class="TDBGColor1" id="tdL_NOTES">Catatan</td>
		<td>:</td>
		<td>
		    <asp:textbox id="TXT_NOTES" runat="server" Width="100%" Rows="4" TextMode="MultiLine" MaxLength="2000"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="tdBGColor2" id="tdL_FOOTER" align="center" colSpan="3">
            &nbsp;
            <asp:button 
                id="BTN_SAVE" runat="server" CssClass="Bt1" Text="Simpan" 
                onclick="BTN_SAVE_Click"></asp:button>
            &nbsp;
            <asp:button 
                id="btn_GenLetter" runat="server" CssClass="Bt1" Text="Generate" 
                onclick="BTN_Gen_Click"></asp:button>
            &nbsp;
            <asp:button id="BTN_HISTORY" 
                runat="server" CssClass="Bt1" Text="Riwayat" onclick="BTN_HISTORY_Click" 
                Visible="False" Height="26px"></asp:button>
            <asp:button id="btnHistory" runat="server" CssClass="Bt1" Text="Riwayat" 
                UseSubmitBehavior="False"></asp:button>
        </td>
	</tr>
</TABLE>
<div id="divMessage" runat="server" style="width:100%"></div>