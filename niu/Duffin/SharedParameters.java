/***********************************************************************************************
CLASS:	      SharedParameters

FUNCTION:     This class holds the values shared by the user interface and the running 
	      simulation. These values should be changed by the UI and drive the simulation. 
	      The simulation reads these values but does not change them.
	      The class contains:
	      -Constructor: 
    	 	*public SharedParameters() = all variables are initialized to default values.
		       	
INPUT:	      User will change parameter values.

DATE CREATED: 		August 2002
DATE LAST MODIFIED:	April 2003
***********************************************************************************************/
import java.awt.*;

public class SharedParameters
    {
    // Shared parameters
    static int COLUMNS, OLDCOLUMNS, ROWS, OLDROWS, ENDTIME, OLDX, OLDY, 
    	       ITERATIONCOUNTER, YPOINT, XPOINT, BARSPROCESSED, 
    	       TECTONICSYPOINT, TECTONICSXPOINT, STEPCOUNTER, TOTALYEARS, 
    	       SAVECOUNTER, COLORCHANGE;
    static double BARWIDTH, SLOPE, OLDSLOPE, SEDIMENT, EROSION, RANDVALUE,
                  YRANDTOP, YRANDBOTTOM, XRANDLEFT, XRANDRIGHT, RAINFALLRATEDEFAULT,
                  RAININCREASELOW, RAININCREASEHIGH, RAINDECREASELOW, RAINDECREASEHIGH,
                  CARRYINGCAPACITY, TIMESTEP,
                  TECTONICSYTOP, TECTONICSYBOTTOM, TECTONICSXLEFT, TECTONICSXRIGHT,
                  HEIGHTDIFFERENCE;
    static boolean RANDEROSION, SHOWTEXT, DONE, ROUTINESTARTED,
                   CLIMATEDEFAULT, INCREASEON, DECREASEON, APPLYTECTONICS, EROSIONNEEDED,
                   STARTALLOVER, PREVIOUSTAB, NEXTTAB, FIRSTINTERVAL, SAVECOLUMN;
    static Button STARTBUTTON = null;
    static Button PAUSEBUTTON = null;
    static Label values = null;


    public SharedParameters()
    	{
	COLUMNS = OLDCOLUMNS = 60;
	ROWS = OLDROWS = 100;
	BARWIDTH = 1;
	ENDTIME = 10000;
	OLDSLOPE = SLOPE = 0.01;
	SEDIMENT = 0.0;
	EROSION = 0.05;
	RANDEROSION = SHOWTEXT = DONE = false;
	INCREASEON = DECREASEON = ROUTINESTARTED = false;
	APPLYTECTONICS = PREVIOUSTAB = false;
	EROSIONNEEDED = CLIMATEDEFAULT = STARTALLOVER = NEXTTAB = true;
	ITERATIONCOUNTER = YPOINT = XPOINT = 0;
	YRANDTOP = YRANDBOTTOM = XRANDLEFT = XRANDRIGHT = 0.0;
	TECTONICSYPOINT = 0;
	TECTONICSYTOP = TECTONICSYBOTTOM = 0;
	TECTONICSXPOINT = 0;
	TECTONICSXLEFT = TECTONICSXRIGHT = 0;
	RAINFALLRATEDEFAULT = CARRYINGCAPACITY = 0.1;
	RAININCREASELOW = RAINDECREASELOW = RAININCREASEHIGH = RAINDECREASEHIGH = 0;
	TIMESTEP = STEPCOUNTER = 1;
	BARSPROCESSED = OLDX = OLDY = 0;
	TOTALYEARS = SAVECOUNTER = 0;
	RANDVALUE = 0;
	HEIGHTDIFFERENCE = 0;
    	}    
    }//end class SharedParameters

