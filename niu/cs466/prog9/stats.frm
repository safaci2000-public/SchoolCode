VERSION 5.00
Begin VB.Form stats 
   Caption         =   "Student Statistics"
   ClientHeight    =   4080
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7095
   LinkTopic       =   "Form1"
   ScaleHeight     =   4080
   ScaleWidth      =   7095
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1335
      Left            =   3360
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   1320
      Width           =   3135
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   615
      Left            =   2640
      TabIndex        =   0
      Top             =   3120
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "Label2"
      BeginProperty Font 
         Name            =   "Monotype Corsiva"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1320
      TabIndex        =   6
      Top             =   120
      Width           =   4695
   End
   Begin VB.Label sec 
      Caption         =   "Section Number:"
      Height          =   375
      Left            =   240
      TabIndex        =   5
      Top             =   2280
      Width           =   2175
   End
   Begin VB.Label ssn 
      Caption         =   "SSN:"
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   1920
      Width           =   2175
   End
   Begin VB.Label name2 
      Caption         =   "Name:"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   1560
      Width           =   2175
   End
   Begin VB.Label Label1 
      Caption         =   "Student Info:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   960
      Width           =   1455
   End
End
Attribute VB_Name = "stats"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    End ' ends program
End Sub

Private Sub Form_Load()
    Dim percent As Double   ' stores percent earned
    Dim comment As String   ' stores grade earned
    
    Label2.Caption = "Statistics for " + index!name2.Text ' student info
    name2.Caption = "Name:  " + index!name2.Text
    ssn.Caption = "SSN:  " + index!ssn.Text
    sec.Caption = "Section Number:  " + index!sec.Text

    percent = (correct / totalques) * 100   ' calculated %
    
    Select Case percent
        Case Is > 91:
            comment = "that's an A, showoff!"
        Case Is > 83:
            comment = "That's a B, not bad"
        Case Is > 75:
            comment = "that's a C, you're an OMIS major, aren't you?"
        Case Is > 67:
            comment = "that's a D, you're a Business major, aren't you?"
        Case Is <= 67:
            comment = "you're a total failure, that's an F, you're not an Arts major by any chance?"
    End Select
    
    ' print "friendly" comment
    Text1.Text = index!name2.Text + ", you've got " + Str(correct) & _
                " out of " + Str(totalques) + " right!" + vbCrLf & _
                "that's:  " + Str(percent) + "% " + vbCrLf & _
                comment
                
End Sub

