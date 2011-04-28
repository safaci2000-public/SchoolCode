VERSION 5.00
Begin VB.Form quiz 
   Caption         =   "Quiz"
   ClientHeight    =   7005
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9450
   LinkTopic       =   "Form1"
   ScaleHeight     =   7005
   ScaleWidth      =   9450
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Exit 
      Caption         =   "E&xit"
      Height          =   375
      Left            =   4560
      TabIndex        =   14
      Top             =   5280
      Width           =   1335
   End
   Begin VB.Frame Frame1 
      Height          =   4095
      Left            =   840
      TabIndex        =   1
      Top             =   1680
      Width           =   7815
      Begin VB.CommandButton Submit 
         Caption         =   "&Next"
         Height          =   375
         Left            =   1800
         TabIndex        =   13
         Top             =   3600
         Width           =   1335
      End
      Begin VB.TextBox Question 
         Enabled         =   0   'False
         Height          =   615
         Left            =   1800
         TabIndex        =   7
         Text            =   "stuff"
         ToolTipText     =   "the question you have to answer"
         Top             =   600
         Width           =   5055
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Option1"
         Height          =   255
         Index           =   3
         Left            =   1920
         TabIndex        =   6
         Top             =   3000
         Width           =   255
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Option1"
         Height          =   255
         Index           =   2
         Left            =   1920
         TabIndex        =   5
         Top             =   2640
         Width           =   255
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Option1"
         Height          =   255
         Index           =   1
         Left            =   1920
         TabIndex        =   4
         Top             =   2280
         Width           =   255
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Choice 1"
         Height          =   255
         Index           =   0
         Left            =   1920
         TabIndex        =   3
         Top             =   1920
         Width           =   255
      End
      Begin VB.Label Label3 
         Caption         =   "choice4"
         Height          =   375
         Index           =   3
         Left            =   2400
         TabIndex        =   11
         Top             =   3000
         Width           =   1935
      End
      Begin VB.Label Label3 
         Caption         =   "choice3"
         Height          =   375
         Index           =   2
         Left            =   2400
         TabIndex        =   10
         Top             =   2640
         Width           =   1935
      End
      Begin VB.Label Label3 
         Caption         =   "choice2"
         Height          =   375
         Index           =   1
         Left            =   2400
         TabIndex        =   9
         Top             =   2280
         Width           =   1935
      End
      Begin VB.Label Label3 
         Caption         =   "choice1"
         Height          =   375
         Index           =   0
         Left            =   2400
         TabIndex        =   8
         Top             =   1920
         Width           =   1935
      End
      Begin VB.Label Label2 
         Caption         =   "Question:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   360
         TabIndex        =   2
         Top             =   480
         Width           =   1575
      End
   End
   Begin VB.Label studinfo 
      Height          =   375
      Left            =   120
      TabIndex        =   15
      Top             =   6600
      Width           =   2415
   End
   Begin VB.Label Label4 
      Height          =   375
      Left            =   3120
      TabIndex        =   12
      Top             =   6120
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "Quiz"
      BeginProperty Font 
         Name            =   "Monotype Corsiva"
         Size            =   26.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   1440
      TabIndex        =   0
      Top             =   600
      Width           =   6855
   End
End
Attribute VB_Name = "quiz"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public qtrack As Integer           ' tracks which question we are currently looked at.
Public quest As String             ' current question


Private Sub Exit_Click()
    Me.Hide
    stats.Show
End Sub



Private Sub Form_Load()
    
    Dim Loc As Integer          ' for loop counter.
    Dim count As Integer        ' counts number of entries in array
    Dim stuff As String         ' temp string used for various things
    Dim title1 As String * 80   ' reads title of quiz
    
    quesnum = 1                 ' sets the question number

    Open "quiz.txt" For Input As #1
    count = 0
    Input #1, title1
    Input #1, quest
  
    Do While Not (EOF(1))
        Input #1, state(count)
        For Loc = 0 To 3
            Input #1, choice(count, Loc)
        Next
        Input #1, answer(count)
        count = count + 1
    Loop
    
    
    Label1.Caption = title1     ' sets the title of the quiz
    stuff = Str(quesnum) + ".) " + quest + " " + state(0) + "?"
    
    Question.Text = stuff       ' sets the question
    
    For Loc = 0 To 3
           Label3(Loc).Caption = choice(0, Loc)
           Option1(Loc).Value = False
    Next
    
    qtrack = 0      ' sets position in array
    correct = 0     ' sets # of correct questions
    totalques = count   ' sets # of questions read in as # of total questions
    
    stuff = index!name2.Text + "," + index!sec.Text + "," + index!ssn.Text
    studinfo.Caption = stuff
        
End Sub

Private Sub Submit_Click()
    
    Dim Loc As Integer      ' for loop counter
    Dim flag As Integer     ' flag to see if at least one checkbox has been clicked
    flag = 0                ' initializes flag to 0
    
    If qtrack <> 20 Then
    
    If answer(qtrack) = "A" And Option1(0).Value = True Then
           Label4.Caption = "that was correct.  good job!"
           correct = correct + 1
           flag = 0
    ElseIf answer(qtrack) = "B" And Option1(1).Value = True Then
           Label4.Caption = "that was correct.  good job!"
           correct = correct + 1
           flag = 0
    ElseIf answer(qtrack) = "C" And Option1(2).Value = True Then
           Label4.Caption = "that was correct.  good job!"
           correct = correct + 1
           flag = 0
    ElseIf answer(qtrack) = "D" And Option1(3).Value = True Then
           Label4.Caption = "that was correct.  good job!"
           correct = correct + 1
           flag = 0
    ElseIf Option1(0).Value = True Or Option1(1).Value = True _
            Or Option1(2).Value = True Or Option1(3).Value = True Then
           Label4.Caption = "Sorry.  That is the wrong answer"
           flag = 0
    Else
            MsgBox ("Wuss, pick an answer")
            flag = 1
    End If

    If flag <> 1 Then
        qtrack = qtrack + 1
        quesnum = quesnum + 1
    End If
    
     If qtrack <> 20 Then
     For Loc = 0 To 3
          Label3(Loc).Caption = choice(qtrack, Loc)
          Option1(Loc).Value = False
    Next
    
    Question.Text = Str(quesnum) + ".) " + quest + " " + state(qtrack) + "?"
    Else
        Submit.Enabled = False
        MsgBox ("Congrats.  You're done.  Press Exit to see your stats!")
    End If
    Else
        For Loc = 0 To 3
            Label3(Loc).Caption = ""
            Option1(Loc).Enabled = False
        Next
        Question.Text = ""
        Submit.Enabled = False
        MsgBox ("Congrats.  You're done2.  Press Exit to see your stats!")
    End If
    


End Sub
