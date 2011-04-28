VERSION 5.00
Begin VB.Form frmMain 
   BackColor       =   &H00000000&
   Caption         =   "NIU Insurance Claims"
   ClientHeight    =   1845
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4950
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   1845
   ScaleWidth      =   4950
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   795
      Left            =   120
      Picture         =   "frmMain.frx":0442
      ScaleHeight     =   765
      ScaleWidth      =   780
      TabIndex        =   4
      Top             =   120
      Width           =   815
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "E&xit"
      Height          =   375
      Left            =   3360
      TabIndex        =   2
      Top             =   1200
      Width           =   1335
   End
   Begin VB.CommandButton cmdPolicy 
      Caption         =   "&Policy Info"
      Height          =   375
      Left            =   1800
      TabIndex        =   1
      Top             =   1200
      Width           =   1335
   End
   Begin VB.CommandButton cmdClaims 
      Caption         =   "&Claims Info"
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   1200
      Width           =   1335
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00808080&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00E0E0E0&
      Height          =   615
      Left            =   120
      Shape           =   4  'Rounded Rectangle
      Top             =   1080
      Width           =   4695
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "NIU Insurance Claims"
      BeginProperty Font 
         Name            =   "Book Antiqua"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   495
      Left            =   1080
      TabIndex        =   3
      Top             =   240
      Width           =   3615
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdClaims_Click()
On Error Resume Next
    frmClaims.Visible = True
    Me.Visible = False
End Sub

Private Sub cmdExit_Click()
On Error Resume Next
    End
End Sub

Private Sub cmdPolicy_Click()
On Error Resume Next
    frmPolicy.Visible = True
    Me.Visible = False
End Sub

