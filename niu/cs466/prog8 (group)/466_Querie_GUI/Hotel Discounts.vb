Public Class Hotel_Discounts
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
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents Data1 As System.Data.DataSet
    Friend WithEvents Grid1 As System.Windows.Forms.DataGrid
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Hotel_Discounts))
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.Data1 = New System.Data.DataSet()
        Me.Grid1 = New System.Windows.Forms.DataGrid()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'Adapter1
        '
        Me.Adapter1.DeleteCommand = Me.OleDbDeleteCommand1
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Customers", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("custNum", "custNum"), New System.Data.Common.DataColumnMapping("lastName", "lastName"), New System.Data.Common.DataColumnMapping("firstName", "firstName"), New System.Data.Common.DataColumnMapping("discType", "discType")})})
        Me.Adapter1.UpdateCommand = Me.OleDbUpdateCommand1
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
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO Customers(custNum, discType, firstName, lastName) VALUES (?, ?, ?, ?)" & _
        ""
        Me.OleDbInsertCommand1.Connection = Me.conn1
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("discType", System.Data.OleDb.OleDbType.VarWChar, 2, "discType"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("firstName", System.Data.OleDb.OleDbType.VarWChar, 10, "firstName"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("lastName", System.Data.OleDb.OleDbType.VarWChar, 15, "lastName"))
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT custNum, discType, firstName, lastName FROM Customers"
        Me.OleDbSelectCommand1.Connection = Me.conn1
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
        Me.Grid1.CaptionText = "The Following Customers Have Hotel Discounts:"
        Me.Grid1.DataMember = ""
        Me.Grid1.DataSource = Me.Data1
        Me.Grid1.ForeColor = System.Drawing.Color.Black
        Me.Grid1.GridLineColor = System.Drawing.Color.Black
        Me.Grid1.GridLineStyle = System.Windows.Forms.DataGridLineStyle.None
        Me.Grid1.HeaderBackColor = System.Drawing.Color.Silver
        Me.Grid1.HeaderForeColor = System.Drawing.Color.Black
        Me.Grid1.LinkColor = System.Drawing.Color.Navy
        Me.Grid1.Location = New System.Drawing.Point(84, 40)
        Me.Grid1.Name = "Grid1"
        Me.Grid1.ParentRowsBackColor = System.Drawing.Color.White
        Me.Grid1.ParentRowsForeColor = System.Drawing.Color.Black
        Me.Grid1.ReadOnly = True
        Me.Grid1.SelectionBackColor = System.Drawing.Color.Navy
        Me.Grid1.SelectionForeColor = System.Drawing.Color.White
        Me.Grid1.Size = New System.Drawing.Size(348, 320)
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
        'Hotel_Discounts
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(616, 401)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.Grid1})
        Me.Menu = Me.MainMenu1
        Me.Name = "Hotel_Discounts"
        Me.Text = "Hotel_Discounts"
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Grid1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub Hotel_Discounts_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try
            Adapter1.SelectCommand.CommandText = _
                        "SELECT firstName, lastName FROM Customers WHERE discType = 'C' OR " & _
                        " discType = 'B' "

            Data1.Clear()
            Adapter1.Fill(Data1, "CUSTOMER")

            Grid1.SetDataBinding(Data1, "CUSTOMER")


        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
        End Try

    End Sub

    Private Sub MenuItem2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MenuItem2.Click
        query.Show()
        Me.Close()
    End Sub
End Class
