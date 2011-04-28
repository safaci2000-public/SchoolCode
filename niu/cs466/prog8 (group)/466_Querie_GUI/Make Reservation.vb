Public Class Make_Reservation
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
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    Friend WithEvents Cancel As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents ComboBox1 As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents ToolTip1 As System.Windows.Forms.ToolTip
    Friend WithEvents rdate As System.Windows.Forms.TextBox
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents rnum As System.Windows.Forms.TextBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents cnum As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Make_Reservation))
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.Cancel = New System.Windows.Forms.Button()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.rdate = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.rnum = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.ComboBox1 = New System.Windows.Forms.ComboBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.cnum = New System.Windows.Forms.TextBox()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
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
        'Cancel
        '
        Me.Cancel.BackColor = System.Drawing.Color.LemonChiffon
        Me.Cancel.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Cancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Cancel.Location = New System.Drawing.Point(168, 200)
        Me.Cancel.Name = "Cancel"
        Me.Cancel.TabIndex = 0
        Me.Cancel.Text = "Cancel"
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.cnum, Me.Label4, Me.Button1, Me.rdate, Me.Label3, Me.rnum, Me.Label2, Me.ComboBox1, Me.Label1, Me.Cancel})
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.LemonChiffon
        Me.GroupBox1.Location = New System.Drawing.Point(24, 24)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(312, 248)
        Me.GroupBox1.TabIndex = 1
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Make Reservation:"
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.Color.LemonChiffon
        Me.Button1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Button1.Location = New System.Drawing.Point(40, 200)
        Me.Button1.Name = "Button1"
        Me.Button1.TabIndex = 9
        Me.Button1.Text = "Submit"
        '
        'rdate
        '
        Me.rdate.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.rdate.Location = New System.Drawing.Point(168, 112)
        Me.rdate.Name = "rdate"
        Me.rdate.TabIndex = 8
        Me.rdate.Text = ""
        Me.ToolTip1.SetToolTip(Me.rdate, "What is the reservation date?")
        '
        'Label3
        '
        Me.Label3.Location = New System.Drawing.Point(24, 112)
        Me.Label3.Name = "Label3"
        Me.Label3.TabIndex = 7
        Me.Label3.Text = "Date:"
        '
        'rnum
        '
        Me.rnum.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.rnum.Location = New System.Drawing.Point(168, 80)
        Me.rnum.MaxLength = 2
        Me.rnum.Name = "rnum"
        Me.rnum.TabIndex = 6
        Me.rnum.Text = ""
        Me.ToolTip1.SetToolTip(Me.rnum, "What Room do you wish to stay in?")
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(16, 72)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 5
        Me.Label2.Text = "Room Number:"
        '
        'ComboBox1
        '
        Me.ComboBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ComboBox1.Items.AddRange(New Object() {"111 = Detroit", "222 = Nashville", "333 = Chicago", "444 = Indianapolis", "555 = Nashville", "666 = Madison"})
        Me.ComboBox1.Location = New System.Drawing.Point(160, 40)
        Me.ComboBox1.Name = "ComboBox1"
        Me.ComboBox1.Size = New System.Drawing.Size(121, 21)
        Me.ComboBox1.TabIndex = 4
        Me.ComboBox1.Text = "Select Hotel:"
        Me.ToolTip1.SetToolTip(Me.ComboBox1, "Select the hotel of your choice")
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(24, 40)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "Hotel ID:"
        '
        'Adapter1
        '
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Reservations", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("IDNum", "IDNum"), New System.Data.Common.DataColumnMapping("roomNum", "roomNum"), New System.Data.Common.DataColumnMapping("Date", "Date"), New System.Data.Common.DataColumnMapping("booked", "booked"), New System.Data.Common.DataColumnMapping("guar", "guar"), New System.Data.Common.DataColumnMapping("filled", "filled"), New System.Data.Common.DataColumnMapping("cnum", "cnum")})})
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT booked, cnum, [Date], filled, guar, IDNum, roomNum FROM Reservations"
        Me.OleDbSelectCommand1.Connection = Me.conn1
        '
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO Reservations(booked, cnum, [Date], filled, guar, IDNum, roomNum) VALU" & _
        "ES (?, ?, ?, ?, ?, ?, ?)"
        Me.OleDbInsertCommand1.Connection = Me.conn1
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("booked", System.Data.OleDb.OleDbType.VarWChar, 255, "booked"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("cnum", System.Data.OleDb.OleDbType.Double, 0, System.Data.ParameterDirection.Input, False, CType(15, Byte), CType(0, Byte), "cnum", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Date", System.Data.OleDb.OleDbType.DBDate, 0, "Date"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("filled", System.Data.OleDb.OleDbType.VarWChar, 255, "filled"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("guar", System.Data.OleDb.OleDbType.VarWChar, 255, "guar"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("IDNum", System.Data.OleDb.OleDbType.Double, 0, System.Data.ParameterDirection.Input, False, CType(15, Byte), CType(0, Byte), "IDNum", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("roomNum", System.Data.OleDb.OleDbType.Double, 0, System.Data.ParameterDirection.Input, False, CType(15, Byte), CType(0, Byte), "roomNum", System.Data.DataRowVersion.Current, Nothing))
        '
        'conn1
        '
        Me.conn1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Password="""";User ID=Admin;Data Source=group.m" & _
        "db;Mode=Share Deny None;Extended Properties="""";Jet OLEDB:System database="""";Jet " & _
        "OLEDB:Registry Path="""";Jet OLEDB:Database Password="""";Jet OLEDB:Engine Type=5;Je" & _
        "t OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Gl" & _
        "obal Bulk Transactions=1;Jet OLEDB:New Database Password="""";Jet OLEDB:Create Sys" & _
        "tem Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don't Copy Locale " & _
        "on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=Fa" & _
        "lse"
        '
        'Label4
        '
        Me.Label4.Location = New System.Drawing.Point(24, 152)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(104, 23)
        Me.Label4.TabIndex = 10
        Me.Label4.Text = "Customer Number:"
        '
        'cnum
        '
        Me.cnum.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cnum.Location = New System.Drawing.Point(168, 152)
        Me.cnum.Name = "cnum"
        Me.cnum.TabIndex = 11
        Me.cnum.Text = ""
        '
        'Make_Reservation
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(376, 295)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.GroupBox1})
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.Menu = Me.MainMenu1
        Me.Name = "Make_Reservation"
        Me.Text = "Make_Reservation"
        Me.GroupBox1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel.Click
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Make_Reservation_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        rdate.Text = "0" + Today
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim sSql As String
        Dim hotel1 As String
        Dim hotel_select As String

        hotel1 = ComboBox1.SelectedItem
        hotel_select = hotel1.Chars(0) + hotel1.Chars(1) + hotel1.Chars(2)

        sSql = "INSERT INTO Reservations(IDNum, " & _
                "roomNum, Date, booked, guar, filled, cnum)" & _
                " VALUES (" & hotel_select & ", " & rnum.Text & ", '" & rdate.Text & _
                "' , 'Y', 'Y', 'Y', " & cnum.Text & ")"

        Adapter1.InsertCommand.CommandText = sSql
        Try
            conn1.Open()
            Adapter1.InsertCommand.ExecuteNonQuery()

        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
            indexform.Show()
            Me.Close()
        Finally
            conn1.Close()
        End Try
        'MsgBox("Database updated, press Ok to continue")
        indexform.Show()
        Me.Close()

    End Sub
End Class
