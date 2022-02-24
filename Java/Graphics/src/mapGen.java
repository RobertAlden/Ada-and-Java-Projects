import java.awt.EventQueue;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;
import javax.swing.border.EmptyBorder;
import javax.swing.border.LineBorder;
import java.awt.Color;
import javax.swing.JButton;

@SuppressWarnings("serial")
public class mapGen extends JFrame {

	private JPanel contentPane;
 	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					mapGen frame = new mapGen();
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
	
	class DisplayJPanel extends JPanel {
		private int wWidth;
		private int wHeight;
		private double CellDim;
		double zoomFactor;
		private int currPanOffsetX;
		private int currPanOffsetY;
		private int newPanOffsetX;
		private int newPanOffsetY;
		private int zBoundW;
		private int zBoundH;
		private int zoomStage;
		private int EnhanceFactor = 2;
		private double bias = 0.33;
		private int[][] World;
		private double[][] ZMap;
		private Random r = new Random();
		private int panStage;
		
		public void Generate() {
			wWidth = 21;
			wHeight = 11;
			CellDim = 64;
			zoomFactor = 1.0;
			currPanOffsetX = 0;
			currPanOffsetY = 0;
			zBoundW = getBounds().width;
			zBoundH = getBounds().height;
			zoomStage = 0;
			panStage = 0;
			World = new int[wHeight][wWidth];
			ZMap = new double[wHeight][wWidth];
			
			for (int i=0;i<wHeight;i++) {
				for (int k=0;k<wWidth;k++) {
					if (r.nextDouble() < bias) {
						World[i][k] = 1;
						ZMap[i][k] = 5+r.nextDouble()*5;
					}
				}
			}
			
			for (int i=0;i<wHeight;i++) {
				for (int k=0;k<wWidth;k++) {
					if ((i == 0 || i == wHeight-1) || (k == 0 || k == wWidth-1)) {
						World[i][k] = 0;
						ZMap[i][k] = 0;
					} else {
						double neighbors = 0;
						for (int _i=-1;_i<2;_i++) {
							for (int _k=-1;_k<2;_k++) {
								neighbors += Math.signum(World[i+_i][k+_k]);
							}
						}
						if ((r.nextDouble()) < neighbors/9) {
							World[i][k] = 1;
							ZMap[i][k] = 5+r.nextDouble()*5;
						}
					}
				}
			}
			repaint();
		}
		
		public double sample(int x, int y) {
			double inp = ZMap[y][x];
			double avg = 0;
			
			if (inp == 0) {
				avg += 5+r.nextDouble()*5;
			}
			
			for (int _i=-1;_i<2;_i++) {
				for (int _k=-1;_k<2;_k++) {
					avg += ZMap[y+_i][x+_k]*(.5+(r.nextDouble()));
				}
			}
			
			return avg / 9;
		}
		
		public void Enhance() {
			double oldCellDim = CellDim;
			CellDim = Math.max(0.125, CellDim /= EnhanceFactor);
			if (oldCellDim > CellDim) {
				int newWIDTH = wWidth * EnhanceFactor;
				int newHEIGHT = wHeight * EnhanceFactor;
				int[][] newWorld = new int[newHEIGHT][newWIDTH];
				double[][] newZMap = new double[newHEIGHT][newWIDTH];
				for (int i=0;i<wHeight;i++) {
					for (int k=0;k<wWidth;k++) {
						int newI = i*EnhanceFactor;
						int newK = k*EnhanceFactor;
						double neighbors = 0;
						
						if ((i == 0 || i == wHeight-1) || (k == 0 || k == wWidth-1)) {
							neighbors = 0;
						} else {
							for (int _i=-1;_i<2;_i++) {
								for (int _k=-1;_k<2;_k++) {
									neighbors += Math.signum(World[i+_i][k+_k]);
								}
							}
						}
						
						for (int j=0;j<EnhanceFactor;j++) {
							for (int m=0;m<EnhanceFactor;m++) {
								if (neighbors < 3) {
									newWorld[newI+j][newK+m] = 0;
									newZMap[newI+j][newK+m] = 0;
								} else if (neighbors > 5) {
									newWorld[newI+j][newK+m] = 1;
									newZMap[newI+j][newK+m] = sample(k,i);
								} else if ((r.nextDouble()) < 0.3) {
									newWorld[newI+j][newK+m] = 1;
									newZMap[newI+j][newK+m] = sample(k,i);
								}
							}
						}
					}
				}
				World = newWorld;
				ZMap = newZMap;
				wWidth = newWIDTH;
				wHeight = newHEIGHT;
				System.out.println(newWIDTH+","+newHEIGHT+":"+CellDim);
			}
			repaint();
		}
		
		public void Clean() {
			for (int i=0;i<wHeight;i++) {
				for (int k=0;k<wWidth;k++) {
					if (World[i][k] == 1) {
						double neighbors = 0;
						for (int _i=-1;_i<2;_i++) {
							for (int _k=-1;_k<2;_k++) {
								neighbors += Math.signum(World[i+_i][k+_k]);
							}
						}
						if (neighbors <= 2) {
							World[i][k] = 0;
							ZMap[i][k] = 0;
						}
					}
				}
			}
			repaint();
		}
		
		public void Click(int x, int y, int button) {
			if (World != null) {
				if (button == 1) {
					if (zoomStage == 0) {
						newPanOffsetX = (int)(x/zoomFactor);
						newPanOffsetY = (int)(y/zoomFactor);
						zoomStage = 1;
						
					} else if (zoomStage == 1) {
						resizeField(newPanOffsetX, newPanOffsetY, (int)((x - newPanOffsetX)/zoomFactor), (int)((y - newPanOffsetY)/zoomFactor));
						zoomStage = 0;
					}
				} else if (button == 3) {
					if (panStage == 0) {
						newPanOffsetX = x;
						newPanOffsetY = y;
						panStage = 1;
						
					} else if (panStage == 1) {
						panStage = 0;
						currPanOffsetX -= (x - newPanOffsetX) / zoomFactor;
						currPanOffsetY -= (y - newPanOffsetY) / zoomFactor;
						repaint();
					}
				}
			}
		}
		
		private void resizeField(int x, int y, int w, int h) {
			System.out.println("Resizing view to "+x+" "+y+" "+w+" "+h);
			currPanOffsetX += x;
			currPanOffsetY += y;
			double zf = Math.pow(Math.floor(Math.log((getBounds().width/w)) / Math.log(2)), 2);
			zoomFactor = Math.min((int) zf,128.0);
			zBoundW = (int) Math.round(getBounds().width / zoomFactor);
			zBoundH = (int) Math.round(getBounds().height /zoomFactor);
			System.out.println("Resized view to "+ currPanOffsetX +" "+ currPanOffsetY +" "+ zBoundW +" "+ zBoundH);
			System.out.println(zoomFactor);
			repaint();
		}
		public void resetView() {
			zoomFactor = 1.0;
			currPanOffsetX = 0;
			currPanOffsetY = 0;
			zBoundW = getBounds().width;
			zBoundH = getBounds().height;
			zoomStage = 0;
			panStage = 0;
			repaint();
		}
		
		@Override
		public void paintComponent(Graphics g) {
			g.setColor(new Color(15,15,145));
			g.fillRect(0, 0, (int)(wWidth*CellDim), (int)(wHeight*CellDim));
			int v_x = (int) Math.round(currPanOffsetX / CellDim);
			int v_y = (int) Math.round(currPanOffsetY / CellDim);
			int v_w = v_x+(int) Math.round(zBoundW / CellDim);
			int v_h = v_y+(int) Math.round(zBoundH / CellDim);
			double res = CellDim*zoomFactor;
			int d = (int)Math.max(1.0,Math.round(res));
			int step = (int) Math.max(1.0,Math.round(1/res));
			for (int i=v_y;i<v_h;i+=step) {
				for (int k=v_x;k<v_w;k+=step) {
					if (World[i][k] >= 1) {			
						g.setColor(heightToColor(ZMap[i][k]));
						g.fillRect((int)((k-v_x)*res), (int)((i-v_y)*res), d, d);
					}
				}
			}
			g.dispose();
		}
		public Color heightToColor(double h) {
			h = Math.min(10, Math.max(1, h));
			Color c;
			c = new Color(25 + (int)(16*h),140+(int) (11*h),30);
			return c;
		}
	}
	
	public mapGen() {
		setResizable(false);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(10, 10, 1400, 800);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		
		DisplayJPanel Display = new DisplayJPanel();
		Display.setBorder(new LineBorder(new Color(0, 0, 0)));
		Display.setBounds(10, 10, 1344, 704);
		contentPane.add(Display);
		Display.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
               Display.Click(e.getX(),e.getY(),e.getButton());
            }
            public void mouseReleased(MouseEvent e) {
                Display.Click(e.getX(),e.getY(),e.getButton()); 
             }
        });

		JButton ResetButton = new JButton("Generate/Reset");
		ResetButton.setBounds(10, 732, 137, 21);
		contentPane.add(ResetButton);
		ResetButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Display.Generate();
			}
		});
		
		JButton IterateButton = new JButton("Enhance");
		IterateButton.setBounds(157, 732, 137, 21);
		contentPane.add(IterateButton);

		IterateButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Display.Enhance();
			}
		});
		
		JButton CleanButton = new JButton("Clean");
		CleanButton.setBounds(304, 732, 137, 21);
		contentPane.add(CleanButton);
		
		JButton ViewReset = new JButton("Reset View");
		ViewReset.setBounds(451, 732, 137, 21);
		contentPane.add(ViewReset);
		ViewReset.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Display.resetView();
			}
		});
		
		CleanButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Display.Clean();
			}
		});
		
		int delay = 1000;
		ActionListener ScreenRefresher = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
			}
		};
		new Timer(delay, ScreenRefresher).start();
		
		
	}
}
