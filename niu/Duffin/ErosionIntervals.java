import java.awt.*;
import java.awt.image.*;
import java.lang.*;

public class ErosionIntervals extends Canvas implements Runnable
	{
	Dimension size;	
	boolean keepgoing;
	public Thread runIntervals = null;
	Graphics graph = null;
	Font f = new Font("Times Roman", Font.BOLD, 12);
	Font f1 = new Font("Times Roman", Font.PLAIN, 9);
	double heights[];
	SharedParameters sp;
	int marginLeft = 25;
	int marginBottom = 15;
	int marginTop = 10;
	int maxrows = 200;
    	//to work on the offscreen
    	Image osImage = null;
    	Graphics osGraph = null;
	int segmentHorizontal = 0;
	int segmentVertical = 20;
	int insignificant = 0;
	int redColor[];
	int greenColor[];
	int blueColor[];
	static int scaling = 0;
	static int redundant = 0;
	static int ruler = 0;
	static int cellHeight = 0;
	static double minValue = 20;
	static double maxValue = 20;
	static String strProfile = "";
	static int arrayIndex = 200;
	static int colorchange = 0;
	static int colorCounter = 1;

	public ErosionIntervals(SharedParameters sparams)
	    	{
		super();
    	    	setBackground(Color.white);
    	    	sp = sparams;
//		colorchange = 0;		
  	    	heights = new double[maxrows];
		for (int i = 0; i < maxrows; i++)
			{
			heights[i] = -1;	
			}
		createPalette();		
    	    	}
	
	
	public void passParms(double min, double max)
		{
		minValue = min;
		maxValue = max;	
		}
		

	public void startIntervals(double values[])
		{
		if(runIntervals == null)
			{
			for (int i = 0; i < arrayIndex; i++)
				{
				heights[i] = values[i];	
				}
			runIntervals = new Thread(this);	
			runIntervals.start();
		 	repaint();
			}
		}
	
	public void setName(String s)
		{
		strProfile = s;
		}
		
	public void settings(int aindex)
		{
		arrayIndex = aindex;
		if(runIntervals == null)
			{
			runIntervals = new Thread(this);	
			runIntervals.start();
		 	repaint();
			}
//		runIntervals = null;
		}

	public void run()
		{
		osGraph.setColor(new Color(redColor[colorchange], greenColor[colorchange], blueColor[colorchange]));
		for (int i = 0; i < arrayIndex - 1; i++)
			{		
  			osGraph.drawLine(marginLeft + (i * segmentHorizontal),
					 size.height - marginBottom - ((int) (heights[i] * segmentVertical) - insignificant),
					 marginLeft + ((i+1) * segmentHorizontal),
					 size.height - marginBottom - ((int) (heights[i+1] * segmentVertical) - insignificant));
			}
		if ((colorCounter % 3) == 0)
			{
			colorchange += 1;
			}
		colorCounter++;
		repaint();
		runIntervals = null;		
		}//end run

     public void clearIntervals()
     		{
     		osImage = null;
     		colorchange = 0;
     		colorCounter = 1;
     		}

     public void refreshGraph()
     		{
     		repaint();	
     		}
     		
     public void paint(Graphics g)
    		{
       		//this is run the first time
       		if(osImage == null)       	
        		{
         		Dimension d = getSize();
         		//variables to work on the offscreen
	        	osImage = createImage(d.width, d.height);
        		osGraph = osImage.getGraphics();
        		osGraph.clearRect(0 , 0, d.width, d.height);
			if ((((d.width - marginLeft) / arrayIndex) - (int) ((d.width - marginLeft) / arrayIndex)) < .50)
				{
       				segmentHorizontal = (d.width - marginLeft) / arrayIndex;
       				}
        		else
         			{
         			segmentHorizontal = ((d.width - marginLeft) / arrayIndex) + 1;
         			}
			if (sp.FIRSTINTERVAL)
				{
         			segmentVertical = (int) ((d.height - marginTop - marginBottom) / (maxValue - 15));         			
         			insignificant = (int) (minValue - 1) * segmentVertical;
         			}
	       		osGraph.setColor(Color.gray);
      			osGraph.setFont(f);
        		FontMetrics fm = osGraph.getFontMetrics();   
  			osGraph.drawString("Ht", 5, 10);    	
  			osGraph.drawString("Rows", d.width - 35, d.height - 1);
  			osGraph.drawString(strProfile, 70, 10);    	
			size = getSize();
			int height = size.height - marginLeft;
		        osGraph.setColor(Color.lightGray);
	        	osGraph.drawLine(marginLeft, size.height - marginBottom, size.width - marginLeft, size.height - marginBottom);
	        	osGraph.drawLine(marginLeft, marginTop, marginLeft, size.height - marginBottom);
      			osGraph.setFont(f1);
			ruler = 0;
			for (int i = 0; i < arrayIndex + 1; i++)
				{				
				if (segmentHorizontal > 2)
					{
					if ((i % 10) == 0)
						{
						osGraph.drawLine(marginLeft + (i * segmentHorizontal), size.height - marginBottom - 2,
							 marginLeft + (i * segmentHorizontal), size.height - marginBottom + 2);
						osGraph.drawString(""+ruler, marginLeft + (i * segmentHorizontal) - 2, size.height - 1);
						ruler += 10;
						}
					}
				else
					{
					if ((i % 20) == 0)
						{
						osGraph.drawLine(marginLeft + (i * segmentHorizontal), size.height - marginBottom - 2,
							 marginLeft + (i * segmentHorizontal), size.height - marginBottom + 2);
						osGraph.drawString(""+ruler, marginLeft + (i * segmentHorizontal) - 2, size.height - 1);
						ruler += 20;
						}
						
					}	
				}
			cellHeight = (int) (minValue - 1);
			if (segmentVertical == 0)
				{
				segmentVertical = 20;	
				}
			int numberofSegments = (size.height - marginBottom - marginTop) / segmentVertical;
			for (int i = 0; i < numberofSegments; i++)
				{
				if ((i % 3) == 0)
					{
	 		        	osGraph.drawLine(marginLeft - 2, size.height - marginBottom - (i * segmentVertical),
			        			 marginLeft + 2, size.height - marginBottom - (i * segmentVertical));
					osGraph.drawString(""+cellHeight, 1, size.height - marginBottom - (i * segmentVertical));
					cellHeight += 3;
					}
				}
      			osGraph.setFont(f);
     	         	}//end if osImage == null
       		//finally draw on the canvas
       		g.drawImage(osImage, 0, 0, this);
       		}//end paint
				
	//update() function overloaded to prevent image from flickering
   	public void update(Graphics g)
    		{
     		paint(g);
     		}

	void createPalette()
		{
		redColor = new int[33];
		greenColor = new int[33];
		blueColor = new int[33];

		redColor[0] = 27;
		greenColor[0] = 7;
		blueColor[0] = 247;
		
		redColor[1] = 57;
		greenColor[1] = 172;
		blueColor[1] = 249;

		redColor[2] = 57;
		greenColor[2] = 249;
		blueColor[2] = 224;
		
		redColor[3] = 14;
		greenColor[3] = 249;
		blueColor[3] = 136;
		
		redColor[4] = 14;
		greenColor[4] = 249;
		blueColor[4] = 22;

		redColor[5] = 183;
		greenColor[5] = 249;
		blueColor[5] = 14;
		
		redColor[6] = 242;
		greenColor[6] = 249;
		blueColor[6] = 14;

		redColor[7] = 249;
		greenColor[7] = 206;
		blueColor[7] = 14;
		
		redColor[8] = 249;
		greenColor[8] = 163;
		blueColor[8] = 14;
		
		redColor[9] = 249;
		greenColor[9] = 101;
		blueColor[9] = 14;

		redColor[10] = 249;
		greenColor[10] = 42;
		blueColor[10] = 14;
		}
	}