/***********************************************************************************************
CLASS:	      ErosionUI

FUNCTION:     ErosionUI declares and defines all the components for the user interface on the 
	      applet. It initializes static variables to be used for the initialization of the
	      components and for resetting their values.	      
	      The class contains:
	      -Constructor: 
	       *ErosionUI(Panel panel, ErosionSim e1, SharedParameters sparams, ErosionCanvas e2)=
	        	it creates and initializes all GUI components
	      -Helping functions:
	       *public void start() = to make advanced options invisible when the applet starts
	       *public void itemStateChanged(ItemEvent e) = to listen to changes in radio buttons
	       *public void adjustmentValueChanged(AdjustmentEvent e) = to listen to sliders
	       *public static double getDouble(String numStr) = to convert numbers in labels to 
	       		double
	       *void constraint(Container cont, Component comp, 
		       		int gridx, int gridy,
		       		int gridwidth, int gridheight,
		       		int fill, int anchor,
		       		double weightx, double weighty,
		       		int top, int left, int bottom, int right) =
		       	to be able to handle the component location
		       	
INPUT:	      User will select parameters.

DATE CREATED: 		August 2002
DATE LAST MODIFIED: 	April 2003
***********************************************************************************************/
import java.awt.*;
import java.awt.event.*;
import java.util.*;
import java.applet.*;
import java.text.DecimalFormat;

class ErosionUI implements ItemListener, AdjustmentListener
    {
    //to carry all the simulation logic
    ErosionSim esim;
    //global parameters
    SharedParameters params;
    //canvas for the erosion simulation
    ErosionCanvas ecanv;
    
    //GUI components
    //panels
    static CustomPanel  top, topleft, topright,
			right, rightcard, rightnorth, rightcenter, 
			rightcenter1, rightcenter1up, rightcenter1upeast,
			rightcenter1upchoice, rightcenter1upchoicearrows, rightcenter1uparrows,
			rightcenter1upslider, rightcenter1upwest,
			rightcenter2, rightcenter2up, rightcenter2upeast, rightcenter2upeasttop,
			rightcenter2upchoice, rightcenter2upchoicearrows, rightcenter2uparrows,
			rightcenter2upslider, rightcenter2upwest, 
			rightcenter3, rightcenter3up, rightcenter3upeast,
			rightcenter3upeasttop, rightcenter3upchoice,
			rightcenter3upchoicearrows, rightcenter3uparrows,
			rightcenter3upslider, rightcenter3upwest, 
			rightcenter4, rightcenter4up, rightcenter4upeast, rightcenter4upeasttop,
			rightcenter4upchoice, rightcenter4upchoicearrows, rightcenter4uparrows,
			rightcenter4upslider, rightcenter4upwest,
			left;
			    
    //to show the topographic grid
    static SurfacePanel sPanel;        	
    
    //for card layout manager
    static CardLayout cardManagerUp;   

    //labels
    static Label cardLabelUp1, cardLabelUp2, cardLabelUp3, cardLabelUp4,
		 gridxarrow, gridyarrow, endtimearrow, topographyarrow, initiallabel, 
		 erodibilitybreakxarrow, erodibilitybreakyarrow, erodibilityuniformarrow, 
		 erodibilitybreakxleftarrow, erodibilitybreakxrightarrow,
		 erodibilityadvancedoptions, erodibilityuniformcheckLabel,
		 randomsliderLabel, randomsliderLabel1, erodibilitybpointxLabel,
		 erodibilitybpointyLabel, erodibilityylabelnorth,
		 erodibilityylabelsouth, erodibilitylabelnorth, erodibilitylabelsouth,
		 climateseparatorLabel, climatedefaultarrow,
		 increasingclimatearrow, lowclimatearrow,
		 decreasingclimatearrow, highclimatearrow,
		 climatedefaultLabel, climatenorth, climatesouth, climateadvancedoptions, climatenote,
		 tectonicsbreakxarrow, tectonicsbreakyarrow,
		 tectonicsbreaktoparrow, tectonicsbreakbottomarrow,
		 tectonicsbpointxLabel, tectonicsbpointyLabel,
		 tectonicsadvancedoptions, tectonicsnorth, tectonicssouth,
		 tectonicsbreaknorth, tectonicsbreaksouth,
		 advancedoptions1Label, 
		 xmaxLabel, xmaxsliderLabel,
		 ymaxLabel, ymaxsliderLabel, gridsizeLabel, 
		 endtimeLabel, endtimeyearLabel, endtimesliderLabel,
		 topographyLabel, topographydefaultLabel,
		 interchangeablelabelnorth,
		 interchangeablelabelsouth,
		 rainfallLabel, rainfallLabel1,
		 tectonicslabelCheck1, upliftrateLabel, upliftrateLabel1, 
		 label0, label3, label5, label6, label7, label12, label13, label14, label18, 
		 labela, labelb, labelc;

    decimalLabel topographyslopeLabel,
		 erodibilityuniformvalueLabel, erodibilityxleftvalueLabel, erodibilityxrightvalueLabel,
		 erodibilityytopvalueLabel, erodibilityybottomvalueLabel,
		 climatedefaultvalueLabel, climateincreasingvaluelowLabel, climatedecreasingvaluelowLabel,
		 climateincreasingvaluehighLabel, climatedecreasingvaluehighLabel,
    		 tectonicsxleftvalueLabel, tectonicsxrightvalueLabel, tectonicsytopvalueLabel,
		 tectonicsybottomvalueLabel;
	     	     
    //sliders
    static Scrollbar interchangeableSlider, erodibilitySlider, erodibilityadvancedSlider,
		     climateSlider, tectonicsSlider, tectonicsadvancedSlider;    
    //radio buttons
    static CheckboxGroup setupradioButtons, initadvancedconditions,
    			 erodibilitybreak,  erodibilityadvancedconditions, erodibilityradioButtons, 
    			 climateradioButtons, climatechoiceradioButtons, climateadvancedButtons,
    			 tectonicsradioButtons, tectonicsadvancedconditions, tectonicschoiceradioButtons;
    
    //checkboxes
    static Checkbox initialconditionCheck, initadvancedgridx, initadvancedgridy,
    	            initadvancedcellsize, initadvancedendtime,
    	            initadvancedtopography, initadvancedfake, erodibilityCheck,
    	            erodibilityleft, erodibilitybottom, erodibilityfake,
    		    erodibilityuniformCheck, erodibilitybpointxCheck, erodibilitybpointyCheck,
    		    climateCheck, climatefake, climatedefaultCheck,
		    climatedecreasingCheck, climateincreasingCheck,
		    climateincreasinghigh, climateincreasinglow,
		    climatedecreasinghigh, climatedecreasinglow,
    		    tectonicCheck, tectonicsfake, tectonicsnoCheck,
		    tectonicsyesCheck, tectonicsleft,
    	            tectonicsbottom, tectonicsdefaultCheck,
		    tectonicsbpointxCheck, tectonicsbpointyCheck;
		    
    //static variables used by components
    //grid variables for components
    static int xminimum = 50;
    static int xmaximum = 110;
    static int yminimum = 50;
    static int ymaximum = 210;
    static int xyblock = 5;
    //time variables
    static int timeminimum = 1000;
    static int timemaximum = 10001;
    static int timeblock = 10;
    //erodibility variables
    static double erodibilityuniform = 0.05;
    static int uniformminimum = 10;
    static int uniformmaximum = 60;
    static int uniformstep = 10;
    static int xleftminimum = 10;
    static int xrightminimum = 10;
    static int ybottomminimum = 10;
    static int ytopminimum = 10;
    static int xleftmaximum = 60;
    static int xrightmaximum = 60;
    static int ybottommaximum = 60;
    static int ytopmaximum = 60;
    static int erodibilityblock = 1;
    static int minimumxpoint = 0;
    static int minimumypoint = 0;
    //slope variables
    static int slopeminimum = 1;
    static int slopemaximum = 60;
    static int slopeblock = 1;
    //climate variables
    static int climateminimum = 50;
    static int climatemaximum = 160;
    static double climatedefault = 0.05;
    static int climatelow = 50;
    static int climatehigh = 160;
    static int climateblock = 10;	
    static int climatedefaultblock = 10;	
    //tectonics
    static int tectonicsxleftminimum = 0;
    static int tectonicsxrightminimum = 0;
    static int tectonicsybottomminimum = 0;
    static int tectonicsytopminimum = 0;
    static int tectonicsxleftmaximum = 60;
    static int tectonicsxrightmaximum = 60;
    static int tectonicsybottommaximum = 60;
    static int tectonicsytopmaximum = 60;
    static int tectonicsblock = 10;
    static int tectonicsminimumxpoint = 0;
    static int tectonicsminimumypoint = 0;

    static boolean xgrid = false;
    static boolean ygrid = false;
    static boolean cell = false;
    static boolean timestep = false;
    static boolean endt = false;
    static boolean topo = false;
    static boolean uniformErosion = false;
    static boolean breakx = false;
    static boolean breaky = false;
    static boolean breakxleft = false;
    static boolean breakxright = false;
    static boolean breakytop = false;
    static boolean breakybottom = false;
    static boolean climatedefault1 = false;
    static boolean climateincrease = false;
    static boolean climatedecrease = false;
    static boolean climateincreaselow = false;
    static boolean climateincreasehigh = false;
    static boolean climatedecreaselow = false;
    static boolean climatedecreasehigh = false;
    static boolean tectonicsx = false;
    static boolean tectonicsy = false;
    static boolean tectonicsxleft = false;
    static boolean tectonicsxright = false;
    static boolean tectonicsytop = false;
    static boolean tectonicsybottom = false;
    static boolean averagefirstClick = false;
    static boolean columnfirstClick = false;
    static boolean rowfirstClick = false;
    
    static Color highlights = Color.blue;
     
  
    //constructor
    ErosionUI(Panel thisPanel, ErosionSim e1, SharedParameters sparams, ErosionCanvas e2)
    	{	
	// Get a link to the simulation, shared parameters, and image
	esim = e1;
	params = sparams;
	ecanv = e2;
	
	// Set up shared simulation parameters
	params.COLUMNS = params.OLDCOLUMNS = 60;
	params.ROWS = params.OLDROWS = 100;
	params.BARWIDTH = 100;
	params.ENDTIME = timeminimum * 100;
	params.OLDSLOPE = params.SLOPE = (double) slopeminimum / 100;
	params.YPOINT = -1;
	params.XPOINT = -1;
	params.YRANDTOP = 0.0;
	params.YRANDBOTTOM = 0.0;
	params.XRANDLEFT = 0.0;
	params.XRANDRIGHT = 0.0;
	params.RAINFALLRATEDEFAULT = 0.1;
	params.RAININCREASELOW = 0;
	params.RAINDECREASELOW = 0;
	params.RAININCREASEHIGH = 0;
	params.RAINDECREASEHIGH = 0;
	params.TIMESTEP = 1;
	params.STEPCOUNTER = 0;
	params.CLIMATEDEFAULT = true;

	//user interface layout
	//panel that has all the subpanels and components
	thisPanel.setLayout(new BorderLayout());
	thisPanel.setBackground(new Color(179, 197, 221));

	//creation of panels
	//top panel with titles
	top = new CustomPanel(950, 50, 2, 2, 2, 2, true, 169, 187, 211);
	top.setLayout(new BorderLayout());
	topleft = new CustomPanel(550, 50, 0, 0, 0, 0, "       ", "h", Color.black, true, 169, 187, 211);
	topright = new CustomPanel(400, 50, 0, 0, 0, 0, "Options", "h", Color.black, true, 169, 187, 211);

	//big right panel
	right = new CustomPanel(400, 550, 2, 2, 2, 2, true, 169, 187, 211);
	right.setLayout(new BorderLayout());
	rightcard = new CustomPanel(400, 515, 0, 0, 0, 0, false, 169, 187, 211);
	rightcard.setLayout(new BorderLayout());
	
	//top of right panel with the three options: Initial Conditions, Climate and Tectonics headers.
	rightnorth = new CustomPanel(400, 40, 0, 0, 0, 0, false, 169, 187, 211);
	rightnorth.setLayout(new GridLayout(2,4));
	
	//all the options for the top right panel
	setupradioButtons = new CheckboxGroup();
	initialconditionCheck = new Checkbox("INITIAL", true, setupradioButtons);
	initialconditionCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
	initialconditionCheck.setBackground(new Color(169, 187, 211));
	initialconditionCheck.addItemListener(this);
	initiallabel = new Label("     CONDITIONS");
	initiallabel.setFont(new Font("Times Roman", Font.BOLD, 11));
	initiallabel.setBackground(new Color(169, 187, 211));
	erodibilityCheck = new Checkbox("ERODIBILITY", false, setupradioButtons);
	erodibilityCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
	erodibilityCheck.setBackground(new Color(179, 197, 221));
	erodibilityCheck.addItemListener(this);
	climateCheck = new Checkbox("CLIMATE", false, setupradioButtons);
	climateCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
	climateCheck.setBackground(new Color(189, 207, 231));
	climateCheck.addItemListener(this);
	tectonicCheck = new Checkbox("TECTONICS", false, setupradioButtons);
	tectonicCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
	tectonicCheck.setBackground(new Color(199, 217, 241));
	tectonicCheck.addItemListener(this);
	labela = new Label("");
	labela.setBackground(new Color(179, 197, 221));
	labelb = new Label("");
	labelb.setBackground(new Color(189, 207, 231));
	labelc = new Label("");
	labelc.setBackground(new Color(199, 217, 241));
	rightnorth.add(initialconditionCheck);
	rightnorth.add(erodibilityCheck);
	rightnorth.add(climateCheck);
	rightnorth.add(tectonicCheck);	
	rightnorth.add(initiallabel);
	rightnorth.add(labela);
	rightnorth.add(labelb);
	rightnorth.add(labelc);
	
	//panels that belong to INITIAL CONDITIONS
	//top part
	cardManagerUp = new CardLayout();
	rightcenter = new CustomPanel(400, 200, 0, 0, 0, 0, false, 169, 187, 211);    	 	
	rightcenter.setLayout(cardManagerUp);
	rightcenter1 = new CustomPanel(400, 200, 0, 0, 0, 0, false, 169, 187, 211);    	 	
	rightcenter1.setLayout(new BorderLayout());
	rightcenter1.setBackground(new Color(169, 187, 211));
	rightcenter1upwest = new CustomPanel(270, 200, 0, 0, 8, 0, false, 169, 187, 211);
	rightcenter1upwest.setLayout(new GridBagLayout());
	rightcenter1upeast = new CustomPanel(130, 200, 0, 0, 0, 0, false, 169, 187, 211);
	rightcenter1upeast.setLayout(new BorderLayout());
	rightcenter1upchoicearrows = new CustomPanel(100, 200, 4, 4, 8, 0, false, 169, 187, 211);
	rightcenter1upchoicearrows.setLayout(new BorderLayout());
	rightcenter1upchoice = new CustomPanel(20, 200, 0, 4, 0, 0, false, 169, 187, 211);
	rightcenter1upchoice.setLayout(new GridBagLayout());
	rightcenter1uparrows = new CustomPanel(80, 200, 0, 0, 0, 0, false, 169, 187, 211);
	rightcenter1uparrows.setLayout(new GridBagLayout());
	rightcenter1upslider = new CustomPanel(30, 200, 4, 0, 4, 0, false, 169, 187, 211);
	rightcenter1upslider.setLayout(new BorderLayout());
	rightcenter1up = new CustomPanel(400, 170, 0, 0, 0, 0, false, 169, 187, 211);
	rightcenter1up.setLayout(new BorderLayout());
	cardLabelUp1 = new Label("Initial Conditions");
	
	//panels that belong to ERODIBILITY
	rightcenter4 = new CustomPanel(400, 200, 0, 0, 0, 0, false, 179, 197, 221);    	 	
	rightcenter4.setLayout(new BorderLayout());
	rightcenter4.setBackground(new Color(179, 197, 221));
	cardLabelUp4 = new Label("Erodibility");
	//bottom part
	rightcenter4up = new CustomPanel(400, 170, 0, 0, 0, 0, false, 179, 197, 221);
	rightcenter4up.setLayout(new BorderLayout());
	rightcenter4upwest = new CustomPanel(220, 170, 0, 28, 0, 0, false, 179, 197, 221);
	rightcenter4upwest.setLayout(new GridBagLayout());
	rightcenter4upeast = new CustomPanel(180, 170, 0, 0, 0, 0, false, 179, 197, 221);
	rightcenter4upeast.setLayout(new BorderLayout());
	rightcenter4upeasttop = new CustomPanel(500, 40, 0, 0, 0, 0, false, 179, 197, 221);
	rightcenter4upeasttop.setLayout(new GridBagLayout());
	rightcenter4upchoicearrows = new CustomPanel(150, 170, 0, 4, 0, 0, false, 179, 197, 221);
	rightcenter4upchoicearrows.setLayout(new BorderLayout());
	rightcenter4upchoice = new CustomPanel(110, 130, 0, 4, 0, 0, false, 179, 197, 221);
	rightcenter4upchoice.setLayout(new GridBagLayout());
	rightcenter4uparrows = new CustomPanel(40, 130, 0, 0, 0, 0, false, 179, 197, 221);
	rightcenter4uparrows.setLayout(new GridBagLayout());
	rightcenter4upslider = new CustomPanel(30, 170, 4, 0, 4, 0, false, 179, 197, 221);
	rightcenter4upslider.setLayout(new BorderLayout());

	//panels that belong to CLIMATE
	rightcenter2 = new CustomPanel(400, 200, 0, 0, 0, 0, false, 189, 207, 231);
	rightcenter2.setLayout(new BorderLayout());
	rightcenter2.setBackground(new Color(189, 207, 231));
	cardLabelUp2 = new Label("Climate");
	rightcenter2up = new CustomPanel(400, 170, 0, 0, 0, 0, false, 189, 207, 231);
	rightcenter2up.setLayout(new BorderLayout());
	rightcenter2upwest = new CustomPanel(330, 170, 0, 0, 0, 0, false, 189, 207, 231);
	rightcenter2upwest.setLayout(new GridBagLayout());
	rightcenter2upeast = new CustomPanel(70, 170, 0, 0, 0, 0, false, 189, 207, 231);
	rightcenter2upeast.setLayout(new BorderLayout());
	rightcenter2upeasttop = new CustomPanel(70, 30, 0, 0, 0, 0, false, 189, 207, 231);
	rightcenter2upchoicearrows = new CustomPanel(40, 140, 20, 0, 25, 0, false, 189, 207, 231);
	rightcenter2upchoicearrows.setLayout(new GridBagLayout());
	rightcenter2upslider = new CustomPanel(30, 140, 20, 0, 20, 0, false, 189, 207, 231);
	rightcenter2upslider.setLayout(new BorderLayout());
	
	//panels that belong to TECTONICS
	rightcenter3 = new CustomPanel(400, 200, 0, 0, 0, 0, false, 199, 217, 241);
	rightcenter3.setLayout(new BorderLayout());
	rightcenter3.setBackground(new Color(199, 217, 241));
	cardLabelUp3 = new Label("Tectonics");
	rightcenter3up = new CustomPanel(400, 170, 0, 0, 0, 0, false, 199, 217, 241);
	rightcenter3up.setLayout(new BorderLayout());
	rightcenter3upwest = new CustomPanel(220, 170, 0, 0, 0, 0, false, 199, 217, 241);
	rightcenter3upwest.setLayout(new GridBagLayout());
	rightcenter3upeast = new CustomPanel(180, 170, 0, 0, 0, 0, false, 199, 217, 241);
	rightcenter3upeast.setLayout(new BorderLayout());
	rightcenter3upeasttop = new CustomPanel(180, 45, 0, 0, 0, 0, false, 199, 217, 241);
	rightcenter3upchoicearrows = new CustomPanel(152, 125, 0, 4, 0, 0, false, 199, 217, 241);
	rightcenter3upchoicearrows.setLayout(new BorderLayout());
	rightcenter3upchoice = new CustomPanel(130, 125, 5, 4, 0, 0, false, 199, 217, 241);
	rightcenter3upchoice.setLayout(new GridBagLayout());
	rightcenter3uparrows = new CustomPanel(22, 125, 2, 0, 0, 0, false, 199, 217, 241);
	rightcenter3uparrows.setLayout(new GridBagLayout());
	rightcenter3upslider = new CustomPanel(28, 125, 4, 0, 0, 0, false, 199, 217, 241);
	rightcenter3upslider.setLayout(new BorderLayout());


	//big left panel that contains the animation and the buttons
	left = new CustomPanel(550, 550, 2, 2, 2, 2, true, 169, 187, 211);
	left.setLayout(new BorderLayout());


	//West panel of the upper part of initial conditions
	//GRID SIZE
	//all concerning x		
	gridsizeLabel = new Label("             Grid Size: ");
	gridsizeLabel.setFont(new Font("Times", Font.BOLD, 11));	
	constraint(rightcenter1upwest, gridsizeLabel, 2, 1, 1, 2,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	xmaxLabel = new Label("x max = ");
	xmaxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, xmaxLabel, 4, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	xmaxsliderLabel = new Label("60");
	xmaxsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, xmaxsliderLabel, 5, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	//all concerning y
	ymaxLabel = new Label("y max = ");
	ymaxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, ymaxLabel, 4, 5, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	ymaxsliderLabel = new Label("100");
	ymaxsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, ymaxsliderLabel, 5, 5, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	//END TIME 	
	endtimeLabel = new Label("            End Time: ");
	endtimeLabel.setFont(new Font("Times", Font.BOLD, 11));
	constraint(rightcenter1upwest, endtimeLabel, 2, 11, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	endtimeyearLabel = new Label("# of iterations =");
	endtimeyearLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, endtimeyearLabel, 4, 11, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);			
	endtimesliderLabel = new Label("" + (timeminimum * 100));
	endtimesliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, endtimesliderLabel, 5, 11, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		


	//TOPOGRAPHY		
	topographyLabel = new Label("       Topography: ");
	topographyLabel.setFont(new Font("Times", Font.BOLD, 11));
	constraint(rightcenter1upwest, topographyLabel, 2, 17, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	topographydefaultLabel = new Label("slope = ");
	topographydefaultLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, topographydefaultLabel, 4, 17, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);			     	
	topographyslopeLabel = new decimalLabel();
	topographyslopeLabel.set2decimalText(params.SLOPE);
	topographyslopeLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter1upwest, topographyslopeLabel, 5, 17, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	//East panel of the upper part of initial conditions
	//INITIAL CONDITIONS components
	advancedoptions1Label = new Label("                                                                                               Advanced Options");
	advancedoptions1Label.setFont(new Font("Times Roman", Font.BOLD, 11));
        rightcenter1up.add(advancedoptions1Label, BorderLayout.NORTH);
	initadvancedconditions = new CheckboxGroup();
        initadvancedgridx = new Checkbox("", false, initadvancedconditions);
	initadvancedgridx.setFont(new Font("Times Roman", Font.BOLD, 10));
	initadvancedgridx.addItemListener(this);
	constraint(rightcenter1upchoice, initadvancedgridx, 2, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	gridxarrow = new Label("                           ");
	gridxarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter1uparrows, gridxarrow, 2, 1, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
        initadvancedgridy = new Checkbox("", false, initadvancedconditions);
	initadvancedgridy.setFont(new Font("Times Roman", Font.BOLD, 10));
	initadvancedgridy.addItemListener(this);
    	constraint(rightcenter1upchoice, initadvancedgridy, 2, 2, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	gridyarrow = new Label("                           ");
	gridyarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter1uparrows, gridyarrow, 2, 4, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	
        initadvancedcellsize = new Checkbox("", false, initadvancedconditions);
	initadvancedcellsize.setFont(new Font("Times Roman", Font.BOLD, 10));
	initadvancedcellsize.addItemListener(this);
        initadvancedendtime = new Checkbox("", false, initadvancedconditions);
	initadvancedendtime.setFont(new Font("Times Roman", Font.BOLD, 10));
	initadvancedendtime.addItemListener(this);
    	constraint(rightcenter1upchoice, initadvancedendtime, 2, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	endtimearrow = new Label("                           ");
	endtimearrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter1uparrows, endtimearrow, 2, 8, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
        initadvancedtopography =	 new Checkbox("", false, initadvancedconditions);
	initadvancedtopography.setFont(new Font("Times Roman", Font.BOLD, 10));
	initadvancedtopography.addItemListener(this);
    	constraint(rightcenter1upchoice, initadvancedtopography, 2, 4, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	topographyarrow = new Label("                           ");
	topographyarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter1uparrows, topographyarrow, 2, 10, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	//this is a fake button in order to get the page started without any selection
	initadvancedfake = new Checkbox("", false, initadvancedconditions);
	initadvancedfake.addItemListener(this);
    	constraint(rightcenter1upwest, initadvancedfake, 2, 5, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);
	
	label5 = new Label("");
	rightcenter1upslider.add(label5, BorderLayout.EAST);
 	interchangeablelabelnorth = new Label("      ");
	interchangeablelabelnorth.setFont(new Font("Times Roman", Font.BOLD, 8));
	rightcenter1upslider.add(interchangeablelabelnorth, BorderLayout.NORTH);
	interchangeableSlider = new Scrollbar(Scrollbar.VERTICAL);
	interchangeableSlider.setMinimum(xminimum);
	interchangeableSlider.setMaximum(xmaximum);
	interchangeableSlider.setUnitIncrement(xyblock);
	interchangeableSlider.addAdjustmentListener(this);
	rightcenter1upslider.add(interchangeableSlider, BorderLayout.CENTER);
	interchangeablelabelsouth = new Label("      ");
	interchangeablelabelsouth.setFont(new Font("Times Roman", Font.BOLD, 8));
	rightcenter1upslider.add(interchangeablelabelsouth, BorderLayout.SOUTH);


	//ERODIBILITY		
	//uniform default values
	erodibilityadvancedoptions = new Label("                                                                                               Advanced Options");
	erodibilityadvancedoptions.setFont(new Font("Times Roman", Font.BOLD, 11));
	rightcenter4up.add(erodibilityadvancedoptions, BorderLayout.NORTH);	
	erodibilityradioButtons = new CheckboxGroup();
	erodibilityuniformCheck = new Checkbox("uniform =             ", true, erodibilityradioButtons);
	erodibilityuniformCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	erodibilityuniformCheck.addItemListener(this);
	constraint(rightcenter4upwest, erodibilityuniformCheck, 3, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilityuniformvalueLabel = new decimalLabel();
	erodibilityuniformvalueLabel.set2decimalText(erodibilityuniform);
	erodibilityuniformvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter4upwest, erodibilityuniformvalueLabel, 5, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	randomsliderLabel = new Label("              ");
	randomsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter4upwest, randomsliderLabel, 3, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);	
	randomsliderLabel1 = new Label("             ");
	randomsliderLabel1.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter4upwest, randomsliderLabel1, 4, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);	

	//break at x
	erodibilitybpointxCheck = new Checkbox("break at x =", false, erodibilityradioButtons);
	erodibilitybpointxCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	erodibilitybpointxCheck.addItemListener(this);
	constraint(rightcenter4upwest, erodibilitybpointxCheck, 3, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilitybpointxLabel = new Label("  " + minimumxpoint);
	erodibilitybpointxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter4upwest, erodibilitybpointxLabel, 3, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilitybreakxarrow = new Label("           ");
	erodibilitybreakxarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter4upwest, erodibilitybreakxarrow, 4, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);		
		   
 	label7 = new Label("");
    	constraint(rightcenter4upwest, label7, 4, 8, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
 	erodibilitylabelnorth = new Label("  ");
	erodibilitylabelnorth.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter4upwest, erodibilitylabelnorth, 5, 6, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilitySlider = new Scrollbar(Scrollbar.VERTICAL);
	erodibilitySlider.setMinimum(xminimum);
	erodibilitySlider.setMaximum(xmaximum);
	erodibilitySlider.setUnitIncrement(xyblock);
	erodibilitySlider.addAdjustmentListener(this);
	constraint(rightcenter4upwest, erodibilitySlider, 5, 7, 1, 7,
		   GridBagConstraints.VERTICAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	// break at y
	erodibilitybpointyCheck = new Checkbox("break at y =", false, erodibilityradioButtons);
	erodibilitybpointyCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	erodibilitybpointyCheck.addItemListener(this);
	constraint(rightcenter4upwest, erodibilitybpointyCheck, 3, 13, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilitybpointyLabel = new Label("  " + minimumypoint);
	erodibilitybpointyLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter4upwest, erodibilitybpointyLabel, 3, 13, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);
	erodibilitybreakyarrow = new Label("           ");
	erodibilitybreakyarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter4upwest, erodibilitybreakyarrow, 4, 13, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);		
 	label6 = new Label("");
    	constraint(rightcenter4upwest, label6, 4, 14, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilitylabelsouth = new Label(" ");
	erodibilitylabelsouth.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter4upwest, erodibilitylabelsouth, 5, 14, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	// advanced conditions for erodibility
	erodibilityadvancedconditions = new CheckboxGroup();
        erodibilityleft = new Checkbox("         ", false, erodibilityadvancedconditions);
	erodibilityleft.setFont(new Font("Times Roman", Font.BOLD, 9));
	erodibilityleft.addItemListener(this);
	constraint(rightcenter4upchoice, erodibilityleft, 1, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilityxleftvalueLabel = new decimalLabel();
	erodibilityxleftvalueLabel.set2decimalText(0.01);
	erodibilityxleftvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter4upchoice, erodibilityxleftvalueLabel, 2, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.EAST,
		   1.0, 1.0, 1, 1, 1, 1);

	erodibilityxrightvalueLabel = new decimalLabel();
	erodibilityxrightvalueLabel.set2decimalText(0.01);
	erodibilityxrightvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter4upchoice, erodibilityxrightvalueLabel, 2, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.EAST,
		   1.0, 1.0, 1, 1, 1, 1);

	erodibilityytopvalueLabel = new decimalLabel();
	erodibilityytopvalueLabel.set2decimalText(0.01);
	erodibilityytopvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter4upchoice, erodibilityytopvalueLabel, 2, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.EAST,
		   1.0, 1.0, 1, 1, 1, 1);   
        erodibilityfake = new Checkbox("       ", false, erodibilityadvancedconditions);
	erodibilityfake.addItemListener(this);
	constraint(rightcenter4upwest, erodibilityfake, 4, 10, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
        erodibilitybottom = new Checkbox("          ", false, erodibilityadvancedconditions);
	erodibilitybottom.setFont(new Font("Times Roman", Font.BOLD, 9));
	erodibilitybottom.addItemListener(this);
	constraint(rightcenter4upchoice, erodibilitybottom, 1, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilityybottomvalueLabel = new decimalLabel();
	erodibilityybottomvalueLabel.set2decimalText(0.01);
	erodibilityybottomvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter4upchoice, erodibilityybottomvalueLabel, 2, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.EAST,
		   1.0, 1.0, 1, 1, 1, 1);	

	erodibilityuniformarrow = new Label("                              ");
	erodibilityuniformarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter4upeasttop, erodibilityuniformarrow, 1, 1, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.EAST,
		   1.0, 1.0, 1, 1, 1, 1);		

	erodibilitybreakxleftarrow = new Label("                ");
	erodibilitybreakxleftarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter4uparrows, erodibilitybreakxleftarrow, 1, 4, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	erodibilitybreakxrightarrow = new Label("                ");
	erodibilitybreakxrightarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter4uparrows, erodibilitybreakxrightarrow, 1, 7, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

 	label12 = new Label("");
	rightcenter4upslider.add(label12, BorderLayout.EAST);
 	erodibilityylabelnorth = new Label("0.01  ");
	erodibilityylabelnorth.setFont(new Font("Times Roman", Font.BOLD, 8));
	rightcenter4upslider.add(erodibilityylabelnorth, BorderLayout.NORTH);
	erodibilityadvancedSlider = new Scrollbar(Scrollbar.VERTICAL);
	erodibilityadvancedSlider.setMinimum(uniformminimum);
	erodibilityadvancedSlider.setMaximum(uniformmaximum);
	erodibilityadvancedSlider.setUnitIncrement(uniformstep);
	erodibilityadvancedSlider.addAdjustmentListener(this);
	rightcenter4upslider.add(erodibilityadvancedSlider, BorderLayout.CENTER);
	erodibilityylabelsouth = new Label("0.05  ");
	erodibilityylabelsouth.setFont(new Font("Times Roman", Font.BOLD, 8));
	rightcenter4upslider.add(erodibilityylabelsouth, BorderLayout.SOUTH);

	//CLIMATE
	climateadvancedoptions = new Label("                                                                                               Advanced Options");
	climateadvancedoptions.setFont(new Font("Times Roman", Font.BOLD, 11));
	rightcenter2up.add(climateadvancedoptions, BorderLayout.NORTH);	
	rainfallLabel = new Label("Rainfall");
	rainfallLabel.setFont(new Font("Times", Font.BOLD, 11));
	constraint(rightcenter2upwest, rainfallLabel, 1, 0, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.EAST,
		   1.0, 1.0, 1, 1, 1, 1);		
	rainfallLabel1 = new Label("Rate");
	rainfallLabel1.setFont(new Font("Times", Font.BOLD, 11));
	constraint(rightcenter2upwest, rainfallLabel1, 2, 0, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climatechoiceradioButtons = new CheckboxGroup();
	climatedefaultCheck = new Checkbox("Constant =", true, climatechoiceradioButtons);
	climatedefaultCheck.addItemListener(this);
	climatedefaultCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter2upwest, climatedefaultCheck, 2, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);			     
	climatedefaultvalueLabel = new decimalLabel();
	climatedefaultvalueLabel.set2decimalText(0.1);
	climatedefaultvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter2upwest, climatedefaultvalueLabel, 4, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climateincreasingCheck = new Checkbox("Increasing", false, climatechoiceradioButtons);
	climateincreasingCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	climateincreasingCheck.addItemListener(this);
	constraint(rightcenter2upwest, climateincreasingCheck, 2, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	increasingclimatearrow = new Label("        ");
	increasingclimatearrow.setFont(new Font("Times Roman", Font.BOLD, 12));
 	constraint(rightcenter2upwest, increasingclimatearrow, 3, 3, 1, 1,
	   GridBagConstraints.HORIZONTAL, GridBagConstraints.SOUTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);	
        climateadvancedButtons = new CheckboxGroup();
	climateincreasinglow = new Checkbox("Low  = ", false, climateadvancedButtons);
	climateincreasinglow.setFont(new Font("Times Roman", Font.BOLD, 9));
	climateincreasinglow.addItemListener(this);
	constraint(rightcenter2upwest, climateincreasinglow, 4, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climatefake = new Checkbox("  ", false, climateadvancedButtons);
	climatefake.addItemListener(this);
	constraint(rightcenter2upwest, climatefake, 5, 4, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climateincreasingvaluelowLabel = new decimalLabel();
	climateincreasingvaluelowLabel.set2decimalText(0.05);
	climateincreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter2upwest, climateincreasingvaluelowLabel, 5, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climatedecreasingvaluelowLabel = new decimalLabel();
	climatedecreasingvaluelowLabel.set2decimalText(0.05);
	climatedecreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter2upwest, climatedecreasingvaluelowLabel, 5, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climateseparatorLabel = new Label("|");
	constraint(rightcenter2upwest, climateseparatorLabel, 4, 4, 1, 1,
		   GridBagConstraints.VERTICAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	
	climatedecreasingCheck = new Checkbox("Decreasing", false, climatechoiceradioButtons);
	climatedecreasingCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	climatedecreasingCheck.addItemListener(this);
	constraint(rightcenter2upwest, climatedecreasingCheck, 2, 5, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	decreasingclimatearrow = new Label("        ");
	decreasingclimatearrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter2upwest, decreasingclimatearrow, 3, 5, 1, 1,
	   GridBagConstraints.HORIZONTAL, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);	
	climateincreasinghigh = new Checkbox("High = ", false, climateadvancedButtons);
	climateincreasinghigh.setFont(new Font("Times Roman", Font.BOLD, 9));
	climateincreasinghigh.addItemListener(this);
	constraint(rightcenter2upwest, climateincreasinghigh, 4, 5, 1, 1,
	   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climateincreasingvaluehighLabel = new decimalLabel();
	climateincreasingvaluehighLabel.set2decimalText(0.05);
	climateincreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter2upwest, climateincreasingvaluehighLabel, 5, 5, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	climatedecreasingvaluehighLabel = new decimalLabel();
	climatedecreasingvaluehighLabel.set2decimalText(0.01);
	climatedecreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter2upwest, climatedecreasingvaluehighLabel, 5, 5, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	climatenote = new Label("***HIGH value should be greater than LOW value");
	climatenote.setFont(new Font("Times Roman", Font.ITALIC, 10));
    	constraint(rightcenter2upwest, climatenote, 2, 6, 4, 1,
	   GridBagConstraints.HORIZONTAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);	


	climatedefaultarrow = new Label("___________________________");
	climatedefaultarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter2upchoicearrows, climatedefaultarrow, 1, 1, 1, 1,
	   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);	

	lowclimatearrow = new Label("___________________________");
	lowclimatearrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter2upchoicearrows, lowclimatearrow, 1, 2, 1, 1,
	   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);	

	label0 = new Label("");
    	constraint(rightcenter2upchoicearrows, label0, 1, 3, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);	
	
	highclimatearrow = new Label("___________________________");
	highclimatearrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter2upchoicearrows, highclimatearrow, 1, 4, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);	

	label13 = new Label("");
     	rightcenter2upslider.add(label13, BorderLayout.EAST);
 	climatenorth = new Label("0.05");
	climatenorth.setFont(new Font("Times Roman", Font.BOLD, 9));
	rightcenter2upslider.add(climatenorth, BorderLayout.NORTH);
	climateSlider = new Scrollbar(Scrollbar.VERTICAL);
	climateSlider.setMinimum(climateminimum);
	climateSlider.setMaximum(climatemaximum);
	climateSlider.setUnitIncrement(climatedefaultblock);
	climateSlider.addAdjustmentListener(this);
	rightcenter2upslider.add(climateSlider, BorderLayout.CENTER);
	climatesouth = new Label("0.15");
	climatesouth.setFont(new Font("Times Roman", Font.BOLD, 9));
	rightcenter2upslider.add(climatesouth, BorderLayout.SOUTH);


	//TECTONICS
	tectonicsadvancedoptions = new Label("                                                                                               Advanced Options");
	tectonicsadvancedoptions.setFont(new Font("Times Roman", Font.BOLD, 11));
	rightcenter3up.add(tectonicsadvancedoptions, BorderLayout.NORTH);	
	upliftrateLabel = new Label("Uplift");
	upliftrateLabel.setFont(new Font("Times", Font.BOLD, 11));
	constraint(rightcenter3upwest, upliftrateLabel, 2, 0, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.EAST,
		   1.0, 1.0, 1, 1, 1, 1);		
	upliftrateLabel1 = new Label("Rate:");
	upliftrateLabel1.setFont(new Font("Times", Font.BOLD, 11));
	constraint(rightcenter3upwest, upliftrateLabel1, 3, 0, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	tectonicschoiceradioButtons = new CheckboxGroup();
	tectonicsdefaultCheck = new Checkbox("Fixed at 0", true, tectonicschoiceradioButtons);
	tectonicsdefaultCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	tectonicsdefaultCheck.addItemListener(this);
	constraint(rightcenter3upwest, tectonicsdefaultCheck, 3, 5, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
        tectonicslabelCheck1 = new Label("(no uplift)");		   
	constraint(rightcenter3upwest, tectonicslabelCheck1, 4, 5, 3, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	tectonicsnorth = new Label("   ");
	tectonicsnorth.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter3upwest, tectonicsnorth, 6, 6, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		      1.0, 1.0, 1, 1, 1, 1);		
	tectonicsbpointxCheck = new Checkbox("break at x =", false, tectonicschoiceradioButtons);
	tectonicsbpointxCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	tectonicsbpointxCheck.addItemListener(this);
	constraint(rightcenter3upwest, tectonicsbpointxCheck, 3, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	tectonicsbpointxLabel = new Label("" + minimumxpoint);
	tectonicsbpointxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter3upwest, tectonicsbpointxLabel, 4, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	tectonicsSlider = new Scrollbar(Scrollbar.VERTICAL);
	tectonicsSlider.setMinimum(minimumxpoint);
	tectonicsSlider.setMaximum(params.COLUMNS + 10);
	tectonicsSlider.setUnitIncrement(1);
	tectonicsSlider.addAdjustmentListener(this);
	constraint(rightcenter3upwest, tectonicsSlider, 6, 7, 1, 6,
		   GridBagConstraints.VERTICAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	label3 = new Label(" ");
    	constraint(rightcenter3upwest, label3, 5, 9, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);		

	tectonicsbreakxarrow = new Label("      ");
	tectonicsbreakxarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter3upwest, tectonicsbreakxarrow, 5, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);		
	tectonicsbpointyCheck = new Checkbox("break at y =", false, tectonicschoiceradioButtons);
	tectonicsbpointyCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
	tectonicsbpointyCheck.addItemListener(this);
	constraint(rightcenter3upwest, tectonicsbpointyCheck, 3, 12, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	tectonicsbpointyLabel = new Label("" + minimumypoint);
	tectonicsbpointyLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
	constraint(rightcenter3upwest, tectonicsbpointyLabel, 4, 12, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.SOUTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	tectonicsbreakyarrow = new Label("      ");
	tectonicsbreakyarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter3upwest, tectonicsbreakyarrow, 5, 12, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHEAST,
		   1.0, 1.0, 1, 1, 1, 1);		

	tectonicssouth = new Label("   ");
	tectonicssouth.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter3upwest, tectonicssouth, 6, 13, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.NORTHWEST,
		   1.0, 1.0, 1, 1, 1, 1);		


	tectonicsadvancedconditions = new CheckboxGroup();
        tectonicsleft = new Checkbox("          ", false, tectonicsadvancedconditions);
	tectonicsleft.setFont(new Font("Times Roman", Font.BOLD, 9));
	tectonicsleft.addItemListener(this);
	constraint(rightcenter3upchoice, tectonicsleft, 1, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	tectonicsxleftvalueLabel = new decimalLabel();
	tectonicsxleftvalueLabel.set4decimalText(0);
	tectonicsxleftvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter3upchoice, tectonicsxleftvalueLabel, 3, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);


	tectonicsytopvalueLabel = new decimalLabel();
	tectonicsytopvalueLabel.set4decimalText(0);
	tectonicsytopvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter3upchoice, tectonicsytopvalueLabel, 3, 1, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);
	tectonicsbreaktoparrow = new Label("      ");
	tectonicsbreaktoparrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter3uparrows, tectonicsbreaktoparrow, 1, 1, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

        tectonicsfake = new Checkbox("          ", false, tectonicsadvancedconditions);
	tectonicsfake.addItemListener(this);
	constraint(rightcenter3upwest, tectonicsfake, 5, 11, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

        tectonicsbottom = new Checkbox("          ", false, tectonicsadvancedconditions);
	tectonicsbottom.setFont(new Font("Times Roman", Font.BOLD, 9));
	tectonicsbottom.addItemListener(this);
	constraint(rightcenter3upchoice, tectonicsbottom, 1, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	label18 = new Label("");
    	constraint(rightcenter3upchoice, label18, 2, 7, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		
	tectonicsxrightvalueLabel = new decimalLabel();
	tectonicsxrightvalueLabel.set4decimalText(0);
	tectonicsxrightvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter3upchoice, tectonicsxrightvalueLabel, 3, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);

	label14 = new Label("");
    	constraint(rightcenter3upchoice, label14, 4, 7, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

	tectonicsybottomvalueLabel = new decimalLabel();
	tectonicsybottomvalueLabel.set4decimalText(0);
	tectonicsybottomvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 9));
	constraint(rightcenter3upchoice, tectonicsybottomvalueLabel, 3, 7, 1, 1,
		   GridBagConstraints.NONE, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);

	tectonicsbreakbottomarrow = new Label("      ");
	tectonicsbreakbottomarrow.setFont(new Font("Times Roman", Font.BOLD, 12));
    	constraint(rightcenter3uparrows, tectonicsbreakbottomarrow, 1, 7, 1, 1,
		   GridBagConstraints.HORIZONTAL, GridBagConstraints.WEST,
		   1.0, 1.0, 1, 1, 1, 1);		

 	label12 = new Label("");
	rightcenter3upslider.add(label12, BorderLayout.EAST);
 	tectonicsbreaknorth = new Label("0.0000      ");
	tectonicsbreaknorth.setFont(new Font("Times Roman", Font.BOLD, 8));
	rightcenter3upslider.add(tectonicsbreaknorth, BorderLayout.NORTH);
	tectonicsadvancedSlider = new Scrollbar(Scrollbar.VERTICAL);
	tectonicsadvancedSlider.setMinimum(tectonicsxleftminimum);
	tectonicsadvancedSlider.setMaximum(tectonicsxleftmaximum);
	tectonicsadvancedSlider.setUnitIncrement(tectonicsblock);
	tectonicsadvancedSlider.addAdjustmentListener(this);
	rightcenter3upslider.add(tectonicsadvancedSlider, BorderLayout.CENTER);
	tectonicsbreaksouth = new Label("0.0005      ");
	tectonicsbreaksouth.setFont(new Font("Times Roman", Font.BOLD, 8));
	rightcenter3upslider.add(tectonicsbreaksouth, BorderLayout.SOUTH);


	//add panels
	top.add(topright, BorderLayout.EAST);
	top.add(topleft, BorderLayout.WEST);
	sPanel = new SurfacePanel(sparams, ecanv, esim);
	left.add(sPanel, BorderLayout.CENTER);
 	rightcenter1up.add(rightcenter1upwest, BorderLayout.WEST);
	rightcenter1upchoicearrows.add(rightcenter1upchoice, BorderLayout.WEST);
	rightcenter1upchoicearrows.add(rightcenter1uparrows, BorderLayout.EAST);
	rightcenter1upeast.add(rightcenter1upchoicearrows, BorderLayout.WEST);
	rightcenter1upeast.add(rightcenter1upslider, BorderLayout.EAST);
 	rightcenter1up.add(rightcenter1upeast, BorderLayout.EAST);
 	rightcenter1.add(rightcenter1up, BorderLayout.CENTER);
	rightcenter2upeast.add(rightcenter2upchoicearrows, BorderLayout.WEST);
	rightcenter2upeast.add(rightcenter2upslider, BorderLayout.EAST);
	rightcenter2up.add(rightcenter2upeast, BorderLayout.EAST);
	rightcenter2up.add(rightcenter2upwest, BorderLayout.WEST);
	rightcenter2.add(rightcenter2up, BorderLayout.CENTER);
	rightcenter3upchoicearrows.add(rightcenter3uparrows, BorderLayout.EAST);
	rightcenter3upchoicearrows.add(rightcenter3upchoice, BorderLayout.WEST);
	rightcenter3upeast.add(rightcenter3upeasttop, BorderLayout.NORTH);
	rightcenter3upeast.add(rightcenter3upslider, BorderLayout.EAST);
	rightcenter3upeast.add(rightcenter3upchoicearrows, BorderLayout.WEST);
	rightcenter3up.add(rightcenter3upeast, BorderLayout.EAST);
	rightcenter3up.add(rightcenter3upwest, BorderLayout.WEST);
	rightcenter3.add(rightcenter3up, BorderLayout.CENTER);
	rightcenter4upchoicearrows.add(rightcenter4upeasttop, BorderLayout.NORTH);
	rightcenter4upchoicearrows.add(rightcenter4upchoice, BorderLayout.WEST);
	rightcenter4upchoicearrows.add(rightcenter4uparrows, BorderLayout.EAST);
	rightcenter4upeast.add(rightcenter4upchoicearrows, BorderLayout.WEST);
	rightcenter4upeast.add(rightcenter4upslider, BorderLayout.EAST);
	rightcenter4up.add(rightcenter4upeast, BorderLayout.EAST);
	rightcenter4up.add(rightcenter4upwest, BorderLayout.WEST);
	rightcenter4.add(rightcenter4up, BorderLayout.CENTER);
	rightcenter.add(rightcenter1, cardLabelUp1.getText());
	rightcenter.add(rightcenter4, cardLabelUp4.getText());
	rightcenter.add(rightcenter2, cardLabelUp2.getText());
	rightcenter.add(rightcenter3, cardLabelUp3.getText());
	rightcard.add(rightcenter, BorderLayout.NORTH);
	right.add(rightnorth, BorderLayout.NORTH);
	right.add(rightcard, BorderLayout.CENTER);
	thisPanel.add(top, BorderLayout.NORTH);
	thisPanel.add(left, BorderLayout.WEST);
	thisPanel.add(right, BorderLayout.EAST);
	
    	}//end constructor
    
    public void start()
    	{
	// This is unfortunate.  When widgets are made invisible before 
	// UI actually appears, subsequent visibility updates are flaky.		    
	sPanel.repaint();
	initadvancedfake.setVisible(false);
	setComponentColor(1);
	setArrow(1);
	setLabelValue(12);
	setLabelValue(13);
	setLabelValue(14);
	erodibilityfake.setVisible(false);
	climatefake.setVisible(false);
	tectonicsfake.setVisible(false);
	}//end start

    public void stop()
    	{
    	sPanel.repaint();	
    	}

    //to listen to radio buttons
    public void itemStateChanged(ItemEvent e)
    	{
	if(e.getSource() == initialconditionCheck)
		{
		cardManagerUp.show(rightcenter, "Initial Conditions");
		params.PREVIOUSTAB = false;
		params.NEXTTAB = true;
		initadvancedfake.setState(true);
		setArrow(1);
		setComponentColor(1);
		}
	if(e.getSource() == erodibilityCheck)
		{
		cardManagerUp.show(rightcenter, "Erodibility");
		erodibilityfake.setState(true);
		erodibilityadvancedSlider.setMinimum(uniformminimum);
		erodibilityadvancedSlider.setMaximum(uniformmaximum);
		erodibilityadvancedSlider.setUnitIncrement(uniformstep);
		erodibilitySlider.setValue(0);
		setArrow(1);
		setComponentColor(1);
		setComponentColor(13);
		}
	if(e.getSource() == climateCheck)
		{
		cardManagerUp.show(rightcenter, "Climate");
		climatenote.setText("***HIGH value should be greater than LOW value");
		climatefake.setState(true);
		setComponentColor(1);
		}
	if(e.getSource() == tectonicCheck)
		{
		cardManagerUp.show(rightcenter, "Tectonics");
		params.PREVIOUSTAB = true;
		params.NEXTTAB = false;
		tectonicsfake.setState(true);
		tectonicsSlider.setValue(minimumxpoint);
		tectonicsadvancedSlider.setValue(tectonicsxleftminimum);
		setArrow(1);
		setComponentColor(1);
		setLabelValue(9);
		}
	//to disable parameter input while process is running
	if(params.ROUTINESTARTED == false)
		{
		if(e.getSource() == initadvancedgridx)
			{
			xgrid = true;
			ygrid = false;
    			endt = false;
    			topo = false;
			setComponentColor(1);
			setComponentColor(2);
			setArrow(1);
			setArrow(2);
 			interchangeablelabelnorth.setText("50");
 			interchangeablelabelsouth.setText("100");
 			interchangeableSlider.setValue(0);
			interchangeableSlider.setMinimum(xminimum);
			interchangeableSlider.setMaximum(xmaximum);
			interchangeableSlider.setUnitIncrement(xyblock);
 			interchangeableSlider.setValue(xminimum);
			}
		if(e.getSource() == initadvancedgridy)
			{
			ygrid = true;
			xgrid = false;
    			endt = false;
    			topo = false;
			setComponentColor(1);
			setComponentColor(3);
			setArrow(1);
			setArrow(3);
 			interchangeablelabelnorth.setText("50");
 			interchangeablelabelsouth.setText("200");
 			interchangeableSlider.setValue(0);
			interchangeableSlider.setMinimum(yminimum);
			interchangeableSlider.setMaximum(ymaximum);
			interchangeableSlider.setUnitIncrement(xyblock);
 			interchangeableSlider.setValue(yminimum);
			}
		if(e.getSource() == initadvancedendtime)
			{
			ygrid = false;
			xgrid = false;
    			endt = true;
    			topo = false;
			setComponentColor(1);
			setComponentColor(4);
			setArrow(1);
			setArrow(4);
 			interchangeableSlider.setValue(0);
 			interchangeablelabelnorth.setText("100000");
 			interchangeablelabelsouth.setText("1000000");
			interchangeableSlider.setMinimum(timeminimum);
			interchangeableSlider.setMaximum(timemaximum);
			interchangeableSlider.setUnitIncrement(timeblock);
 			interchangeableSlider.setValue(timeminimum);
			}
		if(e.getSource() == initadvancedtopography)
			{
			ygrid = false;
			xgrid = false;
    			endt = false;
    			topo = true;
			setComponentColor(1);
			setComponentColor(5);
			setArrow(1);
			setArrow(5);
 			interchangeablelabelnorth.setText("0.01");
 			interchangeablelabelsouth.setText("0.50");
 			interchangeableSlider.setValue(0);
			interchangeableSlider.setMinimum(slopeminimum);
			interchangeableSlider.setMaximum(slopemaximum);
			interchangeableSlider.setUnitIncrement(slopeblock);
 			interchangeableSlider.setValue(slopeminimum);
			}
		//uniform default value for erodibility
		if(e.getSource() == erodibilityuniformCheck)
       	 		{
			breakx = false;
			breaky = false;
			uniformErosion = true;
        		params.EROSIONNEEDED = true;
			//set default values for other options
			params.RANDEROSION = false;
			params.XPOINT = -1;
			params.YPOINT = -1;
        		params.XRANDLEFT = 0;
        		params.XRANDRIGHT = 0;
        		params.YRANDTOP = 0;
        		params.YRANDBOTTOM = 0;
			setComponentColor(1);
			setComponentColor(6);
			setArrow(1);
			setArrow(19);
			erodibilityadvancedSlider.setMinimum(uniformminimum);
			erodibilityadvancedSlider.setMaximum(uniformmaximum);
			erodibilityadvancedSlider.setUnitIncrement(uniformstep);
			setLabelValue(2);
			erodibilityfake.setState(true);
			erodibilityylabelnorth.setText("0.01");
			erodibilityylabelsouth.setText("0.05");
			}//end of uniform default value for erodibility
		//breaking point at x for erodibility
		if(e.getSource() == erodibilitybpointxCheck)
	 		{
			uniformErosion = false;
       			params.EROSIONNEEDED = true;
       			params.XRANDLEFT = 0.01;
       			params.XRANDRIGHT = 0.01;
			params.XPOINT = 0;
			//set default values for other options
			params.YPOINT = -1;
       			params.YRANDTOP = 0;
       			params.YRANDBOTTOM = 0;
			setComponentColor(1);
			setComponentColor(8);
			setLabelValue(3);
			setArrow(1);
			setArrow(6);
			erodibilitylabelnorth.setText("  0");
			erodibilitylabelsouth.setText(""+params.COLUMNS);
			erodibilitySlider.setMinimum(0);
			erodibilitySlider.setMaximum(params.COLUMNS + 10);
			erodibilitySlider.setValue(0);
			breakx = true;
			breaky = false;
			params.RANDEROSION = false;
			erodibilityadvancedSlider.setMinimum(xleftminimum);
			erodibilityadvancedSlider.setMaximum(xrightmaximum);
			erodibilityadvancedSlider.setUnitIncrement(uniformstep);
	        	erodibilityuniformvalueLabel.set2decimalText(erodibilityuniform);
			}
		//breaking point at y for erodibility
		if(e.getSource() == erodibilitybpointyCheck)
	 		{
			uniformErosion = false;
      			params.EROSIONNEEDED = true;
       			params.YRANDTOP = 0.01;
       			params.YRANDBOTTOM = 0.01;
			params.YPOINT = 0;
			//set default for other options
			params.XPOINT = -1;
			setComponentColor(1);
			setComponentColor(9);
			setArrow(1);
			setArrow(7);
			setLabelValue(4);
			erodibilitylabelnorth.setText("  0");
			erodibilitylabelsouth.setText(""+params.ROWS);
			erodibilitySlider.setMinimum(0);
			erodibilitySlider.setMaximum(params.ROWS + 10);
			erodibilitySlider.setValue(0);
       			params.XRANDLEFT = 0;
       			params.XRANDRIGHT = 0;
			breakx = false;
			breaky = true;
			params.RANDEROSION = false;
			erodibilityadvancedSlider.setMinimum(xleftminimum);
			erodibilityadvancedSlider.setMaximum(xrightmaximum);
			erodibilityadvancedSlider.setUnitIncrement(uniformstep);
	        	erodibilityuniformvalueLabel.set2decimalText(erodibilityuniform);
			}		
		if((e.getSource() == erodibilityleft) && breakx)
			{
			setArrow(8);
			erodibilityadvancedSlider.setValue(xleftminimum);
			breakxleft = true;
			breakxright = false;
			breakytop = false;
			breakybottom = false;
			}				
		if((e.getSource() == erodibilitybottom) && breakx)
			{
			setArrow(9);
			erodibilityadvancedSlider.setValue(xleftminimum);
			breakxleft = false;
			breakxright = true;
			breakytop = false;
			breakybottom = false;
			}
		if((e.getSource() == erodibilityleft) && breaky)
			{
			setArrow(8);
			erodibilityadvancedSlider.setValue(xleftminimum);
			breakxleft = false;
			breakxright = false;
			breakytop = true;
			breakybottom = false;
			}
		if((e.getSource() == erodibilitybottom) && breaky)
			{
			setArrow(9);
			erodibilityadvancedSlider.setValue(xleftminimum);
			breakxleft = false;
			breakxright = false;
			breakytop = false;
			breakybottom = true;
			}
		//default climate
		if(e.getSource() == climatedefaultCheck)
	 		{
			climatedefault1 = true;
			climateincrease = false;
			climatedecrease = false;
			climateincreaselow = false;
			climateincreasehigh = false;
			climatedecreaselow = false;
			climatedecreasehigh = false;
			params.CLIMATEDEFAULT = true;
			params.INCREASEON = false;
			params.DECREASEON = false;
       			params.RAININCREASELOW = 0.0;
       			params.RAININCREASEHIGH = 0.0;
       			params.RAINDECREASELOW = 0.0;
       			params.RAINDECREASEHIGH = 0.0;
			params.RAINFALLRATEDEFAULT = 0.1;
			climatedefaultvalueLabel.set2decimalText(0.10);
			climateSlider.setMinimum(climateminimum);
			climateSlider.setMaximum(climatemaximum);
			climateSlider.setValue(climateminimum);
			climateSlider.setUnitIncrement(climatedefaultblock);
			setArrow(1);
			setArrow(10);
			setLabelValue(13);
			setComponentColor(1);
			setComponentColor(10);
			}
		//climate increasing choice
		if(e.getSource() == climateincreasingCheck)
	 		{
			climatedefault1 = false;
			climateincrease = true;
			climatedecrease = false;
			climateincreaselow = false;
			climateincreasehigh = false;
			climatedecreaselow = false;
			climatedecreasehigh = false;
			params.CLIMATEDEFAULT = false;
			params.DECREASEON = false;
			params.INCREASEON = true;
       			params.RAININCREASEHIGH = 0.10;
       			params.RAININCREASELOW = 0.05;
       			params.RAINDECREASEHIGH = 0.0;
       			params.RAINDECREASELOW = 0.0;
			params.RAINFALLRATEDEFAULT = 0.0;
			climateSlider.setMinimum(climatelow);
			climateSlider.setMaximum(climatehigh);
			climateSlider.setValue(climatelow);
			climateSlider.setBlockIncrement(climateblock);
			setComponentColor(1);
			setComponentColor(11);
			setLabelValue(5);
			setArrow(1);
			setArrow(11);
			}
		//climate decreasing choice
		if(e.getSource() == climatedecreasingCheck)
	 		{
			climatedefault1 = false;
			climateincrease = false;
			climatedecrease = true;
			climateincreaselow = false;
			climateincreasehigh = false;
			climatedecreaselow = false;
			climatedecreasehigh = false;
			params.CLIMATEDEFAULT = false;
			params.INCREASEON = false;
			params.DECREASEON = true;
        		params.RAINDECREASEHIGH = 0.10;
       			params.RAINDECREASELOW = 0.05;
       			params.RAININCREASEHIGH = 0.0;
       			params.RAININCREASELOW = 0.0;
			params.RAINFALLRATEDEFAULT = 0.0;
			climatedefaultvalueLabel.set1decimalText(0.1);
			climateSlider.setMinimum(climatelow);
			climateSlider.setMaximum(climatehigh);
			climateSlider.setValue(climatelow);
			climateSlider.setBlockIncrement(climateblock);
			setComponentColor(1);
			setComponentColor(12);
			setLabelValue(6);
			setArrow(1);
			setArrow(12);
       			}
		if((e.getSource() == climateincreasinglow) && climatedecrease)
	 		{
			climateincreaselow = false;
			climateincreasehigh = false;
			climatedecreaselow = true;
			climatedecreasehigh = false;
			setArrow(13);
	 		}
		if((e.getSource() == climateincreasinghigh) && climatedecrease)
	 		{
			climateincreaselow = false;
			climateincreasehigh = false;
			climatedecreaselow = false;
			climatedecreasehigh = true;
			setArrow(14);
	 		}
		if((e.getSource() == climateincreasinglow) && climateincrease)
	 		{
			climateincreaselow = true;
			climateincreasehigh = false;
			climatedecreaselow = false;
			climatedecreasehigh = false;
			setArrow(13);
	 		}
		if((e.getSource() == climateincreasinghigh) && climateincrease)
	 		{
			climateincreaselow = false;
			climateincreasehigh = true;
			climatedecreaselow = false;
			climatedecreasehigh = false;
			setArrow(14);
	 		}
       			
		//default rate fixed for tectonics
		if(e.getSource() == tectonicsdefaultCheck)
			{
     			params.APPLYTECTONICS = false;
       			params.TECTONICSXPOINT = -1;
       			params.TECTONICSYPOINT = -1;					
       			tectonicsnorth.setText("   ");
       			tectonicssouth.setText("   ");
			tectonicsbpointxLabel.setText("" + minimumxpoint);
			tectonicsbpointyLabel.setText("" + minimumypoint);
			tectonicsSlider.setValue(minimumxpoint);
			tectonicsadvancedSlider.setValue(tectonicsxleftminimum);
			tectonicsfake.setState(true);
			tectonicsx = false;
			tectonicsy = false;
			setComponentColor(1);
			setComponentColor(14);
			setLabelValue(12);
			setLabelValue(10);
			setLabelValue(14);
			setArrow(1);
			}
		//breaking point at x for tectonics
		if(e.getSource() == tectonicsbpointxCheck)
	 		{
			tectonicsx = true;
			tectonicsy = false;
			setComponentColor(1);
			setComponentColor(15);
			setLabelValue(7);
			setLabelValue(14);
			setArrow(1);
			setArrow(15);
       			params.TECTONICSXPOINT = 0;
       			params.TECTONICSYPOINT = -1;					
     			params.APPLYTECTONICS = true;
			tectonicsnorth.setText("  0");
			tectonicssouth.setText("" + params.COLUMNS);
			tectonicsSlider.setMaximum(params.COLUMNS + 10);
			tectonicsbpointyLabel.setText("" + minimumypoint);
			tectonicsSlider.setValue(minimumxpoint);
			tectonicsadvancedSlider.setValue(tectonicsxleftminimum);
			tectonicsbottom.setEnabled(true);
			tectonicsleft.setEnabled(true);
			tectonicsxleftvalueLabel.setForeground(highlights);
			tectonicsxrightvalueLabel.setForeground(highlights);
			tectonicsytopvalueLabel.setForeground(highlights);
			tectonicsybottomvalueLabel.setForeground(highlights);
			}
		//breaking point at y for tectonics
		if(e.getSource() == tectonicsbpointyCheck)
	 		{
			tectonicsx = false;
			tectonicsy = true;
			setComponentColor(1);
			setComponentColor(16);
			setLabelValue(8);
			setArrow(1);
			setArrow(16);
       			params.TECTONICSXPOINT = -1;
       			params.TECTONICSYPOINT = 0;					
     			params.APPLYTECTONICS = true;
			tectonicsbpointxLabel.setText("" + minimumxpoint);
			tectonicsnorth.setText("  0");
			tectonicssouth.setText("" + params.ROWS);
			tectonicsSlider.setMaximum(params.ROWS + 10);
			tectonicsSlider.setValue(minimumxpoint);
			tectonicsadvancedSlider.setValue(tectonicsxleftminimum);			
			tectonicsbottom.setEnabled(true);
			tectonicsleft.setEnabled(true);
			tectonicsxleftvalueLabel.setForeground(highlights);
			tectonicsxrightvalueLabel.setForeground(highlights);
			tectonicsytopvalueLabel.setForeground(highlights);
			tectonicsybottomvalueLabel.setForeground(highlights);
			}		
		if((e.getSource() == tectonicsleft) && tectonicsx)
	 		{
			setArrow(17);
			tectonicsxleft = true;
			tectonicsxright = false;
			tectonicsytop = false;
			tectonicsybottom = false;
			tectonicsadvancedSlider.setValue(tectonicsxleftminimum);
			tectonicsleft.setForeground(highlights);
			tectonicsxleftvalueLabel.setForeground(highlights);
			tectonicsbottom.setForeground(Color.gray);
			tectonicsxrightvalueLabel.setForeground(Color.gray);
			tectonicsxrightvalueLabel.set4decimalText(0.0000);				
	 		}
		if((e.getSource() == tectonicsbottom) && tectonicsx)
	 		{
			setArrow(18);
			tectonicsxleft = false;
			tectonicsxright = true;
			tectonicsytop = false;
			tectonicsybottom = false;
			tectonicsadvancedSlider.setValue(tectonicsxleftminimum);
			tectonicsleft.setForeground(Color.gray);
			tectonicsxleftvalueLabel.setForeground(Color.gray);
			tectonicsxleftvalueLabel.set4decimalText(0.0000);				
			tectonicsbottom.setForeground(highlights);
			tectonicsxrightvalueLabel.setForeground(highlights);
	 		}
		if((e.getSource() == tectonicsleft) && tectonicsy)
	 		{
			setArrow(17);
			tectonicsxleft = false;
			tectonicsxright = false;
			tectonicsytop = true;
			tectonicsybottom = false;
			tectonicsadvancedSlider.setValue(tectonicsxleftminimum);
			tectonicsleft.setForeground(highlights);
			tectonicsytopvalueLabel.setForeground(highlights);
			tectonicsbottom.setForeground(Color.gray);
			tectonicsybottomvalueLabel.setForeground(Color.gray);
			tectonicsybottomvalueLabel.set4decimalText(0.0000);				
	 		}
		if((e.getSource() == tectonicsbottom) && tectonicsy)
	 		{
			setArrow(18);
			tectonicsxleft = false;
			tectonicsxright = false;
			tectonicsytop = false;
			tectonicsybottom = true;
			tectonicsadvancedSlider.setValue(tectonicsxleftminimum);
			tectonicsleft.setForeground(Color.gray);
			tectonicsytopvalueLabel.setForeground(Color.gray);
			tectonicsytopvalueLabel.set4decimalText(0.0000);				
			tectonicsbottom.setForeground(highlights);
			tectonicsybottomvalueLabel.setForeground(highlights);
       			}
	   	}//end of routinestarted check		
	}//end of itemStateChanged

    //to respond to the sliders
    public void adjustmentValueChanged(AdjustmentEvent e) 
    	{
	//to prevent from changes when process started
    	if(params.ROUTINESTARTED == false)
    	    	{	
		//GRID SIZE		
        	if((e.getSource() == interchangeableSlider) && xgrid)
        		{
        		if (e.getValue() > 100)
        			{
        			xmaxsliderLabel.setText("100");	
        			params.COLUMNS = 100;
        			}
        		else
        			{
        			xmaxsliderLabel.setText(String.valueOf(e.getValue()));
	        		params.COLUMNS = Integer.parseInt(String.valueOf(e.getValue()));
        			}
        		}
        	if((e.getSource() == interchangeableSlider) && ygrid)
        		{
        		if (e.getValue() > 200)
        			{
        			ymaxsliderLabel.setText("200");	
        			params.ROWS = 200;
        			}
        		else
        			{
        			ymaxsliderLabel.setText(String.valueOf(e.getValue()));
	        		params.ROWS = Integer.parseInt(String.valueOf(e.getValue()));
        			}
        		}
        	if((e.getSource() == interchangeableSlider) && endt)
        		{       	
        		try
        			{
        			params.ENDTIME = Integer.parseInt(String.valueOf(e.getValue())) * 100;
        			}
        		catch (NumberFormatException nfe) {}
        		endtimesliderLabel.setText("" + params.ENDTIME);        		
    			}
		else if((e.getSource() == interchangeableSlider) && topo)
        		{       	
        		try
        			{
        			int slope = Integer.parseInt(String.valueOf(e.getValue()));
        			params.SLOPE = (double) slope / 100; 
        			if(params.SLOPE > 1.5)
        				{
        				topographyslopeLabel.setText("1.50");	
        				}
        			else
        				{
        				topographyslopeLabel.set2decimalText(params.SLOPE);
        				}
        			}
        		catch (NumberFormatException nfe) {}        		
    			}
		//ERODIBILITY
		else if((e.getSource() == erodibilitySlider) && breakx)
			{
        		try
        			{
        			int xpoint = Integer.parseInt(String.valueOf(e.getValue()));
        			params.XPOINT = xpoint;
        			erodibilitybpointyLabel.setText("  0");
        			erodibilitybpointxLabel.setText("  " + xpoint + " ");
        			params.YRANDTOP = 0.0;
        			params.YRANDBOTTOM = 0.0;
        			params.EROSIONNEEDED = true;
        			}
        		catch (NumberFormatException nfe) {}        		
			}
		else if((e.getSource() == erodibilitySlider) && breaky)
			{
        		try
        			{
        			int ypoint = Integer.parseInt(String.valueOf(e.getValue()));
        			params.YPOINT = ypoint;
        			erodibilitybpointxLabel.setText("  0");
	      			erodibilitybpointyLabel.setText("  " + ypoint + " ");
        			params.XRANDLEFT = 0.0;
        			params.XRANDRIGHT = 0.0;
        			params.EROSIONNEEDED = true;
        			}
        		catch (NumberFormatException nfe) {}        		
			}
    		else if((e.getSource() == erodibilityadvancedSlider) && uniformErosion)
        		{       	
			int uniform = Integer.parseInt(String.valueOf(e.getValue()));
		        double uniformvalue = (double) uniform / 1000;	
		        params.EROSION = uniformvalue;
		        erodibilityuniformvalueLabel.set2decimalText(uniformvalue);
       			params.EROSIONNEEDED = true;
    			}		
    		else if((e.getSource() == erodibilityadvancedSlider) && breakxleft)
        		{       	
			if(params.XPOINT > -1)
				{
				int xleft = Integer.parseInt(String.valueOf(e.getValue()));
				double leftvalue = (double) xleft / 1000;	
				erodibilityxleftvalueLabel.set2decimalText(leftvalue);			
       				params.XRANDLEFT = leftvalue;
        			params.EROSIONNEEDED = true;
       				}
    			}		
    		else if((e.getSource() == erodibilityadvancedSlider) && breakxright)
        		{       	
			if(params.XPOINT > -1)
				{
				int xright = Integer.parseInt(String.valueOf(e.getValue()));					
				double rightvalue = (double) xright / 1000;
				erodibilityxrightvalueLabel.set2decimalText(rightvalue);
       				params.XRANDRIGHT = rightvalue;
        			params.EROSIONNEEDED = true;
       				}
    			}		
    		else if((e.getSource() == erodibilityadvancedSlider) && breakytop)
			{
			if(params.YPOINT > -1)
				{
       				int ytop = Integer.parseInt(String.valueOf(e.getValue()));
       				double topvalue = (double) ytop / 1000;
				erodibilityytopvalueLabel.set2decimalText(topvalue);				
       				params.YRANDTOP = topvalue;
        			params.EROSIONNEEDED = true;
       				}
			}
    		else if((e.getSource() == erodibilityadvancedSlider) && breakybottom)
			{
			if(params.YPOINT > -1)
				{
	       			int ybottom = Integer.parseInt(String.valueOf(e.getValue()));
       				double bottomvalue = (double) ybottom / 1000;
				erodibilityybottomvalueLabel.set2decimalText(bottomvalue);				
       				params.YRANDBOTTOM = bottomvalue;
        			params.EROSIONNEEDED = true;
       				}
			}
		//CLIMATE
    		else if((e.getSource() == climateSlider) && climatedefault1)
    			{
    			try
    				{
        			int defaultrain = Integer.parseInt(String.valueOf(e.getValue()));
        			double defaultrainfall = (double) defaultrain * 0.001;
        			climatedefaultvalueLabel.set2decimalText(defaultrainfall);
        			params.RAINFALLRATEDEFAULT = getDouble(climatedefaultvalueLabel.getText());
        			}
        		catch (NumberFormatException nfe) {}
			}			
    		else if((e.getSource() == climateSlider) && climateincrease && climateincreaselow)
    			{
    			try
    				{
        			int increaselow = Integer.parseInt(String.valueOf(e.getValue()));
        			double inclow = (double) increaselow * 0.001;
        			double inclowcheck = (double) increaselow * 0.001;
        			params.RAININCREASELOW = inclowcheck;
        			params.RAINFALLRATEDEFAULT = 0;
        			if (inclow > 0.14)
       					{
       					inclowcheck = 0.14;	
       					}
        			climateincreasingvaluelowLabel.set2decimalText(inclowcheck);
				if (params.RAININCREASEHIGH < params.RAININCREASELOW)
					{
        				climateincreasingvaluehighLabel.set2decimalText(inclowcheck + 0.01);
        				params.RAININCREASEHIGH = inclowcheck + 0.01;
        				}
        			}
        		catch (NumberFormatException nfe) {}
			}			
    		else if((e.getSource() == climateSlider) && climateincrease && climateincreasehigh)
    			{
    			try
    				{
        			int increasehigh = Integer.parseInt(String.valueOf(e.getValue()));
        			double inchigh = (double) increasehigh * 0.001;
        			double inchighcheck = (double) increasehigh * 0.001;
        			params.RAININCREASEHIGH = inchighcheck;
        			params.RAINFALLRATEDEFAULT = 0;
        			if (inchigh < 0.02)
       					{
       					inchighcheck = 0.02;	
       					}
        			climateincreasingvaluehighLabel.set2decimalText(inchighcheck);
				if (params.RAININCREASEHIGH < params.RAININCREASELOW)
					{
	        			climateincreasingvaluelowLabel.set2decimalText(inchighcheck - 0.01);
        				params.RAININCREASELOW = inchighcheck - 0.01;
        				}
        			}
        		catch (NumberFormatException nfe) {}
			}			

    		else if((e.getSource() == climateSlider) && climatedecrease && climatedecreaselow)
    			{
    			try
    				{
        			int decreaselow = Integer.parseInt(String.valueOf(e.getValue()));
        			double declow = (double) decreaselow * 0.001;
        			double declowcheck = (double) decreaselow * 0.001;
        			if (declow > 0.14)
       					{
       					declowcheck = 0.14;	
       					}
        			params.RAINDECREASELOW = declowcheck;
        			params.RAINFALLRATEDEFAULT = 0;
        			climatedecreasingvaluelowLabel.set2decimalText(declowcheck);
				if (params.RAINDECREASEHIGH < params.RAINDECREASELOW)
					{
	        			climatedecreasingvaluehighLabel.set2decimalText(declowcheck + 0.01);
        				params.RAINDECREASEHIGH = declowcheck + 0.01;
        				}
        			}
        		catch (NumberFormatException nfe) {}
			}
    		else if((e.getSource() == climateSlider) && climatedecrease && climatedecreasehigh)
    			{
    			try
    				{
        			int decreasehigh = Integer.parseInt(String.valueOf(e.getValue()));
        			double dechigh = (double) decreasehigh * 0.001;
        			double dechighcheck = (double) decreasehigh * 0.001;
        			params.RAINDECREASEHIGH = dechighcheck;
        			params.RAINFALLRATEDEFAULT = 0;
        			if (dechigh < 0.02)
       					{
       					dechighcheck = 0.02;	
       					}
        			climatedecreasingvaluehighLabel.set2decimalText(dechighcheck);
				if (params.RAINDECREASEHIGH < params.RAINDECREASELOW)
					{
	        			climatedecreasingvaluelowLabel.set2decimalText(dechighcheck - 0.01);
        				params.RAINDECREASELOW = dechighcheck- 0.01;
        				}
        			}
        		catch (NumberFormatException nfe) {}
			}
		//TECTONICS
    		else if((e.getSource() == tectonicsSlider) && tectonicsx)
        		{       	
        		try
        			{
       				int tectonicsxpoint = Integer.parseInt(String.valueOf(e.getValue()));
       				params.TECTONICSXPOINT = tectonicsxpoint;
       				tectonicsbpointyLabel.setText("" + tectonicsminimumypoint + " ");
       				tectonicsbpointxLabel.setText("" + tectonicsxpoint + " ");
       				params.TECTONICSYTOP = 0.0;
       				params.TECTONICSYBOTTOM = 0.0;
				params.APPLYTECTONICS = true;
        			}
        		catch (NumberFormatException nfe) {}        		
    			}
    		else if((e.getSource() == tectonicsSlider) && tectonicsy)
        		{       	
        		try
        			{
        			int tectonicsypoint = Integer.parseInt(String.valueOf(e.getValue()));
        			params.TECTONICSYPOINT = tectonicsypoint;
        			tectonicsbpointxLabel.setText("" + tectonicsminimumxpoint);
        			tectonicsbpointyLabel.setText("" + tectonicsypoint + " ");
        			params.TECTONICSXLEFT = 0.0;
        			params.TECTONICSXRIGHT = 0.0;
				params.APPLYTECTONICS = true;
        			}
        		catch (NumberFormatException nfe) {}        		
    			}		
		else if((e.getSource() == tectonicsadvancedSlider) && tectonicsx && tectonicsxleft)
			{
			if(params.TECTONICSXPOINT > -1)
			 	{
				double tectonicsleftvalue = 0;
				int tectonicsxleft = Integer.parseInt(String.valueOf(e.getValue()));
				tectonicsleftvalue = (double) (tectonicsxleft * 0.00001);	
				tectonicsxleftvalueLabel.set4decimalText(tectonicsleftvalue);			
      				params.TECTONICSXLEFT = tectonicsleftvalue;
        			params.TECTONICSXRIGHT = 0.0;
       				params.TECTONICSYTOP = 0.0;
       				params.TECTONICSYBOTTOM = 0.0;
      				}
			}			 		
		else if((e.getSource() == tectonicsadvancedSlider) && tectonicsx && tectonicsxright)
			{
			if(params.TECTONICSXPOINT > -1)
			 	{
				double tectonicsrightvalue = 0;
				int tectonicsxright = Integer.parseInt(String.valueOf(e.getValue()));					
				tectonicsrightvalue = (double) (tectonicsxright * 0.00001);
				tectonicsxrightvalueLabel.set4decimalText(tectonicsrightvalue);
       				params.TECTONICSXRIGHT = tectonicsrightvalue;
        			params.TECTONICSXLEFT = 0.0;
       				params.TECTONICSYTOP = 0.0;
       				params.TECTONICSYBOTTOM = 0.0;
       				}
			}
		else if((e.getSource() == tectonicsadvancedSlider) && tectonicsy && tectonicsytop)
			{
			if(params.TECTONICSYPOINT > -1)
			 	{
       				double tectonicstopvalue = 0;
       				int tectonicsytop = Integer.parseInt(String.valueOf(e.getValue()));
       				tectonicstopvalue = (double) (tectonicsytop * 0.00001);
				tectonicsytopvalueLabel.set4decimalText(tectonicstopvalue);				
       				params.TECTONICSYTOP = tectonicstopvalue;
        			params.TECTONICSXLEFT = 0.0;
        			params.TECTONICSXRIGHT = 0.0;
       				params.TECTONICSYBOTTOM = 0.0;
       				}
			}
		else if((e.getSource() == tectonicsadvancedSlider) && tectonicsy && tectonicsybottom)
			{
			if(params.TECTONICSYPOINT > -1)
			 	{
	       			double tectonicsbottomvalue = 0;
	       			int tectonicsybottom = Integer.parseInt(String.valueOf(e.getValue()));
       				tectonicsbottomvalue = (double) (tectonicsybottom * 0.00001);
				tectonicsybottomvalueLabel.set4decimalText(tectonicsbottomvalue);				
       				params.TECTONICSYBOTTOM = tectonicsbottomvalue;
        			params.TECTONICSXLEFT = 0.0;
        			params.TECTONICSXRIGHT = 0.0;
       				params.TECTONICSYTOP = 0.0;
       				}
			}
		}//end of routine started check
    	}//end of adjustmentValueChanged
    
  //to set arrows according to option selected
  public void setArrow(int arrowOption)
  	{
  	switch (arrowOption)
  		{
  		case 1: 
  			{
		  	gridxarrow.setText("                           ");
			gridyarrow.setText("                           ");
			endtimearrow.setText("                           ");
			topographyarrow.setText("                           ");
			erodibilityuniformarrow.setText("                              ");
			erodibilitybreakxarrow.setText("           ");
			erodibilitybreakyarrow.setText("           ");
			erodibilitybreakxleftarrow.setText("                ");
			erodibilitybreakxrightarrow.setText("                ");
			lowclimatearrow.setText("                           ");
			highclimatearrow.setText("                           ");
			climatedefaultarrow.setText("                           ");
			increasingclimatearrow.setText("        ");
			decreasingclimatearrow.setText("        ");
			climateseparatorLabel.setForeground(Color.black);
			tectonicsbreakxarrow.setText("      ");
			tectonicsbreakyarrow.setText("      ");
			tectonicsbreaktoparrow.setText("      ");
			tectonicsbreakbottomarrow.setText("      ");
			break;
  			}
  		case 2:
  			{
		 	gridxarrow.setForeground(highlights);
			gridxarrow.setText("___________________________");
			break;
			}
  		case 3:
  			{
		 	gridyarrow.setForeground(highlights);
			gridyarrow.setText("___________________________");
			break;
			}
  		case 4:
  			{
		 	endtimearrow.setForeground(highlights);
			endtimearrow.setText("___________________________");
			break;
			}
  		case 5:
  			{
			topographyarrow.setForeground(highlights);
			topographyarrow.setText("___________________________");
			break;
			}
  		case 6:
  			{
			erodibilitybreakxarrow.setForeground(highlights);
			erodibilitybreakxarrow.setText("___________");
			erodibilitybreakyarrow.setText("           ");
			erodibilitybreakxleftarrow.setText("                ");
			erodibilitybreakxrightarrow.setText("                ");
			break;
			}
  		case 7:
  			{
			erodibilitybreakyarrow.setForeground(highlights);
			erodibilitybreakxarrow.setText("           ");
			erodibilitybreakyarrow.setText("___________");
			erodibilitybreakxleftarrow.setText("                ");
			erodibilitybreakxrightarrow.setText("                ");
			break;
			}
  		case 8:
  			{
			
			erodibilitybreakxleftarrow.setForeground(highlights);
			erodibilitybreakxleftarrow.setText("________________");
			erodibilitybreakxrightarrow.setText("                ");
			break;
			}
  		case 9:
  			{
			erodibilitybreakxrightarrow.setForeground(highlights);
			erodibilitybreakxleftarrow.setText("                ");
			erodibilitybreakxrightarrow.setText("________________");
			break;
			}
  		case 10:
  			{
			climatedefaultarrow.setForeground(highlights);
			climatedefaultarrow.setText("___________________________");
			climateseparatorLabel.setForeground(Color.black);
			break;
			}
  		case 11:
  			{
			climateseparatorLabel.setForeground(highlights);
			climateseparatorLabel.setVisible(true);
			increasingclimatearrow.setForeground(highlights);
			increasingclimatearrow.setText("________");
			break;
			}
  		case 12:
  			{
			climateseparatorLabel.setForeground(highlights);
			climateseparatorLabel.setVisible(true);
			decreasingclimatearrow.setForeground(highlights);
			decreasingclimatearrow.setText("________");
			break;
			}
  		case 13:
  			{
			lowclimatearrow.setForeground(highlights);
			lowclimatearrow.setText("___________________________");
			highclimatearrow.setText("                           ");
			break;
			}
  		case 14:
  			{
			highclimatearrow.setForeground(highlights);
			highclimatearrow.setText("___________________________");
			lowclimatearrow.setText("                           ");
			break;
			}
  		case 15:
  			{
			tectonicsbreakxarrow.setForeground(highlights);
			tectonicsbreakxarrow.setText("______");
			break;
			}
  		case 16:
  			{
			tectonicsbreakyarrow.setForeground(highlights);
			tectonicsbreakyarrow.setText("______");
			break;
			}
  		case 17:
  			{
			tectonicsbreaktoparrow.setForeground(highlights);
			tectonicsbreaktoparrow.setText("______");
			tectonicsbreakbottomarrow.setText("      ");
			break;
			}
  		case 18:
  			{
			tectonicsbreakbottomarrow.setForeground(highlights);
			tectonicsbreakbottomarrow.setText("______");
			tectonicsbreaktoparrow.setText("      ");
			break;
			}
  		case 19:
  			{
			erodibilityuniformarrow.setText("______________________________");
			erodibilityuniformarrow.setForeground(highlights);
			break;
			}
  		default:
  			{
  			break;
  			}	
  		}	
  	}

  //to set values in labels according to selection
  public void setLabelValue(int valueOption)
  	{
  	switch (valueOption)
  		{
  		case 14: 
  			{
			erodibilityxleftvalueLabel.setText("    ");
			erodibilityxrightvalueLabel.setText("    ");
			erodibilityytopvalueLabel.setText("    ");
			erodibilityybottomvalueLabel.setText("    ");
			erodibilityytopvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilityybottomvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));	
			erodibilityxleftvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilityxrightvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));	
  			break;
  			}
  		case 2: 
  			{
			erodibilityleft.setLabel("           ");
			erodibilitybottom.setLabel("           ");
			erodibilityxleftvalueLabel.setText("    ");
			erodibilityxrightvalueLabel.setText("    ");
			erodibilityytopvalueLabel.setText("    ");
			erodibilityybottomvalueLabel.setText("    ");
			erodibilitybpointxLabel.setText("  " + minimumxpoint);
			erodibilitybpointyLabel.setText("  " + minimumypoint);
  			break;
  			}
		case 3:
			{
			erodibilitybpointyLabel.setText("  " + minimumypoint);
			erodibilityxleftvalueLabel.setVisible(true);
			erodibilityxrightvalueLabel.setVisible(true);
			erodibilityytopvalueLabel.setVisible(false);
			erodibilityybottomvalueLabel.setVisible(false);
			erodibilityxleftvalueLabel.setForeground(highlights);
			erodibilityxleftvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilityxleftvalueLabel.set2decimalText(0.01);
			erodibilityxrightvalueLabel.setForeground(highlights);
			erodibilityxrightvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));	
			erodibilityxrightvalueLabel.set2decimalText(0.01);
			break;
			}
		case 4:
			{
			erodibilitybpointxLabel.setText("  " + minimumxpoint);
			erodibilityxleftvalueLabel.setVisible(false);
			erodibilityxrightvalueLabel.setVisible(false);
			erodibilityytopvalueLabel.setVisible(true);
			erodibilityybottomvalueLabel.setVisible(true);
			erodibilityytopvalueLabel.setForeground(highlights);
			erodibilityytopvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilityytopvalueLabel.set2decimalText(0.01);
			erodibilityybottomvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));	
			erodibilityybottomvalueLabel.setForeground(highlights);
			erodibilityybottomvalueLabel.set2decimalText(0.01);
			break;
			}
		case 5:
			{
			climateincreasingvaluelowLabel.setForeground(highlights);
			climateincreasingvaluehighLabel.setForeground(highlights);
			climateincreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasingvaluelowLabel.setVisible(true);
			climateincreasingvaluehighLabel.setVisible(true);
			climatedefaultvalueLabel.set1decimalText(0.1);
			climateincreasingvaluelowLabel.set2decimalText(0.05);
			climateincreasingvaluehighLabel.set2decimalText(0.06);
			climatedecreasingvaluelowLabel.setVisible(false);
			climatedecreasingvaluehighLabel.setVisible(false);
			break;
			}
		case 6:
			{
			climatedecreasingvaluelowLabel.setForeground(highlights);
			climatedecreasingvaluehighLabel.setForeground(highlights);
			climatedecreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedecreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedecreasingvaluelowLabel.setVisible(true);
			climatedecreasingvaluehighLabel.setVisible(true);
			climatedefaultvalueLabel.set1decimalText(0.1);
			climatedecreasingvaluelowLabel.set2decimalText(0.05);
			climatedecreasingvaluehighLabel.set2decimalText(0.06);
			climateincreasingvaluelowLabel.setVisible(false);
			climateincreasingvaluehighLabel.setVisible(false);
			break;
			}
		case 7:
			{
			tectonicsxleftvalueLabel.setVisible(true);
			tectonicsytopvalueLabel.setVisible(false);
			tectonicsxleftvalueLabel.setForeground(highlights);
			tectonicsxrightvalueLabel.setForeground(highlights);
			tectonicsxleftvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsxrightvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsxrightvalueLabel.setVisible(true);
			tectonicsybottomvalueLabel.setVisible(false);
			tectonicsxleftvalueLabel.set4decimalText(0);
			tectonicsxrightvalueLabel.set4decimalText(0);
			break;
			}
		case 8:
			{
			tectonicsxleftvalueLabel.setVisible(false);
			tectonicsytopvalueLabel.setVisible(true);
			tectonicsytopvalueLabel.setForeground(highlights);
			tectonicsybottomvalueLabel.setForeground(highlights);
			tectonicsytopvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsybottomvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsxrightvalueLabel.setVisible(false);
			tectonicsybottomvalueLabel.setVisible(true);;
			tectonicsytopvalueLabel.set4decimalText(0);
			tectonicsybottomvalueLabel.set4decimalText(0);
			break;
			}
		case 9:
			{
			tectonicsxleftvalueLabel.setForeground(Color.black);
			tectonicsxrightvalueLabel.setForeground(Color.black);
			tectonicsytopvalueLabel.setForeground(Color.black);
			tectonicsybottomvalueLabel.setForeground(Color.black);
			break;
			}
		case 10:
			{
			tectonicsleft.setLabel("        ");
			tectonicsbottom.setLabel("        ");
			break;
			}
		case 11:
			{
			erodibilityxleftvalueLabel.setForeground(Color.black);
			erodibilityxrightvalueLabel.setForeground(Color.black);
			erodibilityytopvalueLabel.setForeground(Color.black);
			erodibilityybottomvalueLabel.setForeground(Color.black);
			break;
			}
		case 12:
			{
			tectonicsxleftvalueLabel.setText("          ");
			tectonicsxrightvalueLabel.setText("          ");
			tectonicsytopvalueLabel.setText("          ");
			tectonicsybottomvalueLabel.setText("          ");
			tectonicsxleftvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsxrightvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsytopvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsybottomvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			}
		case 13:
			{
			climateincreasingvaluelowLabel.setText("     ");
			climateincreasingvaluehighLabel.setText("     ");
			climatedecreasingvaluelowLabel.setText("     ");
			climatedecreasingvaluehighLabel.setText("     ");
			climateincreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedecreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedecreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			}
  		default:
  			{
  			break;
  			}
  		}	
  	}	
  //to highlight components and arrows when selected
  public void setComponentColor(int colorOption)
  	{
	switch (colorOption)
		{
		case 1:
			{
			xmaxLabel.setForeground(Color.black);
			xmaxsliderLabel.setForeground(Color.black);
			xmaxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			xmaxsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			ymaxLabel.setForeground(Color.black);
			ymaxsliderLabel.setForeground(Color.black);
			ymaxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			ymaxsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			endtimeyearLabel.setForeground(Color.black);
			endtimesliderLabel.setForeground(Color.black);
			endtimeyearLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			endtimesliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			topographydefaultLabel.setForeground(Color.black);
			topographyslopeLabel.setForeground(Color.black);
			topographydefaultLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			topographyslopeLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilityuniformCheck.setForeground(Color.black);
			erodibilityuniformvalueLabel.setForeground(Color.black);
			erodibilityuniformCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilityuniformvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			randomsliderLabel.setForeground(Color.black);
			randomsliderLabel1.setForeground(Color.black);
			randomsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			randomsliderLabel1.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilitybpointxCheck.setForeground(Color.black);
			erodibilitybpointxLabel.setForeground(Color.black);
			erodibilitybpointxCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilitybpointxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilitybpointyCheck.setForeground(Color.black);
			erodibilitybpointyLabel.setForeground(Color.black);
			erodibilitybpointyCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilitybpointyLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilityleft.setForeground(Color.black);
			erodibilitybottom.setForeground(Color.black);
			erodibilityleft.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilitybottom.setFont(new Font("Times Roman", Font.BOLD, 10));
			erodibilitylabelnorth.setForeground(Color.black);
			erodibilitylabelsouth.setForeground(Color.black);
			climatedefaultCheck.setForeground(Color.black);
			climatedefaultCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedefaultvalueLabel.setForeground(Color.black);
			climatedefaultvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasingCheck.setForeground(Color.black);
			climateincreasingCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedecreasingCheck.setForeground(Color.black);
			climatedecreasingCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasinglow.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasinglow.setForeground(Color.black);
			climateincreasinghigh.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasinghigh.setForeground(Color.black);
			climateincreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedecreasingvaluelowLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climatedecreasingvaluehighLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			climateincreasingvaluelowLabel.setForeground(Color.black);
			climateincreasingvaluehighLabel.setForeground(Color.black);
			climatedecreasingvaluelowLabel.setForeground(Color.black);
			climatedecreasingvaluehighLabel.setForeground(Color.black);
			tectonicsdefaultCheck.setForeground(Color.black);
			tectonicsdefaultCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
        		tectonicslabelCheck1.setForeground(Color.black);
			tectonicslabelCheck1.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsbpointxCheck.setForeground(Color.black);
			tectonicsbpointxCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsbpointyCheck.setForeground(Color.black);
			tectonicsbpointyCheck.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsbpointxLabel.setForeground(Color.black);
			tectonicsbpointxLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsbpointyLabel.setForeground(Color.black);
			tectonicsbpointyLabel.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsleft.setForeground(Color.black);
			tectonicsbottom.setForeground(Color.black);
			tectonicsleft.setFont(new Font("Times Roman", Font.BOLD, 10));
			tectonicsbottom.setFont(new Font("Times Roman", Font.BOLD, 10));
			break;
			}
		case 2:
			{
			xmaxLabel.setForeground(highlights);
			xmaxsliderLabel.setForeground(highlights);
			xmaxLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			xmaxsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}		
		case 3:
			{
			ymaxLabel.setForeground(highlights);
			ymaxsliderLabel.setForeground(highlights);
			ymaxLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			ymaxsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}		
		case 4:
			{
			endtimeyearLabel.setForeground(highlights);
			endtimesliderLabel.setForeground(highlights);
			endtimeyearLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			endtimesliderLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}		
		case 5:
			{
			topographydefaultLabel.setForeground(highlights);
			topographyslopeLabel.setForeground(highlights);
			topographydefaultLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			topographyslopeLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}
		case 6:
			{
			erodibilityuniformCheck.setForeground(highlights);
			erodibilityuniformvalueLabel.setForeground(highlights);
			erodibilityuniformCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			erodibilityuniformvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}
		case 7:
			{
			randomsliderLabel.setForeground(highlights);
			randomsliderLabel1.setForeground(highlights);
			randomsliderLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			randomsliderLabel1.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}
		case 8:
			{
			erodibilitybpointxCheck.setForeground(highlights);
			erodibilitybpointxLabel.setForeground(highlights);
			erodibilitybpointxCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			erodibilitybpointxLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			erodibilityleft.setForeground(highlights);
			erodibilityleft.setLabel("Left =     ");
			erodibilitybottom.setForeground(highlights);
			erodibilitybottom.setLabel("Right =    ");
			break;
			}
		case 9:
			{
			erodibilitybpointyCheck.setForeground(highlights);
			erodibilitybpointyLabel.setForeground(highlights);
			erodibilitybpointyCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			erodibilitybpointyLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			erodibilityleft.setForeground(highlights);
			erodibilityleft.setLabel("Top =      ");
			erodibilitybottom.setForeground(highlights);
			erodibilitybottom.setLabel("Bottom =   ");
			break;
			}
		case 10:
			{
			climatedefaultCheck.setForeground(highlights);
			climatedefaultCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			climatedefaultvalueLabel.setForeground(highlights);
			climatedefaultvalueLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}
		case 11:
			{
			climateincreasingCheck.setForeground(highlights);
			climateincreasingCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			climateincreasinglow.setForeground(highlights);
			climateincreasinghigh.setForeground(highlights);
			break;
			}
		case 12:
			{
			climatedecreasingCheck.setForeground(highlights);
			climatedecreasingCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			climateincreasinglow.setForeground(highlights);
			climateincreasinghigh.setForeground(highlights);
			break;
			}
		case 13:
			{
			erodibilityxleftvalueLabel.setForeground(Color.black);
			erodibilityxrightvalueLabel.setForeground(Color.black);
			erodibilityytopvalueLabel.setForeground(Color.black);
			erodibilityybottomvalueLabel.setForeground(Color.black);
			break;
			}
		case 14:
			{
			tectonicsdefaultCheck.setForeground(highlights);
			tectonicsdefaultCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
        		tectonicslabelCheck1.setForeground(highlights);
			tectonicslabelCheck1.setFont(new Font("Times Roman", Font.BOLD, 11));
			break;
			}
		case 15:
			{
			tectonicsbpointxCheck.setForeground(highlights);
			tectonicsbpointxCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			tectonicsbpointxLabel.setForeground(highlights);
			tectonicsbpointxLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			tectonicsleft.setForeground(highlights);
			tectonicsleft.setLabel("Left =  ");
			tectonicsbottom.setForeground(highlights);
			tectonicsbottom.setLabel("Right = ");
			break;
			}
		case 16:
			{
			tectonicsbpointyCheck.setForeground(highlights);
			tectonicsbpointyCheck.setFont(new Font("Times Roman", Font.BOLD, 11));
			tectonicsbpointyLabel.setForeground(highlights);
			tectonicsbpointyLabel.setFont(new Font("Times Roman", Font.BOLD, 11));
			tectonicsleft.setForeground(highlights);
			tectonicsleft.setLabel("Top =   ");
			tectonicsbottom.setForeground(highlights);
			tectonicsbottom.setLabel("Bottom = ");
			break;
			}
		default:  		
			{
			break;
			}
		}
  	}

  //This function checks whether the input is a valid number and converts it to a double                                     
  public static double getDouble(String numStr)
    	{   
    	double numDouble;				
     
    	numDouble = new Double(numStr).doubleValue();   
 
    	return numDouble;  	
  	}// end of getDouble
  

  //This function allows for a more controlled location of components on the applet.                             
   void constraint(Container cont, Component comp, 
		       int gridx, int gridy,
		       int gridwidth, int gridheight,
		       int fill, int anchor,
		       double weightx, double weighty,
		       int top, int left, int bottom, int right)
	{
	GridBagConstraints c = new GridBagConstraints();
	c.gridx = gridx;
	c.gridy = gridy;
	c.gridwidth = gridwidth;
	c.gridheight = gridheight;
	c.fill = fill;
	c.anchor = anchor;
	c.weightx = weightx;
	c.weighty = weighty;
	
	if(top + left + bottom + right > 0)
		{
		c.insets = new Insets(top, left, bottom, right);
		}
	
	((GridBagLayout) cont.getLayout()).setConstraints(comp, c);
	cont.add(comp);
	}//end of constraint
  	  	 	
    }// end class ErosionUI

/***********************************************************************************************
CLASS:	      CustomPanel

FUNCTION:     It allows the creation of a customized panel with or without a title.
	      The class contains:
	      -Constructors: 
    		*public CustomPanel()   	 		      
    		*public CustomPanel(int sentWidth, int sentHeight)   	
    		*public CustomPanel(int sentWidth, int sentHeight, int top, int left, int bottom, 
    		  int right, boolean drawInsets, int insetColor1, int insetColor2, int insetColor3)  
    		*public CustomPanel(int sentWidth, int sentHeight, int top, int left, int bottom, 
    		  int right, String s, Color c, boolean drawInsets, int insetColor1, 
    		  int insetColor2, int insetColor3)   	 		      
	      -Helping functions:
     		*public void paint(Graphics g)
    		*public Insets getInsets()
    		*public Dimension getPreferredSize()

INPUT:        Nothing.                                                        

OUTPUT:       A customized panel.

NOTES:        This class is derived from the class Panel.
***********************************************************************************************/
class CustomPanel extends Panel
    {
    //values for the default insets
    int top = 5;
    int left = 5;
    int bottom = 5;
    int right = 5;
    int newWidth, newHeight;
    int insetColor1, insetColor2, insetColor3;
    boolean drawInsets = false;
    
    //variables for the string
    String s = "";
    //orientation
    String o = "";
    String arrow = "";
    String chartoString = "";
    Font f = new Font("Times Roman", Font.BOLD, 14);
    Font f1 = new Font("Times Roman", Font.PLAIN, 12);
    Color c, insetColor;
    int ycoord;

    //constructor with no arguments
    public CustomPanel()   	 		      
    	{
      	super();
      	}//end CustomPanel constructor
  
    public CustomPanel(int sentWidth, int sentHeight)   	
        {
        super();
        newWidth = sentWidth;
        newHeight = sentHeight;
        drawInsets = false;
        }

    //constructor for arrows
    public CustomPanel(int sentWidth, int sentHeight, String arrow, int ycoord)      
      	{
      	super();
        newWidth = sentWidth;
        newHeight = sentHeight;
        this.arrow = arrow;
        this.ycoord = ycoord;
        }


    //constructor with arguments for size and insets
    public CustomPanel(int sentWidth, int sentHeight, int top, int left, int bottom, int right, boolean drawInsets, int insetColor1, int insetColor2, int insetColor3)   	 		      
      	{
      	super();
        newWidth = sentWidth;
        newHeight = sentHeight;
      	this.top = top;
      	this.left = left;
      	this.bottom = bottom;
      	this.right = right;
	this.drawInsets = drawInsets;
	this.insetColor1 = insetColor1;
	this.insetColor2 = insetColor2;
	this.insetColor3 = insetColor3;
        }

    //constructor with arguments for insets and string name
    public CustomPanel(int sentWidth, int sentHeight, int top, int left, int bottom, int right, String s, String o, Color c, boolean drawInsets, int insetColor1, int insetColor2, int insetColor3)   	 		      
      	{
      	super();
        newWidth = sentWidth;
        newHeight = sentHeight;
      	this.top = top;
      	this.left = left;
      	this.bottom = bottom;
      	this.right = right;
      	this.s = s;
      	this.o = o;
      	this.c = c;
	this.drawInsets = drawInsets;
	this.insetColor1 = insetColor1;
	this.insetColor2 = insetColor2;
	this.insetColor3 = insetColor3;
      	}//end CustomPanel constructor

     //paint method
     public void paint(Graphics g)
    	{
     	Dimension d = getSize();
     	//if the panel has a string, draw it
     	if(!s.equals(""))
      		{
      		int x = 0;
      		int y = 0;
        	g.setColor(c);
      		g.setFont(f);
        	FontMetrics fm = g.getFontMetrics();   
        	if(o.equals("h"))
        		{
        		x = (d.width - fm.stringWidth(s)) / 2;
        		y = d.height / 2;
	      		g.drawString(s, x, y);    	
        		}
      		}//end if
    	
    	if(!arrow.equals(""))
    		{
		g.setColor(Color.black);
		g.drawLine(0, ycoord, d.width, ycoord);	
    		}
    	
    	if(drawInsets)
    		{
		g.setColor(new Color(insetColor1 - 20, insetColor2 - 20, insetColor3 - 20));
    		//draw the left inset
		for(int i = 0; i < left ; ++i)
			{
			g.drawLine(i, i, i, d.height - i);	
			}
				
		//draw the top inset
		for(int i = 0; i < top; ++i)
			{
			g.drawLine(i, i, d.width - i, i);	
			}
		
		g.setColor(new Color(insetColor1  + 20, insetColor2  + 20, insetColor3 + 20));
		//draw the bottom inset
		for(int i = 0; i < bottom; ++i)
			{
			g.drawLine(i, d.height - i, d.width - i, d.height - i);	
			}
		
		//draw the right inset
		for(int i = 0; i < right; ++i)
			{
			g.drawLine(d.width - i, i, d.width - i, d.height - i);	
			}		
		}//end drawInsets
    	}//end paint

    //get the Insets for border
    public Insets getInsets()
    	{
      	return new Insets(top, left, bottom, right);	
      	
      	}//end Insets

    //send the dimension of the panel
    public Dimension getPreferredSize()
    	{
    	return new Dimension(newWidth, newHeight);
    	}

    }// end of CustomPanel

/***********************************************************************************************
CLASS:	      SurfacePanel

FUNCTION:     This class is a subclass of the class Panel.  It contains a Canvas and buttons to
	      to start the erosion process and to show or hide process information.
	      The class contains:
	      -Constructor: 
		*SurfacePanel(SharedParameters globalvariables, ErosionCanvas e1,
		     ErosionSim e2)= constructor
	      -Helping functions:
		*public void actionPerformed(ActionEvent e) = to listen to buttons
		*public void adjustmentValueChanged(AdjustmentEvent e) = to listen to canvas
			sliders
		*public Insets getInsets() = to set the insets

INPUT:        Nothing.                                                        

OUTPUT:       Nothing.

NOTES:        This class is derived from the class Panel.
***********************************************************************************************/
class SurfacePanel extends Panel implements ActionListener, AdjustmentListener
	{	
	final static int EDGE = 5;
    	ErosionSim esim;
	ErosionCanvas ecanv;

	static Scrollbar viewHeadingSlider,
		viewAltitudeSlider;
	CustomPanel button1, button2, button3, button4, check1, check2;
	CustomPanel buttonPanel, buttoncanvasPanel;
 	CustomPanel legends, colorRamp, elevationPanel, colorLabels, subPanel, legendbottomPanel;
	Button showsurfaceButton, resetButton;
	Label topheight, bottomheight;
	Label label0, label1, label2, label3;
	Label ef, l, es, v, a, t, i, o, n, blank1, blank2, blank3, blank4, blank5;
	static Label values = new Label("");
	SharedParameters gv;
	legendPanel lPanel;
	
	//default constructor
	SurfacePanel(SharedParameters globalvariables, ErosionCanvas e1,
		     ErosionSim e2)
		{
		super();
		gv = globalvariables;
		ecanv = e1;
		esim = e2;
		
		// Place the canvas on the panel

		Panel viewPanel = new Panel();
		viewPanel.setLayout(new BorderLayout());
		viewHeadingSlider = new Scrollbar(Scrollbar.HORIZONTAL,
						  -30, 10, -180, 180 + 10);
		viewPanel.add(viewHeadingSlider, BorderLayout.SOUTH);
		viewHeadingSlider.addAdjustmentListener(this);

	
		viewAltitudeSlider = new Scrollbar(Scrollbar.VERTICAL, 
						   -30, 10, -90, 0 +10);
		viewPanel.add(viewAltitudeSlider, BorderLayout.EAST);
		viewAltitudeSlider.addAdjustmentListener(this);
	
		viewPanel.add(ecanv, BorderLayout.CENTER);

		showsurfaceButton = new Button("Run");
		showsurfaceButton.addActionListener(this);
		gv.STARTBUTTON = showsurfaceButton;
		resetButton = new Button("Reset");
		resetButton.addActionListener(this);
		gv.PAUSEBUTTON = resetButton;
		button1 = new CustomPanel(50, 28, 1, 1, 1, 1, false, 169, 187, 211);
		button1.setLayout(new GridLayout(1,1));
		button2 = new CustomPanel(50, 28, 1, 1, 1, 1, false, 169, 187, 211);
		button2.setLayout(new GridLayout(1,1));
		button3 = new CustomPanel(50, 28, 1, 1, 1, 1, false, 169, 187, 211);
		button3.setLayout(new GridLayout(1,1));
		button4 = new CustomPanel(50, 28, 1, 1, 1, 1, false, 169, 187, 211);
		button4.setLayout(new GridLayout(1,1));
		check1 = new CustomPanel(50, 28, 1, 1, 1, 1, false, 169, 187, 211);
		check2 = new CustomPanel(50, 28, 1, 1, 1, 1, false, 169, 187, 211);
		check1.setLayout(new GridLayout(1,1));
		check2.setLayout(new GridLayout(1,1));
		label0 = new Label("");
		label1 = new Label("");
		label2 = new Label("");
		label3 = new Label("");
		buttonPanel = new CustomPanel(350, 50, 1, 1, 1, 1, true, 169, 187, 211);											
		buttoncanvasPanel = new CustomPanel(350, 450, 2, 2, 2, 2, true, 169, 187, 211);											
		setLayout(new BorderLayout());
		ecanv.setBackgroundColor(Color.white);
		buttonPanel.setLayout(new GridLayout(2,4));
		button1.add(showsurfaceButton);
		button2.add(resetButton);
 		legends = new CustomPanel(30, 320, 1, 1, 1, 1, true, 169, 187, 211);
 		legends.setLayout(new BorderLayout());
 		ef = new Label("E");
 		l = new Label("l");
 		es = new Label("e");
 		v = new Label("v");
 		a = new Label("a");
 		t = new Label("t");
 		i = new Label("i");
 		o = new Label("o");
 		n = new Label("n");
 		blank1 = new Label("");
 		blank2 = new Label("");
 		blank3 = new Label("");
 		blank4 = new Label("");
 		blank5 = new Label("");
 		elevationPanel = new CustomPanel(10, 300, 1, 1, 1, 1, false, 169, 187, 211);
 		elevationPanel.setLayout(new GridLayout(14,1));
 		elevationPanel.add(blank1);
 		elevationPanel.add(blank2);
 		elevationPanel.add(ef);
 		elevationPanel.add(l);
 		elevationPanel.add(es);
 		elevationPanel.add(v);
 		elevationPanel.add(a);
 		elevationPanel.add(t);
 		elevationPanel.add(i);
 		elevationPanel.add(o);
 		elevationPanel.add(n);
 		elevationPanel.add(blank3);
 		elevationPanel.add(blank4);
 		elevationPanel.add(blank5);
 		colorRamp = new CustomPanel(10, 300, 4, 4, 4, 4, false, 169, 187, 211);
 		colorRamp.setLayout(new BorderLayout());
 		lPanel = new legendPanel(10, 320, 169, 187, 211);
 		colorRamp.add(lPanel, BorderLayout.EAST);
 		topheight = new Label(" high  ");
 		bottomheight = new Label("    low ");
 		legends.add(topheight, BorderLayout.NORTH);
		legends.add(colorRamp, BorderLayout.CENTER);
		legends.add(elevationPanel, BorderLayout.WEST);	
		legendbottomPanel = new CustomPanel(10, 80, 4, 4, 44, 4, false, 169, 187, 211);
		legendbottomPanel.add(bottomheight);
		legends.add(legendbottomPanel, BorderLayout.SOUTH);
		subPanel = new CustomPanel(320, 440, 0, 0, 0, 0, false, 169, 187, 211);											
		subPanel.setLayout(new BorderLayout());
		buttonPanel.add(button1);
		buttonPanel.add(button2);
		buttonPanel.add(label2);
		buttonPanel.add(label3);
		subPanel.add(viewPanel, BorderLayout.CENTER);
		subPanel.add(buttonPanel, BorderLayout.SOUTH);
		buttoncanvasPanel.setLayout(new BorderLayout());
		buttoncanvasPanel.add(values, BorderLayout.NORTH);
		buttoncanvasPanel.add(subPanel, BorderLayout.CENTER);
		buttoncanvasPanel.add(legends, BorderLayout.WEST);
		add(buttoncanvasPanel, BorderLayout.CENTER);
		gv.values = values;
		}//end SurfacePanel constructor

	public void actionPerformed(ActionEvent e)
		{
		if(e.getSource() == showsurfaceButton)
			{
			if(showsurfaceButton.getLabel().equals("Run"))
				{
          			gv.SEDIMENT = 0.0;
          			gv.ROUTINESTARTED = true;
				esim.resume();
          			showsurfaceButton.setLabel("Suspend");
				}
			else
				{
			    	esim.suspend();
          			gv.ROUTINESTARTED = false;         		
				if(gv.ITERATIONCOUNTER < gv.TOTALYEARS)
          				{
          				showsurfaceButton.setLabel("Run");
          				}
				if(gv.ITERATIONCOUNTER >= gv.TOTALYEARS)
					{
					gv.STARTALLOVER = true;
       					showsurfaceButton.setLabel("Suspend");
					esim.resume();
					}
				}
			}
		if(e.getSource() == resetButton)
			{
		    	esim.suspend();
			gv.STARTALLOVER = true;
       			showsurfaceButton.setLabel("Suspend");
			esim.resume();
			}
		}// end ActionPerformed

	public void adjustmentValueChanged(AdjustmentEvent e)
	    	{
		// These can be changed while simulation is running
		// So no check is needed

		if(e.getSource() == viewHeadingSlider)
		    {
			// Horizontal scrollbar
			ecanv.setHeading(e.getValue());
		    }
		
		else if(e.getSource() == viewAltitudeSlider)
		    {
			// Vertical scrollbar
			ecanv.setAltitude(-e.getValue());
		    }
	    }


	public Insets getInsets()
      		{
      		return new Insets(EDGE, EDGE, EDGE, EDGE);	
      		}//end get Insets
	}//end class SurfacePanel

/***********************************************************************************************
CLASS:	      decimalLabel

***********************************************************************************************/
	
class decimalLabel extends Label
	{
		
		decimalLabel()
			{
			super("");
			}	
		
		protected void set1decimalText(double newnumber)
			{
            		DecimalFormat df1 = new DecimalFormat("#0.0");
            		this.setText(df1.format(newnumber));
			}

		protected void set2decimalText(double newnumber)
			{
            		DecimalFormat df1 = new DecimalFormat("#0.00");
            		this.setText(df1.format(newnumber));
			}

		protected void set3decimalText(double newnumber)
			{
            		DecimalFormat df1 = new DecimalFormat("#0.000");
            		this.setText(df1.format(newnumber));
			}

		protected void set4decimalText(double newnumber)
			{
            		DecimalFormat df1 = new DecimalFormat("#0.0000");
            		this.setText(df1.format(newnumber));
			}

		protected void set5decimalText(double newnumber)
			{
            		DecimalFormat df1 = new DecimalFormat("#0.00000");
            		this.setText(df1.format(newnumber));
			}

		}

/***********************************************************************************************
CLASS:	      legendPanel

***********************************************************************************************/
	
class legendPanel extends Panel
       		{
		ErosionColors legendColor = new ErosionColors();       		
		int newHeight, newWidth;
		int y = 0;
		
       		legendPanel(int newWidth, int newHeight, int color1, int color2, int color3)
       			{
       			super();
       			this.newHeight = newHeight;	
       			this.newWidth = newWidth;
       			setBackground(new Color(color1, color2, color3));
       			}	
       			
       		public void paint(Graphics g)
	     		{
			int y = 0;
    			Dimension d = getSize();
    			int index;

    			for(y = 0; y < d.height; y++)
				{
	   			index = (d.height - y) * (legendColor.getSize() - 1) / d.height;
	   			g.setColor(new Color(legendColor.getColor1(index),
				legendColor.getColor2(index),
				legendColor.getColor3(index)));
			        g.drawLine(0, y, newWidth, y);
				}
		      	}
    //send the dimension of the panel
    public Dimension getPreferredSize()
    	{
    	return new Dimension(newWidth, newHeight);
    	}
    }