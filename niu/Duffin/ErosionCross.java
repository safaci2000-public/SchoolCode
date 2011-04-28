import java.awt.*;
import java.awt.image.*;
import java.lang.*;

public class ErosionCross extends Canvas 
	{
    Font f = new Font("Times Roman", Font.BOLD, 14);
    public ErosionCross()
	    {
    	    setBackground(Color.white);
    	    }

     public void paint(Graphics g)
    		{
	       	g.setColor(Color.gray);
      		g.setFont(f);
        	FontMetrics fm = g.getFontMetrics();   
  		g.drawString("Future X-section", 30, 30);    	
        	}
	}