Public Class Add_Customer_Charge
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
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents crgdate As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents crgtype As System.Windows.Forms.ComboBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents cnum As System.Windows.Forms.TextBox
    Friend WithEvents Submit As System.Windows.Forms.Button
    Friend WithEvents Cancel As System.Windows.Forms.Button
    Friend WithEvents ToolTip1 As System.Windows.Forms.ToolTip
    Friend WithEvents cmd1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents camount As System.Windows.Forms.TextBox
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents Adapter2 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Add_Customer_Charge))
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.Cancel = New System.Windows.Forms.Button()
        Me.Submit = New System.Windows.Forms.Button()
        Me.cnum = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.camount = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.crgtype = New System.Windows.Forms.ComboBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.crgdate = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cmd1 = New System.Data.OleDb.OleDbCommand()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.Adapter2 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbSelectCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbInsertCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbDeleteCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.Cancel, Me.Submit, Me.cnum, Me.Label5, Me.camount, Me.Label3, Me.crgtype, Me.Label2, Me.crgdate, Me.Label1})
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.LemonChiffon
        Me.GroupBox1.Location = New System.Drawing.Point(40, 24)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(336, 224)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Add Customer Charge:"
        '
        'Cancel
        '
        Me.Cancel.BackColor = System.Drawing.Color.LemonChiffon
        Me.Cancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Cancel.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Cancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Cancel.Location = New System.Drawing.Point(184, 176)
        Me.Cancel.Name = "Cancel"
        Me.Cancel.TabIndex = 11
        Me.Cancel.Text = "Cancel"
        '
        'Submit
        '
        Me.Submit.BackColor = System.Drawing.Color.LemonChiffon
        Me.Submit.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Submit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Submit.Location = New System.Drawing.Point(80, 176)
        Me.Submit.Name = "Submit"
        Me.Submit.TabIndex = 10
        Me.Submit.Text = "Submit"
        '
        'cnum
        '
        Me.cnum.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cnum.Location = New System.Drawing.Point(176, 128)
        Me.cnum.Name = "cnum"
        Me.cnum.TabIndex = 9
        Me.cnum.Text = ""
        Me.ToolTip1.SetToolTip(Me.cnum, "What customer is this charged applied to?")
        '
        'Label5
        '
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.Location = New System.Drawing.Point(24, 128)
        Me.Label5.Name = "Label5"
        Me.Label5.TabIndex = 8
        Me.Label5.Text = "Cust Num:"
        '
        'camount
        '
        Me.camount.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.camount.Location = New System.Drawing.Point(176, 96)
        Me.camount.Name = "camount"
        Me.camount.TabIndex = 5
        Me.camount.Text = ""
        Me.ToolTip1.SetToolTip(Me.camount, "What is the amount of the charge?")
        '
        'Label3
        '
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(24, 96)
        Me.Label3.Name = "Label3"
        Me.Label3.TabIndex = 4
        Me.Label3.Text = "Charge Amount:"
        '
        'crgtype
        '
        Me.crgtype.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.crgtype.Items.AddRange(New Object() {"Food", "Telephone", "Room"})
        Me.crgtype.Location = New System.Drawing.Point(176, 64)
        Me.crgtype.Name = "crgtype"
        Me.crgtype.Size = New System.Drawing.Size(121, 21)
        Me.crgtype.TabIndex = 3
        Me.crgtype.Text = "Select One"
        Me.ToolTip1.SetToolTip(Me.crgtype, "What type of charge was it?")
        '
        'Label2
        '
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(24, 64)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Charge Type:"
        '
        'crgdate
        '
        Me.crgdate.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.crgdate.Location = New System.Drawing.Point(176, 32)
        Me.crgdate.MaxLength = 20
        Me.crgdate.Name = "crgdate"
        Me.crgdate.TabIndex = 1
        Me.crgdate.Text = ""
        Me.ToolTip1.SetToolTip(Me.crgdate, "What is the date the charge was issued?")
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(24, 32)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Date:"
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
        'cmd1
        '
        Me.cmd1.Connection = Me.conn1
        '
        'Adapter1
        '
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Charges", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("ChargeAmt", "ChargeAmt"), New System.Data.Common.DataColumnMapping("ChargeDisc", "ChargeDisc"), New System.Data.Common.DataColumnMapping("Chargetype", "Chargetype"), New System.Data.Common.DataColumnMapping("CustNum", "CustNum"), New System.Data.Common.DataColumnMapping("Date", "Date")})})
        '
        'Adapter2
        '
        Me.Adapter2.DeleteCommand = Me.OleDbDeleteCommand1
        Me.Adapter2.InsertCommand = Me.OleDbInsertCommand2
        Me.Adapter2.SelectCommand = Me.OleDbSelectCommand2
        Me.Adapter2.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Customers", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("custNum", "custNum"), New System.Data.Common.DataColumnMapping("discType", "discType"), New System.Data.Common.DataColumnMapping("firstName", "firstName"), New System.Data.Common.DataColumnMapping("lastName", "lastName")})})
        Me.Adapter2.UpdateCommand = Me.OleDbUpdateCommand1
        '
        'OleDbSelectCommand2
        '
        Me.OleDbSelectCommand2.CommandText = "SELECT custNum, discType, firstName, lastName FROM Customers"
        Me.OleDbSelectCommand2.Connection = Me.conn1
        '
        'OleDbInsertCommand2
        '
        Me.OleDbInsertCommand2.CommandText = "INSERT INTO Customers(custNum, discType, firstName, lastName) VALUES (?, ?, ?, ?)" & _
        ""
        Me.OleDbInsertCommand2.Connection = Me.conn1
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("discType", System.Data.OleDb.OleDbType.VarWChar, 2, "discType"))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("firstName", System.Data.OleDb.OleDbType.VarWChar, 10, "firstName"))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("lastName", System.Data.OleDb.OleDbType.VarWChar, 15, "lastName"))
        '
        'OleDbUpdateCommand1
        '
        Me.OleDbUpdateCommand1.CommandText = "UPDATE Customers SET custNum = ?, discType = ?, firstName = ?, lastName = ? WHERE" & _
        " (custNum = ?) AND (discType = ? OR ? IS NULL AND discType IS NULL) AND (firstNa" & _
        "me = ? OR ? IS NULL AND firstName IS NULL) AND (lastName = ? OR ? IS NULL AND la" & _
        "stName IS NULL)"
        Me.OleDbUpdateCommand1.Connection = Me.conn1
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("discType", System.Data.OleDb.OleDbType.VarWChar, 2, "discType"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("firstName", System.Data.OleDb.OleDbType.VarWChar, 10, "firstName"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("lastName", System.Data.OleDb.OleDbType.VarWChar, 15, "lastName"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_discType", System.Data.OleDb.OleDbType.VarWChar, 2, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "discType", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_discType1", System.Data.OleDb.OleDbType.VarWChar, 2, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "discType", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_firstName", System.Data.OleDb.OleDbType.VarWChar, 10, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "firstName", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_firstName1", System.Data.OleDb.OleDbType.VarWChar, 10, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "firstName", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_lastName", System.Data.OleDb.OleDbType.VarWChar, 15, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "lastName", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_lastName1", System.Data.OleDb.OleDbType.VarWChar, 15, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "lastName", System.Data.DataRowVersion.Original, Nothing))
        '
        'OleDbDeleteCommand1
        '
        Me.OleDbDeleteCommand1.CommandText = "DELETE FROM Customers WHERE (custNum = ?) AND (discType = ? OR ? IS NULL AND disc" & _
        "Type IS NULL) AND (firstName = ? OR ? IS NULL AND firstName IS NULL) AND (lastNa" & _
        "me = ? OR ? IS NULL AND lastName IS NULL)"
        Me.OleDbDeleteCommand1.Connection = Me.conn1
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_discType", System.Data.OleDb.OleDbType.VarWChar, 2, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "discType", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_discType1", System.Data.OleDb.OleDbType.VarWChar, 2, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "discType", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_firstName", System.Data.OleDb.OleDbType.VarWChar, 10, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "firstName", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_firstName1", System.Data.OleDb.OleDbType.VarWChar, 10, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "firstName", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_lastName", System.Data.OleDb.OleDbType.VarWChar, 15, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "lastName", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_lastName1", System.Data.OleDb.OleDbType.VarWChar, 15, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "lastName", System.Data.DataRowVersion.Original, Nothing))
        '
        'conn1
        '
        Me.conn1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Password="""";User ID=Admin;Data Source=" & _
        "group.mdb;Mode=Share Deny None;Exten" & _
        "ded Properties="""";Jet OLEDB:System database="""";Jet OLEDB:Registry Path="""";Jet OL" & _
        "EDB:Database Password="""";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode" & _
        "=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet " & _
        "OLEDB:New Database Password="""";Jet OLEDB:Create System Database=False;Jet OLEDB:" & _
        "Encrypt Database=False;Jet OLEDB:Don't Copy Locale on Compact=False;Jet OLEDB:Co" & _
        "mpact Without Replica Repair=False;Jet OLEDB:SFP=False"
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT ChargeAmt, ChargeDisc, Chargetype, CustNum, [Date] FROM Charges"
        Me.OleDbSelectCommand1.Connection = Me.conn1
        '
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO Charges(ChargeAmt, ChargeDisc, Chargetype, CustNum, [Date]) VALUES (?" & _
        ", ?, ?, ?, ?)"
        Me.OleDbInsertCommand1.Connection = Me.conn1
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ChargeAmt", System.Data.OleDb.OleDbType.Double, 0, System.Data.ParameterDirection.Input, False, CType(15, Byte), CType(0, Byte), "ChargeAmt", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("ChargeDisc", System.Data.OleDb.OleDbType.Double, 0, System.Data.ParameterDirection.Input, False, CType(15, Byte), CType(0, Byte), "ChargeDisc", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Chargetype", System.Data.OleDb.OleDbType.VarWChar, 255, "Chargetype"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CustNum", System.Data.OleDb.OleDbType.Double, 0, System.Data.ParameterDirection.Input, False, CType(15, Byte), CType(0, Byte), "CustNum", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Date", System.Data.OleDb.OleDbType.DBDate, 0, "Date"))
        '
        'Add_Customer_Charge
        '
        Me.AcceptButton = Me.Submit
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.CancelButton = Me.Cancel
        Me.ClientSize = New System.Drawing.Size(416, 279)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.GroupBox1})
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.Menu = Me.MainMenu1
        Me.Name = "Add_Customer_Charge"
        Me.Text = "Add_Customer_Charge"
        Me.GroupBox1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Submit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Submit.Click

        Dim sSql As String
        Dim sSql2 As String
        Dim discount As String
        Dim discValue As Double

        discValue = 0.0

        sSql2 = "SELECT discType from Customers WHERE CustNum = " & cnum.Text
        cmd1.CommandText = CommandType.Text

        Try
            conn1.Open()
            cmd1.CommandText = sSql2
            discount = cmd1.ExecuteScalar()
        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Error.  Could not obtain Discount Type!")
        End Try

        ' calculate Discount Amount
        If discount <> "" And CType(camount.Text, Double) >= 100 Then
            discValue = CType(camount.Text, Double) * 0.1
        End If


        Dim crgselected As String
        Dim stuff As String
        stuff = crgtype.SelectedItem
        crgselected = stuff.Chars(0)

        sSql = "INSERT INTO Charges(Date, " & _
                "Chargetype, ChargeAmt, ChargeDisc, CustNum) " & _
                " VALUES (#" & crgdate.Text & "#, '" & crgselected & _
                "', " & camount.Text & ", " & CType(discValue, String) & _
                ", " & cnum.Text & " )"



        Adapter1.InsertCommand.CommandText = sSql

        Try
            Adapter1.InsertCommand.ExecuteNonQuery()

        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Error.  Could not Add Charge To Database")
        End Try

        indexform.Show()
        Me.Close()
    End Sub


    Private Sub Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel.Click
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Add_Customer_Charge_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        crgdate.Text = Today
    End Sub

End Class
