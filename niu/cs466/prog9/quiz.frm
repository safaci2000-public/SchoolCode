VERSION 5.00
Begin VB.Form index 
   Caption         =   "Quiz-A-Thon 2003"
   ClientHeight    =   5790
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6120
   LinkTopic       =   "Form1"
   ScaleHeight     =   5790
   ScaleWidth      =   6120
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "E&xit"
      Height          =   615
      Left            =   3360
      TabIndex        =   7
      Top             =   4680
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Start Quiz"
      Height          =   615
      Left            =   1200
      TabIndex        =   6
      Top             =   4680
      Width           =   1575
   End
   Begin VB.TextBox ssn 
      Height          =   375
      Left            =   3240
      MaxLength       =   11
      TabIndex        =   5
      Top             =   3720
      Width           =   1815
   End
   Begin VB.TextBox sec 
      Height          =   375
      Left            =   3240
      MaxLength       =   2
      TabIndex        =   4
      Top             =   2880
      Width           =   1815
   End
   Begin VB.TextBox name2 
      Height          =   375
      Left            =   3240
      TabIndex        =   3
      Top             =   2160
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "Welcome to Quiz Deathmatch 2003"
      BeginProperty Font 
         Name            =   "Monotype Corsiva"
         Size            =   26.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   960
      TabIndex        =   8
      Top             =   480
      Width           =   4695
   End
   Begin VB.Label Label3 
      Caption         =   "SSN:"
      Height          =   375
      Left            =   720
      TabIndex        =   2
      Top             =   3720
      Width           =   2055
   End
   Begin VB.Label Label2 
      Caption         =   "Section Number:"
      Height          =   375
      Left            =   720
      TabIndex        =   1
      Top             =   3000
      Width           =   1935
   End
   Begin VB.Label Label1 
      Caption         =   "Name:"
      Height          =   375
      Left            =   840
      TabIndex        =   0
      Top             =   2280
      Width           =   1815
   End
End
Attribute VB_Name = "index"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    If name2.Text = "" Or sec.Text = "" Or ssn.Text = "" Then
            MsgBox ("Please fill in all entries completely before proceeding")
    Else
        Me.Hide
        quiz.Show
    End If
End Sub

Private Sub Command2_Click()
    End
End Sub

