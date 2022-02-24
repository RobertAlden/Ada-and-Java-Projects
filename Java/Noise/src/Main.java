import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;
import javax.swing.border.EmptyBorder;

@SuppressWarnings("serial")
public class Main extends JFrame {

	private DisplayJPanel contentPane;
	
	class Point {
		public int x;
		public int y;
		
		Point(double _x, double _y){
			x = (int) Math.round(_x);
			y = (int) Math.round(_y);
		}
	}
	
	class DisplayJPanel extends JPanel {
		//Graph JPanel
		private double time = 0.0;
		private double rangeXMin = -5.0;
		private double rangeXMax = 5.0;
		private double rangeYMin = -5.0;
		private double rangeYMax = 5.0;
		private double tickIntervalX = 0.5;
		private double tickIntervalY = 0.5;
		private double majorTickValue = 1;
		private int minorTickSize = 5;
		private int majorTickSize = 15;
		private double calculationInterval = 0.01;
		private int discontinuityThreshold = 1000;
		private int lineMinDist = 2;
		private ArrayList<Point> Points = new ArrayList<Point>();
		
		public double rangeMap(double input,double input_start, double input_end, double output_start, double output_end) {
			double slope = (output_end - output_start) / (input_end - input_start);
			return output_start + slope * (input - input_start);
		}
		
		public void yxPlot() {
			int scr_w = getBounds().width;
			int scr_h = getBounds().height;
			Points.clear();
			for (double x = rangeXMin; x < rangeXMax;x+=calculationInterval) { // Calculates all points in range
				//Function(s) to plot goes here
				//double y = clamp(Math.sin(x+time),-0.5,0.5);
				double y = fract((Math.sin(x)*10000*time));
				
				// No more functions
				double mapped_x = rangeMap(x,rangeXMin,rangeXMax,0,scr_w);
				double mapped_y = rangeMap(y,rangeYMin,rangeYMax,scr_h,0);
				Point p = new Point(mapped_x,mapped_y);
				Points.add(p);
			}
		};
		public void polarPlot() {
			int scr_w = getBounds().width;
			int scr_h = getBounds().height;
			Points.clear();
			for (double t = 0; t < Math.PI*2;t+=calculationInterval) { // Calculates all points in range
				//Function(s) to plot goes here
				//double y = clamp(Math.sin(x+time),-0.5,0.5);
				double r = Math.sin(t*(time))*2;
				
				
				// No more functions
				double x = r * Math.cos(t);
				double y = r * Math.sin(t);
				double mapped_x = rangeMap(x,rangeXMin,rangeXMax,0,scr_w);
				double mapped_y = rangeMap(y,rangeYMin,rangeYMax,scr_h,0);
				Point p = new Point(mapped_x,mapped_y);
				Points.add(p);
			}
		};
		
		public double fract(double n) {
			return Math.abs(n - (int)n);
		}
		public double step(double threshold, double n) {
			return n > threshold ? 1.0 : 0.0;
		}
		public double lerp(double a, double b, double t) {
			return a + (b - a) * t;
		}
		public double clamp(double x, double min, double max) {
			return Math.max(min, Math.min(max, x));
		}
		
		public DisplayJPanel() {
			
		}
		
		@Override
		public void paintComponent(Graphics g) {
			super.paintComponent(g);
			
			int scr_w = getBounds().width;
			int scr_h = getBounds().height;
			g.drawLine(0, scr_h/2, scr_w, scr_h/2); // Drawing axes;
			g.drawLine(scr_w/2, 0, scr_w/2, scr_h);
			
			for (double x = rangeXMin; x < rangeXMax;x+=tickIntervalX) { // Drawing X tick marks
				double scr_x = rangeMap(x,rangeXMin,rangeXMax,0,scr_w);
				int adj_factor = (int)(1/tickIntervalX); // Avoids floating point division errors by calculating tick intervals as ints.
				if ((Math.round(Math.abs(x)*adj_factor) % (int)(majorTickValue*adj_factor)) != 0) { 
					g.drawLine((int)scr_x, (int)scr_h/2-minorTickSize, (int)scr_x, (int)scr_h/2+minorTickSize);
				} else {
					g.drawLine((int)scr_x, (int)scr_h/2-majorTickSize, (int)scr_x, (int)scr_h/2+majorTickSize);
					if (Math.round(x) != 0) {
						g.drawString(String.valueOf(x), (int)scr_x, (int)scr_h/2+majorTickSize);
					}
				}
			}
			for (double y = rangeYMin; y < rangeYMax;y+=tickIntervalY) { // Drawing Y tick marks
				double scr_y = rangeMap(y,rangeYMin,rangeYMax,scr_h,0);
				int adj_factor = (int)(1/tickIntervalY); // Avoids floating point division errors by calculating tick intervals as ints.
				if ((Math.round(Math.abs(y)*adj_factor) % (int)(majorTickValue*adj_factor)) != 0) { 
					g.drawLine((int)scr_w/2-minorTickSize, (int)scr_y, (int)scr_w/2+minorTickSize, (int)scr_y);
				} else {
					g.drawLine((int)scr_w/2-majorTickSize, (int)scr_y, (int)scr_w/2+majorTickSize, (int)scr_y);
					if (Math.round(y) != 0) {
						g.drawString(String.valueOf(y), (int)scr_w/2+majorTickSize, (int)scr_y);
					}
				}
			}
			
			//yxPlot();
			polarPlot();
			
			for (int i = 0; i < Points.size()-1;i++) {
				Point p1 = Points.get(i);
				Point p2 = Points.get(i+1);
				double dist = Math.pow(p2.x - p1.x,2) + Math.pow(p2.y - p1.y,2);
				if (((int)(Math.abs(p1.y - p2.y)) < discontinuityThreshold) && dist > (lineMinDist*lineMinDist)) {
					g.drawLine(p1.x, p1.y, p2.x, p2.y);
				} else {
					g.fillOval(p1.x, p1.y, 2, 2);
					g.fillOval(p2.x, p2.y, 2, 2);
				}
			}
			
			g.dispose();
		}
	}
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Main frame = new Main();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public Main() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(10, 10, 800, 800);
		contentPane = new DisplayJPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		int delay = 10;
		ActionListener ScreenRefresher = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				contentPane.time += 0.01;
				contentPane.repaint();
			}
		};
		new Timer(delay, ScreenRefresher).start();
	}

}
