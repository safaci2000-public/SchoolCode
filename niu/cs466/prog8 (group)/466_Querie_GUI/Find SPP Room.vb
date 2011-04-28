Public Class Find_SPP_Room
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
    Friend WithEvents ComboBox1 As System.Windows.Forms.ComboBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents ComboBox2 As System.Windows.Forms.ComboBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents ComboBox3 As System.Windows.Forms.ComboBox
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents ComboBox4 As System.Windows.Forms.ComboBox
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents Data1 As System.Data.DataSet
    Friend WithEvents Grid1 As System.Windows.Forms.DataGrid
    Friend WithEvents OleDbSelectCommand3 As System.Data.OleDb.OleDbCommand
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Find_SPP_Room))
        Me.Label1 = New System.Windows.Forms.Label()
        Me.ComboBox1 = New System.Windows.Forms.ComboBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.ComboBox2 = New System.Windows.Forms.ComboBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.ComboBox3 = New System.Windows.Forms.ComboBox()
        Me.Button1 = New System.Windows.Forms.Button()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.ComboBox4 = New System.Windows.Forms.ComboBox()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.Data1 = New System.Data.DataSet()
        Me.Grid1 = New System.Windows.Forms.DataGrid()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbSelectCommand3 = New System.Data.OleDb.OleDbCommand()
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.ForeColor = System.Drawing.Color.Snow
        Me.Label1.Location = New System.Drawing.Point(88, 64)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Smoking:"
        '
        'ComboBox1
        '
        Me.ComboBox1.Items.AddRange(New Object() {"Smoking", "Non-Smoking"})
        Me.ComboBox1.Location = New System.Drawing.Point(184, 64)
        Me.ComboBox1.Name = "ComboBox1"
        Me.ComboBox1.Size = New System.Drawing.Size(121, 21)
        Me.ComboBox1.TabIndex = 1
        Me.ComboBox1.Text = "Select One:"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.ForeColor = System.Drawing.Color.Snow
        Me.Label2.Location = New System.Drawing.Point(344, 64)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Pets:"
        '
        'ComboBox2
        '
        Me.ComboBox2.Items.AddRange(New Object() {"Yes", "No"})
        Me.ComboBox2.Location = New System.Drawing.Point(400, 64)
        Me.ComboBox2.Name = "ComboBox2"
        Me.ComboBox2.Size = New System.Drawing.Size(121, 21)
        Me.ComboBox2.TabIndex = 3
        Me.ComboBox2.Text = "Select One:"
        '
        'Label3
        '
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.ForeColor = System.Drawing.Color.Snow
        Me.Label3.Location = New System.Drawing.Point(208, 104)
        Me.Label3.Name = "Label3"
        Me.Label3.TabIndex = 4
        Me.Label3.Text = "Pool:"
        '
        'ComboBox3
        '
        Me.ComboBox3.Items.AddRange(New Object() {"Yes", "No"})
        Me.ComboBox3.Location = New System.Drawing.Point(296, 104)
        Me.ComboBox3.Name = "ComboBox3"
        Me.ComboBox3.Size = New System.Drawing.Size(121, 21)
        Me.ComboBox3.TabIndex = 5
        Me.ComboBox3.Text = "Select One:"
        '
        'Button1
        '
        Me.Button1.BackColor = System.Drawing.Color.Black
        Me.Button1.ForeColor = System.Drawing.Color.SeaShell
        Me.Button1.Location = New System.Drawing.Point(267, 152)
        Me.Button1.Name = "Button1"
        Me.Button1.TabIndex = 6
        Me.Button1.Text = "Search:"
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
        'Label4
        '
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.Label4.ForeColor = System.Drawing.Color.Snow
        Me.Label4.Location = New System.Drawing.Point(200, 16)
        Me.Label4.Name = "Label4"
        Me.Label4.TabIndex = 7
        Me.Label4.Text = "City:"
        '
        'ComboBox4
        '
        Me.ComboBox4.Items.AddRange(New Object() {"DETROIT", "NASHVILLE", "CHICAGO", "INDIANAPOLIS", "MADISON"})
        Me.ComboBox4.Location = New System.Drawing.Point(296, 16)
        Me.ComboBox4.Name = "ComboBox4"
        Me.ComboBox4.Size = New System.Drawing.Size(121, 21)
        Me.ComboBox4.TabIndex = 8
        Me.ComboBox4.Text = "Select City:"
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
        'Data1
        '
        Me.Data1.DataSetName = "NewDataSet"
        Me.Data1.Locale = New System.Globalization.CultureInfo("en-US")
        '
        'Grid1
        '
        Me.Grid1.AlternatingBackColor = System.Drawing.Color.LightGray
        Me.Grid1.BackColor = System.Drawing.Color.DarkGray
        Me.Grid1.CaptionBackColor = System.Drawing.Color.White
        Me.Grid1.CaptionFont = New System.Drawing.Font("Verdana", 10.0!)
        Me.Grid1.CaptionForeColor = System.Drawing.Color.Navy
        Me.Grid1.CaptionText = "Rooms Matching Criteria:"
        Me.Grid1.DataMember = ""
        Me.Grid1.ForeColor = System.Drawing.Color.Black
        Me.Grid1.GridLineColor = System.Drawing.Color.Black
        Me.Grid1.GridLineStyle = System.Windows.Forms.DataGridLineStyle.None
        Me.Grid1.HeaderBackColor = System.Drawing.Color.Silver
        Me.Grid1.HeaderForeColor = System.Drawing.Color.Black
        Me.Grid1.LinkColor = System.Drawing.Color.Navy
        Me.Grid1.Location = New System.Drawing.Point(156, 192)
        Me.Grid1.Name = "Grid1"
        Me.Grid1.ParentRowsBackColor = System.Drawing.Color.White
        Me.Grid1.ParentRowsForeColor = System.Drawing.Color.Black
        Me.Grid1.ReadOnly = True
        Me.Grid1.SelectionBackColor = System.Drawing.Color.Navy
        Me.Grid1.SelectionForeColor = System.Drawing.Color.White
        Me.Grid1.Size = New System.Drawing.Size(296, 248)
        Me.Grid1.TabIndex = 9
        Me.Grid1.Visible = False
        '
        'Adapter1
        '
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand3
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Hotel2", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("Hotel2.IDNum", "Hotel2.IDNum"), New System.Data.Common.DataColumnMapping("city", "city"), New System.Data.Common.DataColumnMapping("numRooms", "numRooms"), New System.Data.Common.DataColumnMapping("pool", "pool"), New System.Data.Common.DataColumnMapping("pets", "pets"), New System.Data.Common.DataColumnMapping("food", "food"), New System.Data.Common.DataColumnMapping("laundry", "laundry"), New System.Data.Common.DataColumnMapping("weightRoom", "weightRoom"), New System.Data.Common.DataColumnMapping("Rooms.IDNum", "Rooms.IDNum"), New System.Data.Common.DataColumnMapping("roomNum", "roomNum"), New System.Data.Common.DataColumnMapping("roomType", "roomType"), New System.Data.Common.DataColumnMapping("smoking", "smoking")})})
        '
        'OleDbSelectCommand3
        '
        Me.OleDbSelectCommand3.CommandText = "SELECT Hotel2.city, Hotel2.food, Hotel2.IDNum, Hotel2.laundry, Hotel2.numRooms, H" & _
        "otel2.pets, Hotel2.pool, Hotel2.weightRoom, Rooms.IDNum AS Expr1, Rooms.roomNum," & _
        " Rooms.roomType, Rooms.smoking FROM Hotel2 INNER JOIN Rooms ON Hotel2.IDNum = Ro" & _
        "oms.IDNum"
        Me.OleDbSelectCommand3.Connection = Me.conn1
        '
        'Find_SPP_Room
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(608, 485)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.Grid1, Me.ComboBox4, Me.Label4, Me.Button1, Me.ComboBox3, Me.Label3, Me.ComboBox2, Me.Label2, Me.ComboBox1, Me.Label1})
        Me.Menu = Me.MainMenu1
        Me.Name = "Find_SPP_Room"
        Me.Text = "Find A Room Based on Pool, Smoking, and Pets Search Criteria"
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region


    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        query.Show()
        Me.Close()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim city As String
        Dim pool As String
        Dim pets As String
        Dim smoking As String
        Dim stuff(3) As String
        Dim sql As String

        pool = "j"      ' initialized to crap
        smoking = "j"
        pets = "j"
        city = "j"

        stuff(0) = ComboBox1.SelectedItem
        stuff(1) = ComboBox2.SelectedItem
        stuff(2) = ComboBox3.SelectedItem
        city = ComboBox4.SelectedItem

        If stuff(0) <> "" Then
            smoking = stuff(0).Chars(0)
        End If
        If stuff(1) <> "" Then
            pets = stuff(1).Chars(0)
        End If
        If stuff(2) <> "" Then
            pool = stuff(2).Chars(0)
        End If


        If pool = "j" Or pets = "j" Or smoking = "j" Or city = "" Then
            MsgBox("Error:  you must select an entry for each available option")
        Else
            Try
                sql = "SELECT h.city, r.roomNum FROM Rooms as r, hotel2 as h WHERE r.IDNum = h.IDNum AND h.city = '" & city & _
                            "' AND smoking = '" & smoking & "' AND h.pool = '" & pool & _
                            "' AND h.pets = '" & pets & "'"

                Adapter1.SelectCommand.CommandText = sql

                Data1.Clear()
                Adapter1.Fill(Data1, "CUSTOMER")

                Grid1.SetDataBinding(Data1, "CUSTOMER")


            Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
                MessageBox.Show("Sorry.  No Rooms were found matching your criteria.")
            End Try
            Grid1.Visible = True

        End If

    End Sub
End Class
