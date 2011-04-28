Public Class Place_New_Order
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
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents odate As System.Windows.Forms.TextBox
    Friend WithEvents cnum As System.Windows.Forms.TextBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents cmd1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents rdate As System.Windows.Forms.TextBox
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents Next1 As System.Windows.Forms.Button
    Friend WithEvents Done As System.Windows.Forms.Button
    Friend WithEvents iprint As System.Windows.Forms.TextBox
    Friend WithEvents iart As System.Windows.Forms.TextBox
    Friend WithEvents iqty As System.Windows.Forms.TextBox
    Friend WithEvents iname As System.Windows.Forms.TextBox
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents icost As System.Windows.Forms.TextBox
    Friend WithEvents item1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents Orders2 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents conn2 As System.Data.OleDb.OleDbConnection
    Friend WithEvents cmd2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbSelectCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents Button1 As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Place_New_Order))
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.icost = New System.Windows.Forms.TextBox()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.Next1 = New System.Windows.Forms.Button()
        Me.iprint = New System.Windows.Forms.TextBox()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.iart = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.iqty = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.iname = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.odate = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.cnum = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.Button3 = New System.Windows.Forms.Button()
        Me.rdate = New System.Windows.Forms.TextBox()
        Me.Done = New System.Windows.Forms.Button()
        Me.cmd1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.item1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.Orders2 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.conn2 = New System.Data.OleDb.OleDbConnection()
        Me.OleDbInsertCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.cmd2 = New System.Data.OleDb.OleDbCommand()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.GroupBox1.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        Me.SuspendLayout()
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.icost, Me.Label7, Me.Next1, Me.iprint, Me.Label6, Me.iart, Me.Label5, Me.iqty, Me.Label3, Me.iname, Me.Label2})
        Me.GroupBox1.Enabled = False
        Me.GroupBox1.Location = New System.Drawing.Point(32, 176)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(416, 240)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Item Information"
        '
        'icost
        '
        Me.icost.Location = New System.Drawing.Point(192, 160)
        Me.icost.Name = "icost"
        Me.icost.TabIndex = 26
        Me.icost.Text = "0.00"
        '
        'Label7
        '
        Me.Label7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label7.Location = New System.Drawing.Point(16, 160)
        Me.Label7.Name = "Label7"
        Me.Label7.TabIndex = 27
        Me.Label7.Text = "Supply Cost:"
        '
        'Next1
        '
        Me.Next1.BackColor = System.Drawing.Color.Silver
        Me.Next1.Location = New System.Drawing.Point(184, 208)
        Me.Next1.Name = "Next1"
        Me.Next1.TabIndex = 28
        Me.Next1.Text = "Next Item"
        '
        'iprint
        '
        Me.iprint.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.iprint.Location = New System.Drawing.Point(192, 128)
        Me.iprint.Name = "iprint"
        Me.iprint.TabIndex = 23
        Me.iprint.Text = "1"
        '
        'Label6
        '
        Me.Label6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label6.Location = New System.Drawing.Point(16, 128)
        Me.Label6.Name = "Label6"
        Me.Label6.TabIndex = 22
        Me.Label6.Text = "Printing Hours:"
        '
        'iart
        '
        Me.iart.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.iart.Location = New System.Drawing.Point(192, 96)
        Me.iart.Name = "iart"
        Me.iart.TabIndex = 21
        Me.iart.Text = "1"
        '
        'Label5
        '
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.Location = New System.Drawing.Point(16, 96)
        Me.Label5.Name = "Label5"
        Me.Label5.TabIndex = 20
        Me.Label5.Text = "Artwork Hours:"
        '
        'iqty
        '
        Me.iqty.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.iqty.Location = New System.Drawing.Point(192, 64)
        Me.iqty.Name = "iqty"
        Me.iqty.TabIndex = 17
        Me.iqty.Text = "1"
        '
        'Label3
        '
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(16, 64)
        Me.Label3.Name = "Label3"
        Me.Label3.TabIndex = 16
        Me.Label3.Text = "Quantity of Item:"
        '
        'iname
        '
        Me.iname.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.iname.Location = New System.Drawing.Point(152, 32)
        Me.iname.Name = "iname"
        Me.iname.Size = New System.Drawing.Size(136, 20)
        Me.iname.TabIndex = 15
        Me.iname.Text = ""
        '
        'Label2
        '
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(16, 32)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 14
        Me.Label2.Text = "Name of Item:"
        '
        'Label4
        '
        Me.Label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.Location = New System.Drawing.Point(40, 96)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(136, 23)
        Me.Label4.TabIndex = 18
        Me.Label4.Text = "Due Date:"
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
        'odate
        '
        Me.odate.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.odate.Location = New System.Drawing.Point(192, 64)
        Me.odate.Name = "odate"
        Me.odate.TabIndex = 23
        Me.odate.Text = "mm/dd/yyyy"
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(40, 64)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(136, 16)
        Me.Label1.TabIndex = 22
        Me.Label1.Text = "Date Order was Placed:"
        '
        'cnum
        '
        Me.cnum.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cnum.Location = New System.Drawing.Point(192, 32)
        Me.cnum.Name = "cnum"
        Me.cnum.TabIndex = 21
        Me.cnum.Text = ""
        '
        'Label8
        '
        Me.Label8.BackColor = System.Drawing.Color.Transparent
        Me.Label8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label8.Location = New System.Drawing.Point(40, 32)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(112, 23)
        Me.Label8.TabIndex = 20
        Me.Label8.Text = "Customer Number:"
        '
        'GroupBox2
        '
        Me.GroupBox2.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox2.Controls.AddRange(New System.Windows.Forms.Control() {Me.Button3, Me.rdate, Me.Label1, Me.cnum, Me.Label8, Me.odate, Me.Label4})
        Me.GroupBox2.Location = New System.Drawing.Point(32, 8)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(416, 160)
        Me.GroupBox2.TabIndex = 24
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "Order Information"
        '
        'Button3
        '
        Me.Button3.BackColor = System.Drawing.Color.Silver
        Me.Button3.Location = New System.Drawing.Point(160, 128)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(136, 24)
        Me.Button3.TabIndex = 26
        Me.Button3.Text = "Start Order"
        '
        'rdate
        '
        Me.rdate.Location = New System.Drawing.Point(192, 96)
        Me.rdate.Name = "rdate"
        Me.rdate.TabIndex = 25
        Me.rdate.Text = "mm/dd/yyyy"
        '
        'Done
        '
        Me.Done.BackColor = System.Drawing.Color.Silver
        Me.Done.Location = New System.Drawing.Point(56, 432)
        Me.Done.Name = "Done"
        Me.Done.Size = New System.Drawing.Size(136, 24)
        Me.Done.TabIndex = 79
        Me.Done.Text = "Done"
        '
        'cmd1
        '
        Me.cmd1.Connection = Me.conn1
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
        'item1
        '
        Me.item1.DeleteCommand = Me.OleDbDeleteCommand1
        Me.item1.InsertCommand = Me.OleDbInsertCommand1
        Me.item1.SelectCommand = Me.OleDbSelectCommand1
        Me.item1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "ITEM-DETAILS", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("ORDER-NUMBER", "ORDER-NUMBER"), New System.Data.Common.DataColumnMapping("ITEM-NUMBER", "ITEM-NUMBER"), New System.Data.Common.DataColumnMapping("ITEM-NAME", "ITEM-NAME"), New System.Data.Common.DataColumnMapping("ITEM-QUANTITY", "ITEM-QUANTITY"), New System.Data.Common.DataColumnMapping("PRINTING-HOURS", "PRINTING-HOURS"), New System.Data.Common.DataColumnMapping("PRINTING-COST", "PRINTING-COST"), New System.Data.Common.DataColumnMapping("ARTWORK-HOURS", "ARTWORK-HOURS"), New System.Data.Common.DataColumnMapping("ARTWORK-COST", "ARTWORK-COST"), New System.Data.Common.DataColumnMapping("TOTAL-SUPPLY-COST", "TOTAL-SUPPLY-COST")})})
        Me.item1.UpdateCommand = Me.OleDbUpdateCommand1
        '
        'OleDbDeleteCommand1
        '
        Me.OleDbDeleteCommand1.CommandText = "DELETE FROM [ITEM-DETAILS] WHERE ([ITEM-NUMBER] = ?) AND ([ORDER-NUMBER] = ?) AND" & _
        " ([ARTWORK-COST] = ? OR ? IS NULL AND [ARTWORK-COST] IS NULL) AND ([ITEM-NAME] =" & _
        " ? OR ? IS NULL AND [ITEM-NAME] IS NULL) AND ([PRINTING-COST] = ? OR ? IS NULL A" & _
        "ND [PRINTING-COST] IS NULL) AND ([TOTAL-SUPPLY-COST] = ? OR ? IS NULL AND [TOTAL" & _
        "-SUPPLY-COST] IS NULL)"
        Me.OleDbDeleteCommand1.Connection = Me.conn1
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ITEM-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ITEM-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ARTWORK-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "ARTWORK-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ARTWORK-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "ARTWORK-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ITEM-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "ITEM-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ITEM-NAME1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "ITEM-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PRINTING-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PRINTING-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PRINTING-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PRINTING-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-SUPPLY-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-SUPPLY-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-SUPPLY-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-SUPPLY-COST", System.Data.DataRowVersion.Original, Nothing))
        '
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO [ITEM-DETAILS] ([ARTWORK-COST], [ARTWORK-HOURS], [ITEM-NAME], [ITEM-N" & _
        "UMBER], [ITEM-QUANTITY], [ORDER-NUMBER], [PRINTING-COST], [PRINTING-HOURS], [TOT" & _
        "AL-SUPPLY-COST]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
        Me.OleDbInsertCommand1.Connection = Me.conn1
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ARTWORK-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "ARTWORK-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ARTWORK-HOURS", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ARTWORK-HOURS", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ITEM-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, "ITEM-NAME"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ITEM-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ITEM-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ITEM-QUANTITY", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ITEM-QUANTITY", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("PRINTING-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PRINTING-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("PRINTING-HOURS", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "PRINTING-HOURS", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("TOTAL-SUPPLY-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-SUPPLY-COST", System.Data.DataRowVersion.Current, Nothing))
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT [ARTWORK-COST], [ARTWORK-HOURS], [ITEM-NAME], [ITEM-NUMBER], [ITEM-QUANTIT" & _
        "Y], [ORDER-NUMBER], [PRINTING-COST], [PRINTING-HOURS], [TOTAL-SUPPLY-COST] FROM " & _
        "[ITEM-DETAILS]"
        Me.OleDbSelectCommand1.Connection = Me.conn1
        '
        'OleDbUpdateCommand1
        '
        Me.OleDbUpdateCommand1.CommandText = "UPDATE [ITEM-DETAILS] SET [ARTWORK-COST] = ?, [ARTWORK-HOURS] = ?, [ITEM-NAME] = " & _
        "?, [ITEM-NUMBER] = ?, [ITEM-QUANTITY] = ?, [ORDER-NUMBER] = ?, [PRINTING-COST] =" & _
        " ?, [PRINTING-HOURS] = ?, [TOTAL-SUPPLY-COST] = ? WHERE ([ITEM-NUMBER] = ?) AND " & _
        "([ORDER-NUMBER] = ?) AND ([ARTWORK-COST] = ? OR ? IS NULL AND [ARTWORK-COST] IS " & _
        "NULL) AND ([ITEM-NAME] = ? OR ? IS NULL AND [ITEM-NAME] IS NULL) AND ([PRINTING-" & _
        "COST] = ? OR ? IS NULL AND [PRINTING-COST] IS NULL) AND ([TOTAL-SUPPLY-COST] = ?" & _
        " OR ? IS NULL AND [TOTAL-SUPPLY-COST] IS NULL)"
        Me.OleDbUpdateCommand1.Connection = Me.conn1
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ARTWORK-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "ARTWORK-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ARTWORK-HOURS", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ARTWORK-HOURS", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ITEM-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, "ITEM-NAME"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ITEM-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ITEM-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ITEM-QUANTITY", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ITEM-QUANTITY", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("PRINTING-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PRINTING-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("PRINTING-HOURS", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "PRINTING-HOURS", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("TOTAL-SUPPLY-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-SUPPLY-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ITEM-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ITEM-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ARTWORK-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "ARTWORK-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ARTWORK-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "ARTWORK-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ITEM-NAME", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "ITEM-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ITEM-NAME1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "ITEM-NAME", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PRINTING-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PRINTING-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PRINTING-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PRINTING-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-SUPPLY-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-SUPPLY-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-SUPPLY-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-SUPPLY-COST", System.Data.DataRowVersion.Original, Nothing))
        '
        'Orders2
        '
        Me.Orders2.DeleteCommand = Me.OleDbDeleteCommand2
        Me.Orders2.InsertCommand = Me.OleDbInsertCommand2
        Me.Orders2.SelectCommand = Me.OleDbSelectCommand2
        Me.Orders2.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "ORDERS", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("CUSTOMER-NUMBER", "CUSTOMER-NUMBER"), New System.Data.Common.DataColumnMapping("ORDER-NUMBER", "ORDER-NUMBER"), New System.Data.Common.DataColumnMapping("DATE-PLACED", "DATE-PLACED"), New System.Data.Common.DataColumnMapping("DATE-TO-BE-COMPLETED", "DATE-TO-BE-COMPLETED"), New System.Data.Common.DataColumnMapping("TOTAL-ORDER-COST", "TOTAL-ORDER-COST")})})
        Me.Orders2.UpdateCommand = Me.OleDbUpdateCommand2
        '
        'OleDbDeleteCommand2
        '
        Me.OleDbDeleteCommand2.CommandText = "DELETE FROM ORDERS WHERE ([ORDER-NUMBER] = ?) AND ([DATE-PLACED] = ? OR ? IS NULL" & _
        " AND [DATE-PLACED] IS NULL) AND ([DATE-TO-BE-COMPLETED] = ? OR ? IS NULL AND [DA" & _
        "TE-TO-BE-COMPLETED] IS NULL) AND ([TOTAL-ORDER-COST] = ? OR ? IS NULL AND [TOTAL" & _
        "-ORDER-COST] IS NULL)"
        Me.OleDbDeleteCommand2.Connection = Me.conn2
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-PLACED", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-PLACED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-PLACED1", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-PLACED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-TO-BE-COMPLETED", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-TO-BE-COMPLETED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-TO-BE-COMPLETED1", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-TO-BE-COMPLETED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-ORDER-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-ORDER-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-ORDER-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-ORDER-COST", System.Data.DataRowVersion.Original, Nothing))
        '
        'conn2
        '
        Me.conn2.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Password="""";User ID=Admin;Data Source=groupdb.md" & _
        "b;Mode=Share Deny None;Extended Properties="""";Jet OLEDB:System database="""";Jet O" & _
        "LEDB:Registry Path="""";Jet OLEDB:Database Password="""";Jet OLEDB:Engine Type=5;Jet" & _
        " OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Glo" & _
        "bal Bulk Transactions=1;Jet OLEDB:New Database Password="""";Jet OLEDB:Create Syst" & _
        "em Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don't Copy Locale o" & _
        "n Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=Fal" & _
        "se"
        '
        'OleDbInsertCommand2
        '
        Me.OleDbInsertCommand2.CommandText = "INSERT INTO ORDERS([CUSTOMER-NUMBER], [DATE-PLACED], [DATE-TO-BE-COMPLETED], [ORD" & _
        "ER-NUMBER], [TOTAL-ORDER-COST]) VALUES (?, ?, ?, ?, ?)"
        Me.OleDbInsertCommand2.Connection = Me.conn2
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("DATE-PLACED", System.Data.OleDb.OleDbType.DBDate, 0, "DATE-PLACED"))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("DATE-TO-BE-COMPLETED", System.Data.OleDb.OleDbType.DBDate, 0, "DATE-TO-BE-COMPLETED"))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("TOTAL-ORDER-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-ORDER-COST", System.Data.DataRowVersion.Current, Nothing))
        '
        'OleDbSelectCommand2
        '
        Me.OleDbSelectCommand2.CommandText = "SELECT [CUSTOMER-NUMBER], [DATE-PLACED], [DATE-TO-BE-COMPLETED], [ORDER-NUMBER], " & _
        "[TOTAL-ORDER-COST] FROM ORDERS"
        Me.OleDbSelectCommand2.Connection = Me.conn2
        '
        'OleDbUpdateCommand2
        '
        Me.OleDbUpdateCommand2.CommandText = "UPDATE ORDERS SET [CUSTOMER-NUMBER] = ?, [DATE-PLACED] = ?, [DATE-TO-BE-COMPLETED" & _
        "] = ?, [ORDER-NUMBER] = ?, [TOTAL-ORDER-COST] = ? WHERE ([ORDER-NUMBER] = ?) AND" & _
        " ([DATE-PLACED] = ? OR ? IS NULL AND [DATE-PLACED] IS NULL) AND ([DATE-TO-BE-COM" & _
        "PLETED] = ? OR ? IS NULL AND [DATE-TO-BE-COMPLETED] IS NULL) AND ([TOTAL-ORDER-C" & _
        "OST] = ? OR ? IS NULL AND [TOTAL-ORDER-COST] IS NULL)"
        Me.OleDbUpdateCommand2.Connection = Me.conn2
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("DATE-PLACED", System.Data.OleDb.OleDbType.DBDate, 0, "DATE-PLACED"))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("DATE-TO-BE-COMPLETED", System.Data.OleDb.OleDbType.DBDate, 0, "DATE-TO-BE-COMPLETED"))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("TOTAL-ORDER-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-ORDER-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_ORDER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "ORDER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-PLACED", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-PLACED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-PLACED1", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-PLACED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-TO-BE-COMPLETED", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-TO-BE-COMPLETED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_DATE-TO-BE-COMPLETED1", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "DATE-TO-BE-COMPLETED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-ORDER-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-ORDER-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_TOTAL-ORDER-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "TOTAL-ORDER-COST", System.Data.DataRowVersion.Original, Nothing))
        '
        'cmd2
        '
        Me.cmd2.Connection = Me.conn2
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.Color.Silver
        Me.Button1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Button1.Location = New System.Drawing.Point(280, 432)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(152, 23)
        Me.Button1.TabIndex = 80
        Me.Button1.Text = "Cancel"
        '
        'Place_New_Order
        '
        Me.AcceptButton = Me.Next1
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(552, 465)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.Button1, Me.GroupBox2, Me.GroupBox1, Me.Done})
        Me.Menu = Me.MainMenu1
        Me.Name = "Place_New_Order"
        Me.Text = "Place New Order"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox2.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region
    'Dim tracker As New Integer(1 To 20)  ' keeps track of all items
    ' recorded in item table in case
    ' they need to be removed.
    Dim ordnum As Integer ' next available order number
    Dim itemnumber As Integer ' next available item number.
    Dim ordertotal As Integer ' sum of order total.
    Dim artcost As Double     ' hourly rate of art
    Dim pcost As Double       ' hourly rate of printing.

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub MenuItem4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        InputBox("enter a value")
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Next1.Click
        Dim sql1 As String
        Dim pcalccost As Double ' calculated cost, hrs * charge
        Dim acalcost As Double  ' calculated cost, hrs * charge
        Dim flag As Integer
        flag = 1

        pcalccost = pcost * CType(iprint.Text, Double)
        acalcost = artcost * CType(iart.Text, Double)
        ototal = pcalccost + acalcost + CType(icost.Text, Double)

        sql1 = "INSERT INTO [ITEM-DETAILS]([ORDER-NUMBER], " & _
                "[ITEM-NUMBER], [ITEM-NAME]" & _
                ", [ITEM-QUANTITY], [PRINTING-HOURS], [PRINTING-COST]" & _
                ", [ARTWORK-HOURS], [ARTWORK-COST], [TOTAL-SUPPLY-COST])" & _
                " VALUES(" & CType(ordnum, String) & _
                " , " & CType(itemnumber, String) & ", '" & _
                iname.Text & "', " & iqty.Text & ", " & _
                iprint.Text & ", " & CType(pcalccost, String) & _
                ", " & iart.Text & ", " & CType(acalcost, String) & _
                ", " & icost.Text & ")"

        item1.InsertCommand.CommandText = sql1

        Try
            conn1.Open()
            item1.InsertCommand.ExecuteNonQuery()
        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
            flag = 0
        Finally
            conn1.Close()
        End Try

        If flag = 1 Then
            MsgBox("Item Added, thank you!")
        End If

        flag = 1   ' resets flag
        iname.Text = ""
        iqty.Text = "1"
        iart.Text = "1"
        iprint.Text = "1"
        icost.Text = "0.00"
        itemnumber += 1

    End Sub

    Private Sub Submit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Done.Click
        Dim sql1 As String

        sql1 = "UPDATE [ORDERS] SET [TOTAL-ORDER-COST] = " & CType(ototal, String) & _
                " WHERE [ORDER-NUMBER] = " & CType(ordnum, String) & " AND [CUSTOMER-NUMBER]" & _
                " = " & cnum.Text
        Try

            conn2.Open()
            Orders2.InsertCommand.CommandText = sql1
            Orders2.InsertCommand.ExecuteNonQuery()
            conn2.Close()

        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Error.  Could not write Order Record to Database")
            indexform.Show()
            Me.Close()
        End Try

        MsgBox("Order entered into database, thank you for your business")
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Place_New_Order_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ordnum = 0 '  initializes order number.
        artcost = 0 ' initializes art cost.
        pcost = 0   ' initializes printing cost.
        ototal = 0 ' initilizes order total

        odate.Text = Today
        rdate.Text = Today

        ' retrives order number      
        Dim scalarcmd As String

        scalarcmd = "SELECT MAX([ORDER-NUMBER]) FROM ORDERS"
        cmd1.CommandText = CommandType.Text


        Try

            cmd1.CommandText = scalarcmd
            conn1.Open()

            ordnum = CType(cmd1.ExecuteScalar(), Integer)
            ordnum += 1

        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Error.  Could not retrieve next Order Number!")
        End Try

        ' retrieves next item number.
        scalarcmd = "SELECT MAX([ITEM-NUMBER]) FROM [ITEM-DETAILS]"
        cmd1.CommandText = scalarcmd

        Try
            itemnumber = CType(cmd1.ExecuteScalar(), Integer)
            itemnumber += 100
        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Error.  Could not retrieve next Item Number")
        End Try

        ' retrieve art cost
        scalarcmd = "SELECT ([LABOR-COST]) FROM [LABOR-COSTS]" & _
                " WHERE [LABOR-CODE] = 'A'"
        cmd1.CommandText = scalarcmd
        Try
            artcost = CType(cmd1.ExecuteScalar(), Double)
        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Error.  Could not retrieve art cost")
        End Try

        ' retrieve printing cost
        scalarcmd = "SELECT ([LABOR-COST]) FROM [LABOR-COSTS]" & _
                " WHERE [LABOR-CODE] = 'P'"
        cmd1.CommandText = scalarcmd
        Try
            pcost = CType(cmd1.ExecuteScalar(), Double)
        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Error.  Could not retrieve art cost")
        End Try
        conn1.Close()

    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click

        Dim scalarcmd As String
        Dim lname As String
        Dim flag As Integer
        flag = 0
        scalarcmd = "SELECT [CUSTOMER-LAST-NAME] FROM CUSTOMER" & _
                    " WHERE [CUSTOMER-NUMBER] = " & cnum.Text

        cmd1.CommandText = CommandType.Text

        Try
            conn1.Open()
            cmd1.CommandText = scalarcmd
            lname = CType(cmd1.ExecuteScalar(), String)


        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Customer Number")
            indexform.Show()
            Me.Close()
        Finally
            conn1.Close()
        End Try


        If lname = "" Then
            flag = 1
        End If

        If flag = 0 Then
            MsgBox("Valid customer number!" & vbCrLf & "please fill in the item description, once you are finished " & _
                    " simply click the done button to enter the order into the database" & vbCrLf & vbCrLf & _
                    " Press next Item to move on to the next item")
            GroupBox1.Enabled = True


            scalarcmd = "INSERT INTO [ORDERS] ( [CUSTOMER-NUMBER], [ORDER-NUMBER], " & _
                        "[DATE-PLACED], [DATE-TO-BE-COMPLETED], [TOTAL-ORDER-COST] ) " & _
                        " VALUES(" & cnum.Text & ", " & CType(ordnum, String) & ", '" & _
                        odate.Text & "', '" & rdate.Text & "', 0.00);"
            Try

                conn2.Open()
                Orders2.InsertCommand.CommandText = scalarcmd
                Orders2.InsertCommand.ExecuteNonQuery()
                conn2.Close()

            Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
                MessageBox.Show("Error.  Could not write Order Record to Database")
                indexform.Show()
                Me.Close()
            End Try

        Else
            MsgBox("invalid customer number, try again")
        End If

    End Sub


    Private Sub Button1_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        indexform.Show()
        Me.Close()
    End Sub
End Class
