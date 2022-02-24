import java.awt.EventQueue;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.Random;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;
import javax.swing.border.EmptyBorder;
import javax.swing.JButton;


@SuppressWarnings("serial")
public class Main extends JFrame {

	private JPanel contentPane;
	private Random r = new Random();
	
	class DisplayJPanel extends JPanel {
		private ArrayList<Particle> Particles = new ArrayList<Particle>();
		private int ffdim = 100;
		private double[][] flowfieldx = new double[ffdim][ffdim];
		private double[][] flowfieldy = new double[ffdim][ffdim];
		private double[][] flowfieldt = new double[ffdim][ffdim];
		private int time = 0;
		
		public DisplayJPanel() {
			for (int i = 0; i < ffdim; i++) {
				for (int k = 0; k < ffdim; k++) {
					flowfieldx[k][i] = (.5-r.nextDouble())*0.1;
					flowfieldy[k][i] = (.5-r.nextDouble())*0.1;
					flowfieldt[k][i] = (.5-r.nextDouble())*0.1;
				}
			}
		}
		
		public void Click(int x,int y, int button) {
			double xv = (.5 - r.nextDouble()) * 5;
			double yv = (.5 - r.nextDouble()) * 5;
			int hb = this.getBounds().width;
			int vb = this.getBounds().height;
			Particle p = new Particle(x, y, xv, yv, hb, vb, 3);
			Particles.add(p);
		}
		
		@Override
		public void paintComponent(Graphics g) {
			super.paintComponent(g);
			//int hb = this.getBounds().width;
			//int vb = this.getBounds().height;
			for (int i = 0; i < ffdim; i++) {
				for (int k = 0; k < ffdim; k++) {
					//int fx = k*(hb/ffdim)+(hb/ffdim)/2;
					//int fy = i*(vb/ffdim)+(hb/ffdim)/2;
					//g.drawLine(fx,fy,fx+(int)(flowfieldx[k][i]* 200),fy+(int)(flowfieldy[k][i]* 200));
				}
			}
			for (int i = 0; i < Particles.size(); ++i) {
				Particle current = Particles.get(i);
				current.Draw(g);
			}
			g.dispose();
		}

		public void updateParticles() {
			for (int i = 0; i < ffdim; i++) {
				for (int k = 0; k < ffdim; k++) {
					double x1 = flowfieldx[k][i];
					double y1 = flowfieldy[k][i];
					double angle = 150 * (Math.PI/180) * (flowfieldt[k][i]) * time;
	
					double x2 = Math.cos(angle)*x1 - Math.sin(angle)*y1;
					double y2 = Math.sin(angle)*x1+Math.cos(angle)*y1;
					flowfieldx[k][i] = x2;
					flowfieldy[k][i] = y2;
				}
			}
			for (int i = 0; i < Particles.size(); ++i) {
				Particle current = Particles.get(i);
				current.Update(flowfieldx, flowfieldy, ffdim);
				current.Draw(getGraphics());
			}
			//repaint();
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
		setBounds(100, 100, 888, 617);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		DisplayJPanel panel = new DisplayJPanel();
		panel.setBounds(10, 10, 854, 506);
		contentPane.add(panel);
		panel.addMouseListener(new MouseAdapter() {
            public void mousePressed(MouseEvent e) {
            	for (int i = 0; i < 10; ++i) {
            		panel.Click(e.getX(),e.getY(),e.getButton());
            	}
            }
        });
		
		
		JButton ResetButton = new JButton("Reset");
		ResetButton.setBounds(10, 526, 181, 44);
		contentPane.add(ResetButton);
		ResetButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				// Executes on button click
			}
		});
		
		int delay = 10;
		ActionListener ScreenRefresher = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				panel.updateParticles();
				panel.time += 0.1;
			}
		};
		new Timer(delay, ScreenRefresher).start();
	}
}
