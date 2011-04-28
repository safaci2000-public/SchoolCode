Public Class Charge_History
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
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents cnum As System.Windows.Forms.TextBox
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents Data1 As System.Data.DataSet
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Grid1 As System.Windows.Forms.DataGrid
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Charge_History))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.cnum = New System.Windows.Forms.TextBox()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.Data1 = New System.Data.DataSet()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.Grid1 = New System.Windows.Forms.DataGrid()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.ForeColor = System.Drawing.Color.Snow
        Me.Label1.Location = New System.Drawing.Point(32, 40)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(112, 24)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Customer Number:"
        '
        'cnum
        '
        Me.cnum.Location = New System.Drawing.Point(176, 40)
        Me.cnum.Name = "cnum"
        Me.cnum.TabIndex = 1
        Me.cnum.Text = ""
        '
        'Adapter1
        '
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Charges", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("Date", "Date"), New System.Data.Common.DataColumnMapping("Chargetype", "Chargetype"), New System.Data.Common.DataColumnMapping("ChargeAmt", "ChargeAmt"), New System.Data.Common.DataColumnMapping("ChargeDisc", "ChargeDisc"), New System.Data.Common.DataColumnMapping("CustNum", "CustNum")})})
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
        'Data1
        '
        Me.Data1.DataSetName = "NewDataSet"
        Me.Data1.Locale = New System.Globalization.CultureInfo("en-US")
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.Color.Black
        Me.Button1.ForeColor = System.Drawing.Color.Snow
        Me.Button1.Location = New System.Drawing.Point(168, 96)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(128, 23)
        Me.Button1.TabIndex = 2
        Me.Button1.Text = "Fetch Charge History"
        '
        'Grid1
        '
        Me.Grid1.AlternatingBackColor = System.Drawing.Color.LightGray
        Me.Grid1.BackColor = System.Drawing.Color.DarkGray
        Me.Grid1.CaptionBackColor = System.Drawing.Color.White
        Me.Grid1.CaptionFont = New System.Drawing.Font("Verdana", 10.0!)
        Me.Grid1.CaptionForeColor = System.Drawing.Color.Navy
        Me.Grid1.CaptionText = "Customer History:"
        Me.Grid1.DataMember = ""
        Me.Grid1.ForeColor = System.Drawing.Color.Black
        Me.Grid1.GridLineColor = System.Drawing.Color.Black
        Me.Grid1.GridLineStyle = System.Windows.Forms.DataGridLineStyle.None
        Me.Grid1.HeaderBackColor = System.Drawing.Color.Silver
        Me.Grid1.HeaderForeColor = System.Drawing.Color.Black
        Me.Grid1.LinkColor = System.Drawing.Color.Navy
        Me.Grid1.Location = New System.Drawing.Point(72, 152)
        Me.Grid1.Name = "Grid1"
        Me.Grid1.ParentRowsBackColor = System.Drawing.Color.White
        Me.Grid1.ParentRowsForeColor = System.Drawing.Color.Black
        Me.Grid1.SelectionBackColor = System.Drawing.Color.Navy
        Me.Grid1.SelectionForeColor = System.Drawing.Color.White
        Me.Grid1.Size = New System.Drawing.Size(488, 256)
        Me.Grid1.TabIndex = 3
        Me.Grid1.Visible = False
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
        'Charge_History
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(656, 445)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.Grid1, Me.Button1, Me.cnum, Me.Label1})
        Me.Menu = Me.MainMenu1
        Me.Name = "Charge_History"
        Me.Text = "Customer Charge History:"
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub Charge_History_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            Adapter1.SelectCommand.CommandText = _
                        "SELECT Date, Chargetype, ChargeAmt, ChargeDisc FROM Charges " & _
                        " WHERE CustNum = " & cnum.Text

            Data1.Clear()
            Adapter1.Fill(Data1, "CUSTOMER")

            Grid1.SetDataBinding(Data1, "CUSTOMER")


        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
        End Try
        Grid1.Visible = True       ' makes grid visible.

    End Sub

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        query.Show()
        Me.Close()
    End Sub

    Private Sub Grid1_Navigate(ByVal sender As System.Object, ByVal ne As System.Windows.Forms.NavigateEventArgs) Handles Grid1.Navigate

    End Sub
End Class
