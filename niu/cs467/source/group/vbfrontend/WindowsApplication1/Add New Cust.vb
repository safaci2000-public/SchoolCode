Public Class Add_New_Cust
    Inherits System.Windows.Forms.Form

    Dim cnum As Integer

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
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents cmd1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents city As System.Windows.Forms.TextBox
    Friend WithEvents phone As System.Windows.Forms.TextBox
    Friend WithEvents zip As System.Windows.Forms.TextBox
    Friend WithEvents state As System.Windows.Forms.TextBox
    Friend WithEvents street As System.Windows.Forms.TextBox
    Friend WithEvents lname As System.Windows.Forms.TextBox
    Friend WithEvents fname As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Add_New_Cust))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.Button2 = New System.Windows.Forms.Button()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.city = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.phone = New System.Windows.Forms.TextBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.zip = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.state = New System.Windows.Forms.TextBox()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.street = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.lname = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.fname = New System.Windows.Forms.TextBox()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.cmd1 = New System.Data.OleDb.OleDbCommand()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(32, 40)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "First Name:"
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.Button2, Me.Button1, Me.city, Me.Label7, Me.phone, Me.Label6, Me.zip, Me.Label5, Me.state, Me.Label4, Me.street, Me.Label3, Me.lname, Me.Label2, Me.fname, Me.Label1})
        Me.GroupBox1.Font = New System.Drawing.Font("Monotype Corsiva", 12.0!, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.Location = New System.Drawing.Point(32, 32)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(312, 320)
        Me.GroupBox1.TabIndex = 1
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Customer Information"
        '
        'Button2
        '
        Me.Button2.BackColor = System.Drawing.Color.Silver
        Me.Button2.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Button2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button2.Location = New System.Drawing.Point(152, 272)
        Me.Button2.Name = "Button2"
        Me.Button2.TabIndex = 15
        Me.Button2.Text = "Cancel"
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.Color.Silver
        Me.Button1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button1.Location = New System.Drawing.Point(40, 272)
        Me.Button1.Name = "Button1"
        Me.Button1.TabIndex = 14
        Me.Button1.Text = "Submit"
        '
        'city
        '
        Me.city.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.city.Location = New System.Drawing.Point(160, 168)
        Me.city.Name = "city"
        Me.city.TabIndex = 8
        Me.city.Text = ""
        '
        'Label7
        '
        Me.Label7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.Location = New System.Drawing.Point(32, 168)
        Me.Label7.Name = "Label7"
        Me.Label7.TabIndex = 12
        Me.Label7.Text = "City:"
        '
        'phone
        '
        Me.phone.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.phone.HideSelection = False
        Me.phone.Location = New System.Drawing.Point(160, 104)
        Me.phone.MaxLength = 10
        Me.phone.Name = "phone"
        Me.phone.TabIndex = 5
        Me.phone.Text = ""
        '
        'Label6
        '
        Me.Label6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.Location = New System.Drawing.Point(32, 104)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(56, 23)
        Me.Label6.TabIndex = 10
        Me.Label6.Text = "Phone:"
        '
        'zip
        '
        Me.zip.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.zip.Location = New System.Drawing.Point(160, 232)
        Me.zip.MaxLength = 5
        Me.zip.Name = "zip"
        Me.zip.Size = New System.Drawing.Size(50, 20)
        Me.zip.TabIndex = 13
        Me.zip.Text = ""
        Me.zip.WordWrap = False
        '
        'Label5
        '
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.Location = New System.Drawing.Point(32, 224)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(32, 23)
        Me.Label5.TabIndex = 11
        Me.Label5.Text = "Zip:"
        '
        'state
        '
        Me.state.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.state.Location = New System.Drawing.Point(160, 200)
        Me.state.MaxLength = 2
        Me.state.Name = "state"
        Me.state.Size = New System.Drawing.Size(24, 20)
        Me.state.TabIndex = 9
        Me.state.Text = ""
        '
        'Label4
        '
        Me.Label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.Location = New System.Drawing.Point(32, 200)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(48, 23)
        Me.Label4.TabIndex = 6
        Me.Label4.Text = "State:"
        '
        'street
        '
        Me.street.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.street.Location = New System.Drawing.Point(160, 136)
        Me.street.Name = "street"
        Me.street.Size = New System.Drawing.Size(144, 20)
        Me.street.TabIndex = 7
        Me.street.Text = ""
        '
        'Label3
        '
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(32, 136)
        Me.Label3.Name = "Label3"
        Me.Label3.TabIndex = 4
        Me.Label3.Text = "Street Address:"
        '
        'lname
        '
        Me.lname.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lname.Location = New System.Drawing.Point(160, 72)
        Me.lname.Name = "lname"
        Me.lname.TabIndex = 3
        Me.lname.Text = ""
        '
        'Label2
        '
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(32, 72)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Last Name:"
        '
        'fname
        '
        Me.fname.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fname.Location = New System.Drawing.Point(160, 40)
        Me.fname.Name = "fname"
        Me.fname.TabIndex = 1
        Me.fname.Text = ""
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
        Me.OleDbDeleteCommand1.Connection = Me.conn1
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
        'conn1
        '
        Me.conn1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Password="""";User ID=Admin;Data Source=groupdb.md" & _
        "b;Mode=Share Deny None;Extended Properties="""";Jet OLEDB:System database="""";Jet O" & _
        "LEDB:Registry Path="""";Jet OLEDB:Database Password="""";Jet OLEDB:Engine Type=5;Jet" & _
        " OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Glo" & _
        "bal Bulk Transactions=1;Jet OLEDB:New Database Password="""";Jet OLEDB:Create Syst" & _
        "em Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don't Copy Locale o" & _
        "n Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=Fal" & _
        "se"
        '
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO CUSTOMER([CUSTOMER-CITY], [CUSTOMER-FIRST-NAME], [CUSTOMER-LAST-NAME]" & _
        ", [CUSTOMER-NEW-BALANCE-OWED], [CUSTOMER-NUMBER], [CUSTOMER-PHONE-NUMBER], [CUST" & _
        "OMER-PREVIOUS-BALANCE], [CUSTOMER-STATE], [CUSTOMER-STREET], [CUSTOMER-ZIP]) VAL" & _
        "UES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        Me.OleDbInsertCommand1.Connection = Me.conn1
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
        "BALANCE], [CUSTOMER-STATE], [CUSTOMER-STREET], [CUSTOMER-ZIP] FROM CUSTOMER"
        Me.OleDbSelectCommand1.Connection = Me.conn1
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
        Me.OleDbUpdateCommand1.Connection = Me.conn1
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
        'cmd1
        '
        Me.cmd1.Connection = Me.conn1
        '
        'Add_New_Cust
        '
        Me.AcceptButton = Me.Button1
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.CancelButton = Me.Button2
        Me.ClientSize = New System.Drawing.Size(392, 385)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.GroupBox1})
        Me.Menu = Me.MainMenu1
        Me.Name = "Add_New_Cust"
        Me.Text = "Add New Customer"
        Me.GroupBox1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim sSql As String

        sSql = "INSERT INTO CUSTOMER([CUSTOMER-NUMBER], " & _
                "[CUSTOMER-LAST-NAME], [CUSTOMER-FIRST-NAME]" & _
                ", [CUSTOMER-STREET], [CUSTOMER-CITY], [CUSTOMER-STATE]" & _
                ", [CUSTOMER-ZIP], [CUSTOMER-PHONE-NUMBER]) VALUES(" & CType(cnum, String) & _
                " , '" & lname.Text & "', '" & fname.Text & "', '" & _
                street.Text & "', '" & city.Text & "', '" & state.Text & _
                "', '" & zip.Text & "', '" & phone.Text & "')"

        Adapter1.InsertCommand.CommandText = sSql

        Try
            Adapter1.InsertCommand.ExecuteNonQuery()

        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
            indexform.Show()
            Me.Close()
        End Try

        MsgBox("Data successfully written to database")
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Add_New_Cust_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim scalarcmd As String
        scalarcmd = "SELECT MAX([CUSTOMER-NUMBER]) FROM CUSTOMER"
        cmd1.CommandText = CommandType.Text

        cnum = 0  ' gets key in customer table.

        Try

            cmd1.CommandText = scalarcmd
            conn1.Open()

            cnum = CType(cmd1.ExecuteScalar(), Integer)
            cnum += 1

        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
        End Try
    End Sub


End Class
