/***********************************************************************************************
CLASS:	      landsap.java

FUNCTION:     landsap declares and instantiates objects from the ErosionUI, ErosionSim,     
	      ErosionCanvas and SharedParameters classes.                                    
	      The class contains:
	      -init()
	       It creates objects from the classes metioned and calls starts running the 
	       threads for the ErosionSim, ErosionUI and ErosionCanvas objects.

DATE CREATED: 		August 2002
DATE LAST MODIFIED:	April 2003
***********************************************************************************************/

import java.applet.*;
import java.awt.*;

public class landsap extends Applet
{
    ErosionUI eui;
    ErosionSim esim;
    ErosionCanvas ecanv;

    SharedParameters sparam;  // The parameters driving the simulation
 
    public void init()
    {
	sparam = new SharedParameters();

	ecanv = new ErosionCanvas();
	ecanv.start();

	esim = new ErosionSim(sparam, ecanv);
	esim.start();
	
	eui = new ErosionUI(this, esim, sparam, ecanv);
    }

    public void start()
    {
	eui.start();  // It would be nice to get rid of this.
    }
}



