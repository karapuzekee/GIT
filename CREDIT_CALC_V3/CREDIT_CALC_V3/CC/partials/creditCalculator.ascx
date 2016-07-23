<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="creditCalculator.ascx.cs" Inherits="CREDIT_CALC_V3.CC.partials.creditCalculator" %>
<asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    <Scripts>
        
        <asp:ScriptReference Path="../../Scripts/jquery.1.11.3.js" />
        <asp:ScriptReference Path="../../Scripts/moment-with-locales.js" />

        <asp:ScriptReference Path="../../Scripts/knockout-3.4.0.debug.js" />
        <asp:ScriptReference Path="../../Scripts/ko.mapping.js" />
        <asp:ScriptReference Path="../../Scripts/knockout.validation.js" />
        <asp:ScriptReference Path="../../Scripts/ko.plus.js" />
        <asp:ScriptReference Path="../../Scripts/knockout.punches.js" />

    </Scripts>
</asp:ScriptManagerProxy>
