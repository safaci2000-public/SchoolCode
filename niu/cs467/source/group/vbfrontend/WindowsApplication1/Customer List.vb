Public Class Customer_List
    Inherits System.Windows.Forms.Form

#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents connect As System.Data.OleDb.OleDbConnection
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents Data1 As System.Data.DataSet
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents Grid1 As System.Windows.Forms.DataGrid
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Customer_List))
        Me.connect = New System.Data.OleDb.OleDbConnection()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.Data1 = New System.Data.DataSet()
        Me.Grid1 = New System.Windows.Forms.DataGrid()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'connect
        '
        Me.connect.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Password="""";User ID=Admin;Data Source=groupdb.md" & _
        "b;Mode=Share Deny None;Extended Properties="""";Jet OLEDB:System database="""";Jet O" & _
        "LEDB:Registry Path="""";Jet OLEDB:Database Password="""";Jet OLEDB:Engine Type=5;Jet" & _
        " OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Glo" & _
        "bal Bulk Transactions=1;Jet OLEDB:New Database Password="""";Jet OLEDB:Create Syst" & _
        "em Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don't Copy Locale o" & _
        "n Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=Fal" & _
        "se"
        '
        'Adapter1
        '
        Me.Adapter1.DeleteCommand = Me.OleDbDeleteCommand1
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "CUSTOMER", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("CUSTOMER-NUMBER", "CUSTOMER-NUMBER"), New System.Data.Common.DataColumnMapping("CUSTOMER-LAST-NAME", "CUSTOMER-LAST-NAME"), New System.Data.Common.DataColumnMapping("CUSTOMER-FIRST-NAME", "CUSTOMER-FIRST-NAME"), New System.Data.Common.DataColumnMapping("CUSTOMER-STREET", "CUSTOMER-STREET"), New System.Data.Common.DataColumnMapping("CUSTOMER-CITY", "CUSTOMER-CITY"), New System.Data.Common.DataColumnMapping("CUSTOMER-STATE", "CUSTOMER-STATE"), New System.Data.Common.DataColumnMapping("CUSTOMER-ZIP", "CUSTOMER-ZIP"), New System.Data.Common.DataColumnMapping("CUSTOMER-PHONE-NUMBER", "CUSTOMER-PHONE-NUMBER"), New System.Data.Common.DataColumnMapping("CUSTOMER-PREVIOUS-BALANCE", "CUSTOMER-PREVIOUS-BALANCE"), New System.Data.Common.DataColumnMapping("CUSTOMER-NEW-BALANCE-OWED", "CUSTOMER-NEW-BALANCE-OWED")})})
        Me.Adapter1.UpdateCommand = Me.OleDbUpdateCommand1
        '
        'OleDbDeleteCommand1
        '
        Me.OleDbDeleteCommand1.CommandText = "DELETE FROM CUSTOMER WHERE ([CUSTOMER-NUMBER] = ?) AND ([CUSTOMER-CITY] = ? OR ? " & _
        "IS NULL AND [CUSTOMER-CITY] IS NULL) AND ([CUSTOMER-FIRST-NAME] = ? OR ? IS NULL" & _
        " AND [CUSTOMER-FIRST-NAME] IS NULL) AND ([CUSTOMER-LAST-NAME] = ? OR ? IS NULL A" & _
        "ND [CUSTOMER-LAST-NAME] IS NULL) AND ([CUSTOMER-NEW-BALANCE-OWED] = ? OR ? IS NU" & _
        "LL AND [CUSTOMER-NEW-BALANCE-OWED] IS NULL) AND ([CUSTOMER-PHONE-NUMBER] = ? OR " & _
        "? IS NULL AND [CUSTOMER-PHONE-NUMBER] IS NULL) AND ([CUSTOMER-PREVIOUS-BALANCE] " & _
        "= ? OR ? IS NULL AND [CUSTOMER-PREVIOUS-BALANCE] IS NULL) AND ([CUSTOMER-STATE] " & _
        "= ? OR ? IS NULL AND [CUSTOMER-STATE] IS NULL) AND ([CUSTOMER-STREET] = ? OR ? I" & _
        "S NULL AND [CUSTOMER-STREET] IS NULL) AND ([CUSTOMER-ZIP] = ? OR ? IS NULL AND [" & _
        "CUSTOMER-ZIP] IS NULL)"
        Me.OleDbDeleteCommand1.Connection = Me.connect
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-CITY", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-CITY", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-CITY1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-CITY", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-FIRST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-FIRST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-FIRST-NAME1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-FIRST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-LAST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-LAST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-LAST-NAME1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-LAST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PHONE-NUMBER", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-PHONE-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PHONE-NUMBER1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-PHONE-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STATE", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STATE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STATE1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STATE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STREET", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STREET", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STREET1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STREET", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-ZIP", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-ZIP", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-ZIP1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-ZIP", System.Data.DataRowVersion.Original, Nothing))
        '
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO CUSTOMER([CUSTOMER-CITY], [CUSTOMER-FIRST-NAME], [CUSTOMER-LAST-NAME]" & _
        ", [CUSTOMER-NEW-BALANCE-OWED], [CUSTOMER-NUMBER], [CUSTOMER-PHONE-NUMBER], [CUST" & _
        "OMER-PREVIOUS-BALANCE], [CUSTOMER-STATE], [CUSTOMER-STREET], [CUSTOMER-ZIP]) VAL" & _
        "UES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        Me.OleDbInsertCommand1.Connection = Me.connect
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-CITY", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-CITY"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-FIRST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-FIRST-NAME"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-LAST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-LAST-NAME"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-PHONE-NUMBER", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-PHONE-NUMBER"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-STATE", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-STATE"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-STREET", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-STREET"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-ZIP", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-ZIP"))
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT [CUSTOMER-CITY], [CUSTOMER-FIRST-NAME], [CUSTOMER-LAST-NAME], [CUSTOMER-NE" & _
        "W-BALANCE-OWED], [CUSTOMER-NUMBER], [CUSTOMER-PHONE-NUMBER], [CUSTOMER-PREVIOUS-" & _
        "BALANCE], [CUSTOMER-STATE], [CUSTOMER-STREET], [CUSTOMER-ZIP] FROM CUSTOMER ORDE" & _
        "R BY CUSTOMER - LAST - NAME, CUSTOMER - FIRST - NAME"
        Me.OleDbSelectCommand1.Connection = Me.connect
        '
        'OleDbUpdateCommand1
        '
        Me.OleDbUpdateCommand1.CommandText = "UPDATE CUSTOMER SET [CUSTOMER-CITY] = ?, [CUSTOMER-FIRST-NAME] = ?, [CUSTOMER-LAS" & _
        "T-NAME] = ?, [CUSTOMER-NEW-BALANCE-OWED] = ?, [CUSTOMER-NUMBER] = ?, [CUSTOMER-P" & _
        "HONE-NUMBER] = ?, [CUSTOMER-PREVIOUS-BALANCE] = ?, [CUSTOMER-STATE] = ?, [CUSTOM" & _
        "ER-STREET] = ?, [CUSTOMER-ZIP] = ? WHERE ([CUSTOMER-NUMBER] = ?) AND ([CUSTOMER-" & _
        "CITY] = ? OR ? IS NULL AND [CUSTOMER-CITY] IS NULL) AND ([CUSTOMER-FIRST-NAME] =" & _
        " ? OR ? IS NULL AND [CUSTOMER-FIRST-NAME] IS NULL) AND ([CUSTOMER-LAST-NAME] = ?" & _
        " OR ? IS NULL AND [CUSTOMER-LAST-NAME] IS NULL) AND ([CUSTOMER-NEW-BALANCE-OWED]" & _
        " = ? OR ? IS NULL AND [CUSTOMER-NEW-BALANCE-OWED] IS NULL) AND ([CUSTOMER-PHONE-" & _
        "NUMBER] = ? OR ? IS NULL AND [CUSTOMER-PHONE-NUMBER] IS NULL) AND ([CUSTOMER-PRE" & _
        "VIOUS-BALANCE] = ? OR ? IS NULL AND [CUSTOMER-PREVIOUS-BALANCE] IS NULL) AND ([C" & _
        "USTOMER-STATE] = ? OR ? IS NULL AND [CUSTOMER-STATE] IS NULL) AND ([CUSTOMER-STR" & _
        "EET] = ? OR ? IS NULL AND [CUSTOMER-STREET] IS NULL) AND ([CUSTOMER-ZIP] = ? OR " & _
        "? IS NULL AND [CUSTOMER-ZIP] IS NULL)"
        Me.OleDbUpdateCommand1.Connection = Me.connect
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-CITY", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-CITY"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-FIRST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-FIRST-NAME"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-LAST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-LAST-NAME"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-PHONE-NUMBER", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-PHONE-NUMBER"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-STATE", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-STATE"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-STREET", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-STREET"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-ZIP", System.Data.OleDb.OleDbType.VarWChar, 50, "CUSTOMER-ZIP"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-CITY", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-CITY", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-CITY1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-CITY", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-FIRST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-FIRST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-FIRST-NAME1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-FIRST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-LAST-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-LAST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-LAST-NAME1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-LAST-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PHONE-NUMBER", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-PHONE-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PHONE-NUMBER1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-PHONE-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STATE", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STATE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STATE1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STATE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STREET", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STREET", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-STREET1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-STREET", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-ZIP", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-ZIP", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-ZIP1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "CUSTOMER-ZIP", System.Data.DataRowVersion.Original, Nothing))
        '
        'Data1
        '
        Me.Data1.DataSetName = "NewDataSet"
        Me.Data1.Locale = New System.Globalization.CultureInfo("en-US")
        '
        'Grid1
        '
        Me.Grid1.AlternatingBackColor = System.Drawing.Color.LightGray
        Me.Grid1.Anchor = (((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
                    Or System.Windows.Forms.AnchorStyles.Left) _
                    Or System.Windows.Forms.AnchorStyles.Right)
        Me.Grid1.BackColor = System.Drawing.Color.DarkGray
        Me.Grid1.CaptionBackColor = System.Drawing.Color.White
        Me.Grid1.CaptionFont = New System.Drawing.Font("Verdana", 9.75!, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Grid1.CaptionForeColor = System.Drawing.Color.Navy
        Me.Grid1.CaptionText = "       Number   Last Name  First Name Street       City        State          Zip" & _
        "           Phone  Prev. Balance   New Balance"
        Me.Grid1.ColumnHeadersVisible = False
        Me.Grid1.DataMember = ""
        Me.Grid1.ForeColor = System.Drawing.Color.Black
        Me.Grid1.GridLineColor = System.Drawing.Color.Black
        Me.Grid1.GridLineStyle = System.Windows.Forms.DataGridLineStyle.None
        Me.Grid1.HeaderBackColor = System.Drawing.Color.Silver
        Me.Grid1.HeaderForeColor = System.Drawing.Color.Black
        Me.Grid1.LinkColor = System.Drawing.Color.Navy
        Me.Grid1.Location = New System.Drawing.Point(56, 72)
        Me.Grid1.Name = "Grid1"
        Me.Grid1.ParentRowsBackColor = System.Drawing.Color.White
        Me.Grid1.ParentRowsForeColor = System.Drawing.Color.Black
        Me.Grid1.ReadOnly = True
        Me.Grid1.SelectionBackColor = System.Drawing.Color.Navy
        Me.Grid1.SelectionForeColor = System.Drawing.Color.White
        Me.Grid1.Size = New System.Drawing.Size(824, 344)
        Me.Grid1.TabIndex = 1
        '
        'MainMenu1
        '
        Me.MainMenu1.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.MenuItem1})
        '
        'MenuItem1
        '
        Me.MenuItem1.Index = 0
        Me.MenuItem1.MenuItems.AddRange(New System.Windows.Forms.MenuItem() {Me.MenuItem2})
        Me.MenuItem1.Text = "File"
        '
        'MenuItem2
        '
        Me.MenuItem2.Index = 0
        Me.MenuItem2.Shortcut = System.Windows.Forms.Shortcut.CtrlW
        Me.MenuItem2.Text = "Close"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Font = New System.Drawing.Font("Monotype Corsiva", 12.0!, (System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.ForeColor = System.Drawing.SystemColors.Highlight
        Me.Label1.Location = New System.Drawing.Point(8, 8)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(100, 40)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Today's Date:"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.Label2.Font = New System.Drawing.Font("Verdana", 9.75!, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.ForeColor = System.Drawing.Color.Navy
        Me.Label2.Location = New System.Drawing.Point(56, 48)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(824, 24)
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Current Acme Printer's Customer List"
        '
        'Customer_List
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(928, 441)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.Label2, Me.Label1, Me.Grid1})
        Me.Menu = Me.MainMenu1
        Me.Name = "Customer_List"
        Me.Text = "Customer List"
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        report.Show()
        Me.Close()
    End Sub

    Private Sub connect_InfoMessage(ByVal sender As System.Object, ByVal e As System.Data.OleDb.OleDbInfoMessageEventArgs) Handles connect.InfoMessage

    End Sub

    Private Sub Customer_List_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Label1.Text = "Today's Date:  " + Today
        Try
            Adapter1.SelectCommand.CommandText = _
                        "SELECT * FROM CUSTOMER"

            Data1.Clear()
            Adapter1.Fill(Data1, "CUSTOMER")

            Grid1.SetDataBinding(Data1, "CUSTOMER")


        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
        End Try


    End Sub



    Private Sub Label1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label1.Click

    End Sub
End Class
