Public Class Update_Labor_Costs
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
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Cancel As System.Windows.Forms.Button
    Friend WithEvents Submit As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents Adapter1 As System.Data.OleDb.OleDbDataAdapter
    Friend WithEvents OleDbSelectCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbInsertCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbUpdateCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents OleDbDeleteCommand1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents conn1 As System.Data.OleDb.OleDbConnection
    Friend WithEvents cmd1 As System.Data.OleDb.OleDbCommand
    Friend WithEvents code As System.Windows.Forms.TextBox
    Friend WithEvents cost As System.Windows.Forms.TextBox
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(Update_Labor_Costs))
        Me.code = New System.Windows.Forms.TextBox()
        Me.MainMenu1 = New System.Windows.Forms.MainMenu()
        Me.MenuItem1 = New System.Windows.Forms.MenuItem()
        Me.MenuItem2 = New System.Windows.Forms.MenuItem()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.cost = New System.Windows.Forms.TextBox()
        Me.Submit = New System.Windows.Forms.Button()
        Me.Cancel = New System.Windows.Forms.Button()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
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
        'code
        '
        Me.code.Location = New System.Drawing.Point(160, 48)
        Me.code.MaxLength = 1
        Me.code.Name = "code"
        Me.code.TabIndex = 0
        Me.code.Text = ""
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
        'Label1
        '
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.Label1.Location = New System.Drawing.Point(24, 48)
        Me.Label1.Name = "Label1"
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Labor Code:"
        '
        'Label2
        '
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.Label2.Location = New System.Drawing.Point(24, 88)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(128, 23)
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "New Charge Per Hour:"
        '
        'cost
        '
        Me.cost.Location = New System.Drawing.Point(160, 88)
        Me.cost.Name = "cost"
        Me.cost.TabIndex = 3
        Me.cost.Text = ""
        '
        'Submit
        '
        Me.Submit.BackColor = System.Drawing.Color.Silver
        Me.Submit.Location = New System.Drawing.Point(72, 160)
        Me.Submit.Name = "Submit"
        Me.Submit.TabIndex = 4
        Me.Submit.Text = "Submit"
        '
        'Cancel
        '
        Me.Cancel.BackColor = System.Drawing.Color.Silver
        Me.Cancel.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Cancel.Location = New System.Drawing.Point(168, 160)
        Me.Cancel.Name = "Cancel"
        Me.Cancel.TabIndex = 5
        Me.Cancel.Text = "Cancel"
        '
        'GroupBox1
        '
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.AddRange(New System.Windows.Forms.Control() {Me.Submit, Me.Cancel, Me.cost, Me.Label1, Me.code, Me.Label2})
        Me.GroupBox1.Location = New System.Drawing.Point(32, 48)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(288, 208)
        Me.GroupBox1.TabIndex = 6
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Update Labor Costs"
        '
        'Adapter1
        '
        Me.Adapter1.DeleteCommand = Me.OleDbDeleteCommand1
        Me.Adapter1.InsertCommand = Me.OleDbInsertCommand1
        Me.Adapter1.SelectCommand = Me.OleDbSelectCommand1
        Me.Adapter1.TableMappings.AddRange(New System.Data.Common.DataTableMapping() {New System.Data.Common.DataTableMapping("Table", "LABOR-COSTS", New System.Data.Common.DataColumnMapping() {New System.Data.Common.DataColumnMapping("LABOR-CODE", "LABOR-CODE"), New System.Data.Common.DataColumnMapping("LABOR-DESCRIPTION", "LABOR-DESCRIPTION"), New System.Data.Common.DataColumnMapping("LABOR-COST", "LABOR-COST")})})
        Me.Adapter1.UpdateCommand = Me.OleDbUpdateCommand1
        '
        'OleDbDeleteCommand1
        '
        Me.OleDbDeleteCommand1.CommandText = "DELETE FROM [LABOR-COSTS] WHERE ([LABOR-CODE] = ?) AND ([LABOR-COST] = ? OR ? IS " & _
        "NULL AND [LABOR-COST] IS NULL) AND ([LABOR-DESCRIPTION] = ? OR ? IS NULL AND [LA" & _
        "BOR-DESCRIPTION] IS NULL)"
        Me.OleDbDeleteCommand1.Connection = Me.conn1
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-CODE", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "LABOR-CODE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "LABOR-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "LABOR-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-DESCRIPTION", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "LABOR-DESCRIPTION", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbDeleteCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-DESCRIPTION1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "LABOR-DESCRIPTION", System.Data.DataRowVersion.Original, Nothing))
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
        Me.OleDbInsertCommand1.CommandText = "INSERT INTO [LABOR-COSTS] ([LABOR-CODE], [LABOR-COST], [LABOR-DESCRIPTION]) VALUE" & _
        "S (?, ?, ?)"
        Me.OleDbInsertCommand1.Connection = Me.conn1
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("LABOR-CODE", System.Data.OleDb.OleDbType.VarWChar, 50, "LABOR-CODE"))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("LABOR-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "LABOR-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbInsertCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("LABOR-DESCRIPTION", System.Data.OleDb.OleDbType.VarWChar, 50, "LABOR-DESCRIPTION"))
        '
        'OleDbSelectCommand1
        '
        Me.OleDbSelectCommand1.CommandText = "SELECT [LABOR-CODE], [LABOR-COST], [LABOR-DESCRIPTION] FROM [LABOR-COSTS]"
        Me.OleDbSelectCommand1.Connection = Me.conn1
        '
        'OleDbUpdateCommand1
        '
        Me.OleDbUpdateCommand1.CommandText = "UPDATE [LABOR-COSTS] SET [LABOR-CODE] = ?, [LABOR-COST] = ?, [LABOR-DESCRIPTION] " & _
        "= ? WHERE ([LABOR-CODE] = ?) AND ([LABOR-COST] = ? OR ? IS NULL AND [LABOR-COST]" & _
        " IS NULL) AND ([LABOR-DESCRIPTION] = ? OR ? IS NULL AND [LABOR-DESCRIPTION] IS N" & _
        "ULL)"
        Me.OleDbUpdateCommand1.Connection = Me.conn1
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("LABOR-CODE", System.Data.OleDb.OleDbType.VarWChar, 50, "LABOR-CODE"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("LABOR-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "LABOR-COST", System.Data.DataRowVersion.Current, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("LABOR-DESCRIPTION", System.Data.OleDb.OleDbType.VarWChar, 50, "LABOR-DESCRIPTION"))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-CODE", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "LABOR-CODE", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-COST", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "LABOR-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-COST1", System.Data.OleDb.OleDbType.Currency, 0, System.Data.ParameterDirection.Input, False, CType(19, Byte), CType(0, Byte), "LABOR-COST", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-DESCRIPTION", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "LABOR-DESCRIPTION", System.Data.DataRowVersion.Original, Nothing))
        Me.OleDbUpdateCommand1.Parameters.Add(New System.Data.OleDb.OleDbParameter("Original_LABOR-DESCRIPTION1", System.Data.OleDb.OleDbType.VarWChar, 50, System.Data.ParameterDirection.Input, False, CType(0, Byte), CType(0, Byte), "LABOR-DESCRIPTION", System.Data.DataRowVersion.Original, Nothing))
        '
        'cmd1
        '
        Me.cmd1.Connection = Me.conn1
        '
        'Update_Labor_Costs
        '
        Me.AcceptButton = Me.Submit
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackgroundImage = CType(resources.GetObject("$this.BackgroundImage"), System.Drawing.Bitmap)
        Me.CancelButton = Me.Cancel
        Me.ClientSize = New System.Drawing.Size(376, 289)
        Me.ControlBox = False
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.GroupBox1})
        Me.Menu = Me.MainMenu1
        Me.Name = "Update_Labor_Costs"
        Me.Text = "Update Labor Costs"
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

        If code.Text <> "P" And code.Text <> "A" Then
            MsgBox("Error.  Invalid Error Code entered!")
        Else
            Adapter1.UpdateCommand.CommandText = "UPDATE [LABOR-COSTS] SET " & _
                "[LABOR-COST] = " & cost.Text & _
                " WHERE [LABOR-CODE] = '" & code.Text & "'"

            Try
                conn1.Open()
                Adapter1.UpdateCommand.ExecuteNonQuery()
            Catch oleDbExceptionParameter As System.Data.OleDb.OleDbException
                MessageBox.Show("Error. Could not updated Labor Costs")
                indexform.Show()
                Me.Close()
            End Try

            MsgBox("Labor Costs Updated")
            indexform.Show()
            Me.Close()
        End If
    End Sub

End Class
