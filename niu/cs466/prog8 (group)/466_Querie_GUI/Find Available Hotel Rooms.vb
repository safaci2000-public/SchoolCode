Public Class Find_Available_Hotel_Rooms
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
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents ToolTip1 As System.Windows.Forms.ToolTip
    Friend WithEvents Data1 As System.Data.DataSet
    Friend WithEvents hotel As System.Windows.Forms.ComboBox
    Friend WithEvents Grid1 As System.Windows.Forms.DataGrid
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents rdate As System.Windows.Forms.TextBox
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Find_Available_Hotel_Rooms))
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.Cancel = New System.Windows.Forms.Button()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.rdate = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.hotel = New System.Windows.Forms.ComboBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.Grid1 = New System.Windows.Forms.DataGrid()
        Me.Data1 = New System.Data.DataSet()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.GroupBox1.SuspendLayout()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).BeginInit()
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
        Me.Cancel.Location = New System.Drawing.Point(176, 136)
        Me.Cancel.Name = "Cancel"
        Me.Cancel.TabIndex = 0
        Me.Cancel.Text = "C&lose"
        Me.ToolTip1.SetToolTip(Me.Cancel, "Abort")
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.rdate, Me.Label2, Me.Button1, Me.hotel, Me.Label1, Me.Cancel})
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.LemonChiffon
        Me.GroupBox1.Location = New System.Drawing.Point(48, 24)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(320, 192)
        Me.GroupBox1.TabIndex = 1
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Find A Room:"
        '
        'rdate
        '
        Me.rdate.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.rdate.Location = New System.Drawing.Point(160, 72)
        Me.rdate.Name = "rdate"
        Me.rdate.Size = New System.Drawing.Size(120, 20)
        Me.rdate.TabIndex = 5
        Me.rdate.Text = ""
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(16, 72)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Date:"
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.Color.LemonChiffon
        Me.Button1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Button1.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Button1.Location = New System.Drawing.Point(56, 136)
        Me.Button1.Name = "Button1"
        Me.Button1.TabIndex = 3
        Me.Button1.Text = "Submit"
        Me.ToolTip1.SetToolTip(Me.Button1, "Request info from database")
        '
        'hotel
        '
        Me.hotel.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.hotel.Items.AddRange(New Object() {"DETROIT", "NASHVILLE", "CHICAGO", "INDIANAPOLIS", "MADISON"})
        Me.hotel.Location = New System.Drawing.Point(160, 32)
        Me.hotel.Name = "hotel"
        Me.hotel.Size = New System.Drawing.Size(121, 21)
        Me.hotel.TabIndex = 2
        Me.hotel.Text = "Select Hotel:"
        Me.ToolTip1.SetToolTip(Me.hotel, "Select the hotel of your choice")
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(24, 32)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Hotel City:"
        '
        'Grid1
        '
        Me.Grid1.DataMember = ""
        Me.Grid1.HeaderForeColor = System.Drawing.SystemColors.ControlText
        Me.Grid1.Location = New System.Drawing.Point(40, 240)
        Me.Grid1.Name = "Grid1"
        Me.Grid1.ReadOnly = True
        Me.Grid1.Size = New System.Drawing.Size(360, 264)
        Me.Grid1.TabIndex = 2
        Me.Grid1.Visible = False
        '
        'Data1
        '
        Me.Data1.DataSetName = "NewDataSet"
        Me.Data1.Locale = New System.Globalization.CultureInfo("en-US")
        '
        'Adapter1
        '
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Rooms", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("Rooms.IDNum", "Rooms.IDNum"), New System.Data.Common.DataColumnMapping("Rooms.roomNum", "Rooms.roomNum"), New System.Data.Common.DataColumnMapping("roomType", "roomType"), New System.Data.Common.DataColumnMapping("smoking", "smoking"), New System.Data.Common.DataColumnMapping("Reservations.IDNum", "Reservations.IDNum"), New System.Data.Common.DataColumnMapping("Reservations.roomNum", "Reservations.roomNum"), New System.Data.Common.DataColumnMapping("Date", "Date"), New System.Data.Common.DataColumnMapping("booked", "booked"), New System.Data.Common.DataColumnMapping("guar", "guar"), New System.Data.Common.DataColumnMapping("filled", "filled"), New System.Data.Common.DataColumnMapping("cnum", "cnum")})})
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT Rooms.IDNum, Rooms.roomNum, Rooms.roomType, Rooms.smoking, Reservations.bo" & _
        "oked, Reservations.cnum, Reservations.[Date], Reservations.filled, Reservations." & _
        "guar, Reservations.IDNum AS Expr1, Reservations.roomNum AS Expr2 FROM Rooms INNE" & _
        "R JOIN Reservations ON Rooms.IDNum = Reservations.IDNum"
        Me.OleDbSelectCommand1.Connection = Me.conn1
        '
        'conn1
        '
        Me.conn1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Password="""";User ID=Admin;Data Source=" & _
        "group.mdb;Mode=Share Deny None;Extended Properties="""";Jet OLEDB:System database="""";Jet " & _
        "OLEDB:Registry Path="""";Jet OLEDB:Database Password="""";Jet OLEDB:Engine Type=5;Je" & _
        "t OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Gl" & _
        "obal Bulk Transactions=1;Jet OLEDB:New Database Password="""";Jet OLEDB:Create Sys" & _
        "tem Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don't Copy Locale " & _
        "on Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=Fa" & _
        "lse"
        '
        'Find_Available_Hotel_Rooms
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(438, 527)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.Grid1, Me.GroupBox1})
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.Menu = Me.MainMenu1
        Me.Name = "Find_Available_Hotel_Rooms"
        Me.Text = "Find_Available_Hotel_Rooms"
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        query.Show()
        Me.Close()
    End Sub

    Private Sub Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel.Click
        query.Show()
        Me.Close()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim hotel1 As String
        Dim hotel_Selected As String
        Dim sql1 As String
        Dim sql2 As String

        hotel1 = hotel.SelectedItem
        hotel_Selected = hotel1
        Grid1.Visible = True


        'SELECT h.city, h.idnum, v.roomnum
        'FROM reservations AS v, hotel2 AS h
        'WHERE(v.idnum = h.idnum And h.city = "CHICAGO" And v.date = #9/1/2002# And v.booked = "N" And v.guar = "N" And v.filled = "N")
        'ORDER BY v.idnum, v.roomnum;

        sql2 = "SELECT h.city, h.idnum, v.roomnum FROM reservations As v, hotel2 As h" & _
                " WHERE (v.idnum = h.idnum And h.city = '" & hotel1 & "' And v.date = '" & _
                rdate.Text & "' And v.booked = 'N' And v.filled = 'N' And v.guar = 'N')" & _
                " ORDER BY v.idnum, v.roomnum"

        sql1 = "SELECT r.roomNum, r.roomType, " & _
              "r.smocking FROM Rooms AS r, Reservations AS s " & _
              " WHERE (r.IDNum = s.IDNum AND r.IDNum = " & _
              hotel_Selected & " AND s.booked = 'N' AND s.Date = '" & _
              rdate.Text & "')"

        'MsgBox(sql2)

        Try
            conn1.Open()
            Adapter1.SelectCommand.CommandText = sql2

            Data1.Clear()
            Adapter1.Fill(Data1, "Rooms")
            Grid1.SetDataBinding(Data1, "Rooms")
        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MsgBox("Error.  Could not fetch rooms")
        Finally
            conn1.Close()
        End Try

        MsgBox("Choose File, Close once you are done")

    End Sub

    Private Sub Find_Available_Hotel_Rooms_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        rdate.Text = Today
    End Sub
End Class
