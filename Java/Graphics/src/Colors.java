import java.awt.Color;
import java.awt.EventQueue;
import java.awt.Graphics;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

@SuppressWarnings("serial")
public class Colors extends JFrame {

	private DisplayJPanel contentPane;
	class DisplayJPanel extends JPanel {
		DisplayJPanel () {
			
		}
		@Override
		public void paintComponent(Graphics g) {
			super.paintComponent(g);
			int w = this.getBounds().width;
			int h = this.getBounds().height;
			int factor = 2;
			for (int i = 0; i < w/factor; i++) {
				for (int k = 0; k < h/factor; k++) {
					int red = (int) (Math.sin(Math.PI)*i);
					int green = (int) k*5;
					int blue = (int) 127;
					g.setColor(new Color((red)%255,(green)%255,(blue)%255));
					g.fillRect(i*2,k*2,factor,factor);
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
					Colors frame = new Colors();
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
	public Colors() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(10, 10, 1000, 1000);
		contentPane = new DisplayJPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		contentPane.repaint();
	}

}
