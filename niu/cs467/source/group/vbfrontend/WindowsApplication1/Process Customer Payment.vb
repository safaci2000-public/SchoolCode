Public Class Process_Customer_Payment
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
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Submit As System.Windows.Forms.Button
    Friend WithEvents Cancel As System.Windows.Forms.Button
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents cmd1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents amt As System.Windows.Forms.TextBox
    Friend WithEvents cnum As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents pdate As System.Windows.Forms.TextBox
    Friend WithEvents Adapter2 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand2 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand2 As System.Data.OleDb.OleDbCommand
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Process_Customer_Payment))
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.pdate = New System.Windows.Forms.TextBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Cancel = New System.Windows.Forms.Button()
        Me.Submit = New System.Windows.Forms.Button()
        Me.amt = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.cnum = New System.Windows.Forms.TextBox()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Adapter1 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.conn1 = New System.Data.OleDb.OleDbConnection()
        Me.OleDbInsertCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand1 = New System.Data.OleDb.OleDbCommand()
        Me.cmd1 = New System.Data.OleDb.OleDbCommand()
        Me.Adapter2 = New System.Data.OleDb.OleDbDataAdapter()
        Me.OleDbDeleteCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbInsertCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbSelectCommand2 = New System.Data.OleDb.OleDbCommand()
        Me.OleDbUpdateCommand2 = New System.Data.OleDb.OleDbCommand()
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
        Me.MenuItem1.Shortcut = System.Windows.Forms.Shortcut.CtrlF4
        Me.MenuItem1.Text = "File"
        '
        'MenuItem2
        '
        Me.MenuItem2.Index = 0
        Me.MenuItem2.Shortcut = System.Windows.Forms.Shortcut.CtrlW
        Me.MenuItem2.Text = "Close"
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.pdate, Me.Label3, Me.Cancel, Me.Submit, Me.amt, Me.Label2, Me.cnum, Me.Label1})
        Me.GroupBox1.Font = New System.Drawing.Font("Monotype Corsiva", 12.0!, System.Drawing.FontStyle.Italic, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.Location = New System.Drawing.Point(48, 48)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(328, 200)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Process Customer Payment"
        '
        'pdate
        '
        Me.pdate.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.pdate.Location = New System.Drawing.Point(168, 104)
        Me.pdate.Name = "pdate"
        Me.pdate.TabIndex = 4
        Me.pdate.Text = ""
        '
        'Label3
        '
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(32, 112)
        Me.Label3.Name = "Label3"
        Me.Label3.TabIndex = 7
        Me.Label3.Text = "Payment Date:"
        '
        'Cancel
        '
        Me.Cancel.BackColor = System.Drawing.Color.Silver
        Me.Cancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Cancel.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Cancel.Location = New System.Drawing.Point(184, 152)
        Me.Cancel.Name = "Cancel"
        Me.Cancel.TabIndex = 6
        Me.Cancel.Text = "Cancel"
        '
        'Submit
        '
        Me.Submit.BackColor = System.Drawing.Color.Silver
        Me.Submit.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Submit.Location = New System.Drawing.Point(80, 152)
        Me.Submit.Name = "Submit"
        Me.Submit.TabIndex = 5
        Me.Submit.Text = "Submit"
        '
        'amt
        '
        Me.amt.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.amt.Location = New System.Drawing.Point(168, 72)
        Me.amt.Name = "amt"
        Me.amt.TabIndex = 3
        Me.amt.Text = "0.00"
        '
        'Label2
        '
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(32, 72)
        Me.Label2.Name = "Label2"
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Amount Paid:"
        '
        'cnum
        '
        Me.cnum.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cnum.Location = New System.Drawing.Point(168, 40)
        Me.cnum.Name = "cnum"
        Me.cnum.TabIndex = 1
        Me.cnum.Text = ""
        '
        'Label1
        '
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(32, 40)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Customer Number:"
        '
        'Adapter1
        '
        Me.Adapter1.DeleteCommand = Me.OleDbDeleteCommand1
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "CUSTOMER", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("CUSTOMER-NEW-BALANCE-OWED", "CUSTOMER-NEW-BALANCE-OWED"), New System.Data.Common.DataColumnMapping("CUSTOMER-PREVIOUS-BALANCE", "CUSTOMER-PREVIOUS-BALANCE")})})
        Me.Adapter1.UpdateCommand = Me.OleDbUpdateCommand1
        '
        'OleDbDeleteCommand1
        '
        Me.OleDbDeleteCommand1.CommandText = "DELETE FROM CUSTOMER WHERE ([CUSTOMER-NUMBER] = ?) AND ([CUSTOMER-NEW-BALANCE-OWE" & _
        "D] = ? OR ? IS NULL AND [CUSTOMER-NEW-BALANCE-OWED] IS NULL) AND ([CUSTOMER-PREV" & _
        "IOUS-BALANCE] = ? OR ? IS NULL AND [CUSTOMER-PREVIOUS-BALANCE] IS NULL)"
        Me.OleDbDeleteCommand1.Connection = Me.conn1
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        '
        'conn1
        '
        Me.conn1.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Password="""";User ID=Admin;Data Source=groupdb.mdb" & _
        ";Mode=Share Deny None;Extended Properties="""";Jet OLEDB:System database="""";Jet O" & _
        "LEDB:Registry Path="""";Jet OLEDB:Database Password="""";Jet OLEDB:Engine Type=5;Jet" & _
        " OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Glo" & _
        "bal Bulk Transactions=1;Jet OLEDB:New Database Password="""";Jet OLEDB:Create Syst" & _
        "em Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don't Copy Locale o" & _
        "n Compact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=Fal" & _
        "se"
        '
        'OleDbInsertCommand1
        '
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO CUSTOMER([CUSTOMER-NEW-BALANCE-OWED], [CUSTOMER-PREVIOUS-BALANCE], [C" & _
        "USTOMER-NUMBER]) VALUES (?, ?, ?)"
        Me.OleDbInsertCommand1.Connection = Me.conn1
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT [CUSTOMER-NEW-BALANCE-OWED], [CUSTOMER-PREVIOUS-BALANCE], [CUSTOMER-NUMBER" & _
        "] FROM CUSTOMER"
        Me.OleDbSelectCommand1.Connection = Me.conn1
        '
        'OleDbUpdateCommand1
        '
        Me.OleDbUpdateCommand1.CommandText = "UPDATE CUSTOMER SET [CUSTOMER-NEW-BALANCE-OWED] = ?, [CUSTOMER-PREVIOUS-BALANCE] " & _
        "= ?, [CUSTOMER-NUMBER] = ? WHERE ([CUSTOMER-NUMBER] = ?) AND ([CUSTOMER-NEW-BALA" & _
        "NCE-OWED] = ? OR ? IS NULL AND [CUSTOMER-NEW-BALANCE-OWED] IS NULL) AND ([CUSTOM" & _
        "ER-PREVIOUS-BALANCE] = ? OR ? IS NULL AND [CUSTOMER-PREVIOUS-BALANCE] IS NULL)"
        Me.OleDbUpdateCommand1.Connection = Me.conn1
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NEW-BALANCE-OWED1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-NEW-BALANCE-OWED", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-PREVIOUS-BALANCE1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "CUSTOMER-PREVIOUS-BALANCE", System.Data.DataRowVersion.Original, Nothing))
        '
        'cmd1
        '
        Me.cmd1.Connection = Me.conn1
        '
        'Adapter2
        '
        Me.Adapter2.DeleteCommand = Me.OleDbDeleteCommand2
        Me.Adapter2.InsertCommand = Me.OleDbInsertCommand2
        Me.Adapter2.SelectCommand = Me.OleDbSelectCommand2
        Me.Adapter2.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "PAYMENT-DETAILS", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("CUSTOMER-NUMBER", "CUSTOMER-NUMBER"), New System.Data.Common.DataColumnMapping("PAYMENT-DATE", "PAYMENT-DATE"), New System.Data.Common.DataColumnMapping("PAYMENT-AMOUNT", "PAYMENT-AMOUNT")})})
        Me.Adapter2.UpdateCommand = Me.OleDbUpdateCommand2
        '
        'OleDbDeleteCommand2
        '
        Me.OleDbDeleteCommand2.CommandText = "DELETE FROM [PAYMENT-DETAILS] WHERE ([CUSTOMER-NUMBER] = ?) AND ([PAYMENT-DATE] =" & _
        " ?) AND ([PAYMENT-AMOUNT] = ? OR ? IS NULL AND [PAYMENT-AMOUNT] IS NULL)"
        Me.OleDbDeleteCommand2.Connection = Me.conn1
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PAYMENT-DATE", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "PAYMENT-DATE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PAYMENT-AMOUNT", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PAYMENT-AMOUNT", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PAYMENT-AMOUNT1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PAYMENT-AMOUNT", System.Data.DataRowVersion.Original, Nothing))
        '
        'OleDbInsertCommand2
        '
        Me.OleDbInsertCommand2.CommandText = "INSERT INTO [PAYMENT-DETAILS] ([CUSTOMER-NUMBER], [PAYMENT-AMOUNT], [PAYMENT-DATE" & _
        "]) VALUES (?, ?, ?)"
        Me.OleDbInsertCommand2.Connection = Me.conn1
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("PAYMENT-AMOUNT", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PAYMENT-AMOUNT", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("PAYMENT-DATE", System.Data.OleDb.OleDbType.DBDate, 0, "PAYMENT-DATE"))
        '
        'OleDbSelectCommand2
        '
        Me.OleDbSelectCommand2.CommandText = "SELECT [CUSTOMER-NUMBER], [PAYMENT-AMOUNT], [PAYMENT-DATE] FROM [PAYMENT-DETAILS]" & _
        ""
        Me.OleDbSelectCommand2.Connection = Me.conn1
        '
        'OleDbUpdateCommand2
        '
        Me.OleDbUpdateCommand2.CommandText = "UPDATE [PAYMENT-DETAILS] SET [CUSTOMER-NUMBER] = ?, [PAYMENT-AMOUNT] = ?, [PAYMEN" & _
        "T-DATE] = ? WHERE ([CUSTOMER-NUMBER] = ?) AND ([PAYMENT-DATE] = ?) AND ([PAYMENT" & _
        "-AMOUNT] = ? OR ? IS NULL AND [PAYMENT-AMOUNT] IS NULL)"
        Me.OleDbUpdateCommand2.Connection = Me.conn1
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("PAYMENT-AMOUNT", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PAYMENT-AMOUNT", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("PAYMENT-DATE", System.Data.OleDb.OleDbType.DBDate, 0, "PAYMENT-DATE"))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_CUSTOMER-NUMBER", System.Data.OleDb.OleDbType.Integer, 0, System.Data.ParameterDirection.Input, False, CType(10, Byte), CType(0, Byte), "CUSTOMER-NUMBER", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PAYMENT-DATE", System.Data.OleDb.OleDbType.DBDate, 0, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "PAYMENT-DATE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PAYMENT-AMOUNT", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PAYMENT-AMOUNT", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand2.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_PAYMENT-AMOUNT1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "PAYMENT-AMOUNT", System.Data.DataRowVersion.Original, Nothing))
        '
        'Process_Customer_Payment
        '
        Me.AcceptButton = Me.Submit
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.CancelButton = Me.Cancel
        Me.ClientSize = New System.Drawing.Size(432, 289)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.GroupBox1})
        Me.Menu = Me.MainMenu1
        Me.Name = "Process_Customer_Payment"
        Me.Text = "Process Customer Payment"
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

    Private Sub Submit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Submit.Click
        Dim current_prev As Double
        Dim current_bal As Double
        Dim updated_prev As Double
        Dim updated_bal As Double
        Dim amt_paid As Double

        amt_paid = CType(amt.Text, Double)

        If amt_paid > 0 Then

            Dim sql1 As String
            Dim sql2 As String
            sql1 = "SELECT [CUSTOMER-PREVIOUS-BALANCE] FROM CUSTOMER" & _
                        " WHERE [CUSTOMER-NUMBER] = " & cnum.Text


            sql2 = "SELECT [CUSTOMER-NEW-BALANCE-OWED] FROM CUSTOMER" & _
                        " WHERE [CUSTOMER-NUMBER] = " & cnum.Text

            cmd1.CommandText = CommandType.Text


            Try

                cmd1.CommandText = sql1
                conn1.Open()

                current_prev = CType(cmd1.ExecuteScalar(), Double)
                cmd1.CommandText = sql2
                current_bal = CType(cmd1.ExecuteScalar(), Double)


            Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
                MessageBox.Show("Invalid Customer Number")
            End Try

            updated_prev = current_bal ' updated previous balance
            updated_bal = current_bal - CType(amt.Text, Double)

            Adapter1.UpdateCommand.CommandText = "UPDATE CUSTOMER SET " & _
                "[CUSTOMER-PREVIOUS-BALANCE] = " & CType(updated_prev, String) & _
                ", [CUSTOMER-NEW-BALANCE-OWED] = " & CType(updated_bal, String) & _
                " WHERE [CUSTOMER-NUMBER] = " & cnum.Text
            Try
                Adapter1.UpdateCommand.ExecuteNonQuery()
            Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
                MessageBox.Show("Error. Could not updated DB")
                indexform.Show()
                Me.Close()
            End Try

            ' record transaction in payment details
            sql1 = "INSERT INTO [PAYMENT-DETAILS]([CUSTOMER-NUMBER], " & _
                    "[PAYMENT-DATE], [PAYMENT-AMOUNT]) VALUES( " & _
                    cnum.Text & ", '" & pdate.Text & "', " & _
                    amt.Text & ")"

            Adapter2.InsertCommand.CommandText = sql1
            'MsgBox(sql1)

            Try
                Adapter2.InsertCommand.ExecuteNonQuery()

            Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
                'MessageBox.Show("Error.  Could not record Payment details transaction." & _
                '                "Make sure you've entered the date in the correct format:  mm/dd/yyyy")
                indexform.Show()
                Me.Close()
            Finally
                conn1.Close()
            End Try


            MsgBox("Transaction Recorded!")
            indexform.Show()
            Me.Close()
        Else
            MsgBox("Your Must Enter an Amount greater then zero")
        End If
    End Sub

    Private Sub GroupBox1_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GroupBox1.Enter

    End Sub

    Private Sub Process_Customer_Payment_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        pdate.Text = Today
    End Sub
End Class
