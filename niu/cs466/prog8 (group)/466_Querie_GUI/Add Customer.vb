Public Class Add_Customer
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
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents MainMenu1 As System.Windows.Forms.MainMenu
    Friend WithEvents MenuItem1 As System.Windows.Forms.MenuItem
    Friend WithEvents MenuItem2 As System.Windows.Forms.MenuItem
    Friend WithEvents Submit As System.Windows.Forms.Button
    Friend WithEvents Cancel As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents fname As System.Windows.Forms.TextBox
    Friend WithEvents lname As System.Windows.Forms.TextBox
    Friend WithEvents ToolTip1 As System.Windows.Forms.ToolTip
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents Data1 As System.Data.DataSet
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents cmd1 As System.Data.OleDb.OleDbCommand
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Add_Customer))
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.lname = New System.Windows.Forms.TextBox()
        Me.fname = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Cancel = New System.Windows.Forms.Button()
        Me.Submit = New System.Windows.Forms.Button()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.Data1 = New System.Data.DataSet()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.cmd1 = New System.Data.OleDb.OleDbCommand()
        Me.GroupBox1.SuspendLayout()
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.lname, Me.fname, Me.Label2, Me.Label1, Me.Cancel, Me.Submit})
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.LemonChiffon
        Me.GroupBox1.Location = New System.Drawing.Point(48, 32)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(344, 176)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Add New Customer:"
        '
        'lname
        '
        Me.lname.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lname.Location = New System.Drawing.Point(200, 64)
        Me.lname.Name = "lname"
        Me.lname.TabIndex = 5
        Me.lname.Text = ""
        Me.ToolTip1.SetToolTip(Me.lname, "Type in Your Last Name")
        '
        'fname
        '
        Me.fname.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fname.Location = New System.Drawing.Point(200, 32)
        Me.fname.Name = "fname"
        Me.fname.TabIndex = 4
        Me.fname.Text = ""
        Me.ToolTip1.SetToolTip(Me.fname, "Type in Your First Name")
        '
        'Label2
        '
        Me.Label2.Location = New System.Drawing.Point(16, 64)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Last Name:"
        '
        'Label1
        '
        Me.Label1.Location = New System.Drawing.Point(16, 32)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "First Name:"
        '
        'Cancel
        '
        Me.Cancel.BackColor = System.Drawing.Color.LemonChiffon
        Me.Cancel.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Cancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Cancel.Location = New System.Drawing.Point(184, 112)
        Me.Cancel.Name = "Cancel"
        Me.Cancel.TabIndex = 1
        Me.Cancel.Text = "Cancel"
        Me.ToolTip1.SetToolTip(Me.Cancel, "Abort")
        '
        'Submit
        '
        Me.Submit.BackColor = System.Drawing.Color.LemonChiffon
        Me.Submit.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Submit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.Submit.Location = New System.Drawing.Point(80, 112)
        Me.Submit.Name = "Submit"
        Me.Submit.TabIndex = 0
        Me.Submit.Text = "Submit"
        Me.ToolTip1.SetToolTip(Me.Submit, "Write Data to Database")
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
        Me.Data1.DataSetName = "Data1"
        Me.Data1.Locale = New System.Globalization.CultureInfo("en-US")
        '
        'Adapter1
        '
        Me.Adapter1.DeleteCommand = Me.OleDbDeleteCommand1
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "Customers", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("custNum", "custNum")})})
        Me.Adapter1.UpdateCommand = Me.OleDbUpdateCommand1
        '
        'OleDbDeleteCommand1
        '
        Me.OleDbDeleteCommand1.CommandText = "DELETE FROM Customers WHERE (custNum = ?)"
        Me.OleDbDeleteCommand1.Connection = Me.conn1
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Original, Nothing))
        '
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO Customers(custNum) VALUES (?)"
        Me.OleDbInsertCommand1.Connection = Me.conn1
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Current, Nothing))
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT custNum FROM Customers"
        Me.OleDbSelectCommand1.Connection = Me.conn1
        '
        'OleDbUpdateCommand1
        '
        Me.OleDbUpdateCommand1.CommandText = "UPDATE Customers SET custNum = ? WHERE (custNum = ?)"
        Me.OleDbUpdateCommand1.Connection = Me.conn1
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_custNum", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "custNum", System.Data.DataRowVersion.Original, Nothing))
        '
        'cmd1
        '
        Me.cmd1.Connection = Me.conn1
        '
        'Add_Customer
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.ClientSize = New System.Drawing.Size(440, 247)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.GroupBox1})
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.Menu = Me.MainMenu1
        Me.Name = "Add_Customer"
        Me.Text = "Add_Customer"
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.Data1, System.ComponentModel.ISupportInitialize).EndInit()
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

    Private Sub Submit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Submit.Click

        Dim sSql As String

        sSql = "INSERT INTO Customers(custNum, " & _
                "lastName, firstName)" & _
                " VALUES (" & CType(cnum, String) & _
                " , '" & lname.Text & "', '" & fname.Text & "')"

        Adapter1.InsertCommand.CommandText = sSql

        Try
            Adapter1.InsertCommand.ExecuteNonQuery()

        Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
            MessageBox.Show("Invalid Query")
        End Try
        MsgBox("Database updated, press Ok to continue")
        indexform.Show()
        Me.Close()
    End Sub

    Private Sub Add_Customer_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        Dim scalarcmd As String
        scalarcmd = "SELECT MAX(custNum) FROM CUSTOMERS"
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
