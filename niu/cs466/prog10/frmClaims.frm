VERSION 5.00
Begin VB.Form frmClaims 
   BackColor       =   &H00000000&
   Caption         =   "Claim Information"
   ClientHeight    =   3720
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5655
   ControlBox      =   0   'False
   Icon            =   "frmClaims.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3720
   ScaleWidth      =   5655
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H80000008&
      Height          =   1455
      Left            =   3960
      Picture         =   "frmClaims.frx":0442
      ScaleHeight     =   1425
      ScaleWidth      =   1545
      TabIndex        =   18
      Top             =   1440
      Width           =   1575
   End
   Begin VB.TextBox txtPolicyNumber 
      DataField       =   "policy_num"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   2
      Top             =   120
      Width           =   1455
   End
   Begin VB.TextBox txtExpiration 
      DataField       =   "expire_date"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   9
      Top             =   2640
      Width           =   1455
   End
   Begin VB.TextBox txtTotalAmount 
      DataField       =   "ClaimTotal"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   7
      Top             =   1920
      Width           =   1455
   End
   Begin VB.TextBox txtTotalNumClaims 
      DataField       =   "PolicyCount"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   6
      Top             =   1560
      Width           =   1455
   End
   Begin VB.TextBox txtLimit 
      DataField       =   "limit"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   5
      Top             =   1200
      Width           =   1455
   End
   Begin VB.TextBox txtPolicyName 
      DataField       =   "FullName"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   4
      Top             =   840
      Width           =   1455
   End
   Begin VB.TextBox txtPolicyHolder 
      DataField       =   "POLICY_HOLDER"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   3
      Top             =   480
      Width           =   1455
   End
   Begin VB.TextBox txtStartDate 
      DataField       =   "start_date"
      DataSource      =   "datClaimInformation"
      Height          =   285
      Left            =   2160
      TabIndex        =   8
      Top             =   2280
      Width           =   1455
   End
   Begin VB.Data datClaimInformation 
      Appearance      =   0  'Flat
      Caption         =   "Claim Information"
      Connect         =   "Access"
      DatabaseName    =   "C:\School\CSCI466\asn10\claims2.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   315
      Left            =   360
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   $"frmClaims.frx":1366
      Top             =   3240
      Width           =   5055
   End
   Begin VB.CommandButton cmdFindPolicy 
      Caption         =   "&Find Claim"
      Height          =   375
      Left            =   4080
      TabIndex        =   0
      Top             =   240
      Width           =   1335
   End
   Begin VB.CommandButton cmdMainMenu 
      Caption         =   "&Main Menu"
      Height          =   375
      Left            =   4080
      TabIndex        =   1
      Top             =   720
      Width           =   1335
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00808080&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00E0E0E0&
      Height          =   495
      Left            =   240
      Shape           =   4  'Rounded Rectangle
      Top             =   3120
      Width           =   5295
   End
   Begin VB.Label Label8 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Policy Number:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   17
      Top             =   120
      Width           =   1575
   End
   Begin VB.Label Label7 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Expiration:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   600
      TabIndex        =   16
      Top             =   2640
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Total Amount:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   360
      TabIndex        =   15
      Top             =   1920
      Width           =   1455
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Total # of Claims:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Top             =   1560
      Width           =   1575
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Limit:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   1200
      Width           =   1575
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Policy Holder Name:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   12
      Top             =   840
      Width           =   1575
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Policy Holder:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   480
      Width           =   1575
   End
   Begin VB.Label Label3 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Start Date:"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   240
      TabIndex        =   10
      Top             =   2280
      Width           =   1575
   End
   Begin VB.Shape Shape2 
      BackColor       =   &H00808080&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00E0E0E0&
      Height          =   1095
      Left            =   3960
      Shape           =   4  'Rounded Rectangle
      Top             =   120
      Width           =   1575
   End
End
Attribute VB_Name = "frmClaims"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdFindPolicy_Click()
On Error Resume Next
    Dim resp As String
    
    resp = InputBox("Enter the policy number", "Search for a policy")
    If resp <> vbNullString Then
        Me.datClaimInformation.Recordset.MoveFirst
        Me.datClaimInformation.Recordset.FindFirst ("[policy_num] = " & Chr(34) & resp & Chr(34))
        If Me.txtPolicyNumber <> resp Then
            MsgBox "not found"
        End If
    End If
    
End Sub

Private Sub cmdMainMenu_Click()
On Error Resume Next
    Unload Me
    frmMain.Visible = True
End Sub

Private Sub Form_Load()
On Error Resume Next
    Me.datClaimInformation.DatabaseName = App.Path & "\claims2.mdb"
    Me.datClaimInformation.Refresh
End Sub

