VERSION 5.00
Begin VB.Form frmPolicy 
   BackColor       =   &H00000000&
   Caption         =   "Policy Information"
   ClientHeight    =   3735
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5190
   ControlBox      =   0   'False
   Icon            =   "frmPolicy.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3735
   ScaleWidth      =   5190
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Text5 
      DataField       =   "limit"
      DataSource      =   "datPolicyInfomation"
      Height          =   285
      Left            =   1800
      TabIndex        =   7
      Top             =   1920
      Width           =   1455
   End
   Begin VB.TextBox Text4 
      DataField       =   "deductible"
      DataSource      =   "datPolicyInfomation"
      Height          =   285
      Left            =   1800
      TabIndex        =   6
      Top             =   1560
      Width           =   1455
   End
   Begin VB.TextBox Text3 
      DataField       =   "type"
      DataSource      =   "datPolicyInfomation"
      Height          =   285
      Left            =   1800
      TabIndex        =   5
      Top             =   1200
      Width           =   1455
   End
   Begin VB.TextBox Text2 
      DataField       =   "expire_date"
      DataSource      =   "datPolicyInfomation"
      Height          =   285
      Left            =   1800
      TabIndex        =   4
      Top             =   840
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      DataField       =   "start_date"
      DataSource      =   "datPolicyInfomation"
      Height          =   285
      Left            =   1800
      TabIndex        =   3
      Top             =   480
      Width           =   1455
   End
   Begin VB.TextBox txtPolicyHolder 
      DataField       =   "policy_holder"
      DataSource      =   "datPolicyInfomation"
      Height          =   285
      Left            =   1800
      TabIndex        =   8
      Top             =   2280
      Width           =   1455
   End
   Begin VB.TextBox txtHolderInformationPolicyHolder 
      DataField       =   "POLICY_HOLDER"
      DataSource      =   "datHolderInformation"
      Height          =   285
      Left            =   3240
      TabIndex        =   10
      Top             =   2280
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.TextBox txtPolicyNumber 
      DataField       =   "policy_num"
      DataSource      =   "datPolicyInfomation"
      Height          =   285
      Left            =   1800
      TabIndex        =   2
      Top             =   120
      Width           =   1455
   End
   Begin VB.Data datHolderInformation 
      Appearance      =   0  'Flat
      Caption         =   "Holder Information"
      Connect         =   "Access"
      DatabaseName    =   "C:\School\CSCI466\asn10\claims2.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   315
      Left            =   240
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "HOLDER"
      Top             =   3240
      Width           =   4695
   End
   Begin VB.Data datPolicyInfomation 
      Appearance      =   0  'Flat
      Caption         =   "Policy Information"
      Connect         =   "Access"
      DatabaseName    =   "C:\School\CSCI466\asn10\claims2.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   315
      Left            =   240
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "POLICY"
      Top             =   2880
      Width           =   4695
   End
   Begin VB.CommandButton cmdMainMenu 
      Caption         =   "&Main Menu"
      Height          =   375
      Left            =   3600
      TabIndex        =   1
      Top             =   720
      Width           =   1335
   End
   Begin VB.CommandButton cmdFindPolicy 
      Caption         =   "&Find Policy"
      Height          =   375
      Left            =   3600
      TabIndex        =   0
      Top             =   240
      Width           =   1335
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   1215
      Left            =   3480
      Picture         =   "frmPolicy.frx":0442
      ScaleHeight     =   1185
      ScaleWidth      =   1425
      TabIndex        =   17
      Top             =   1320
      Width           =   1455
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Limit:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   16
      Top             =   1920
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Deductible:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   1560
      Width           =   1215
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Type:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Top             =   1200
      Width           =   1215
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Expire Date:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Start Date:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   12
      Top             =   480
      Width           =   1215
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Policy Holder:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Policy Number:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   9
      Top             =   120
      Width           =   1215
   End
   Begin VB.Shape Shape2 
      BackColor       =   &H00808080&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00E0E0E0&
      Height          =   1095
      Left            =   3480
      Shape           =   4  'Rounded Rectangle
      Top             =   120
      Width           =   1575
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00808080&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00E0E0E0&
      Height          =   855
      Left            =   120
      Shape           =   4  'Rounded Rectangle
      Top             =   2760
      Width           =   4935
   End
End
Attribute VB_Name = "frmPolicy"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdFindPolicy_Click()
On Error Resume Next
    Dim resp As String
    
    resp = InputBox("Enter the policy number", "Search for a policy")
    
    Me.datPolicyInfomation.Recordset.MoveFirst
    Me.datPolicyInfomation.Recordset.FindFirst ("[policy_num] = " & Chr(34) & resp & Chr(34))
    If Me.txtPolicyNumber <> resp Then
        MsgBox "not found"
    End If

End Sub

Private Sub cmdMainMenu_Click()
On Error Resume Next
    Unload Me
    frmMain.Visible = True
End Sub


Private Sub Form_Load()
On Error Resume Next
    Me.datHolderInformation.DatabaseName = App.Path & "\claims2.mdb"
    Me.datPolicyInfomation.DatabaseName = App.Path & "\claims2.mdb"
    Me.datHolderInformation.Refresh
    Me.datPolicyInfomation.Refresh
End Sub

Private Sub txtHolderInformationPolicyHolder_Change()
On Error Resume Next
    Me.txtPolicyHolder = Me.txtHolderInformationPolicyHolder
End Sub

Private Sub txtPolicyHolder_Change()
On Error Resume Next
    Me.txtHolderInformationPolicyHolder = Me.txtPolicyHolder
End Sub
