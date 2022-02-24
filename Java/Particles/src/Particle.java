import java.awt.Color;
import java.awt.Graphics;

public class Particle {
	private double x;
	private double y;
	private double x_vel;
	private double y_vel;
	private double size;
	private int hb;
	private int vb;
	private double friction  = .99;
	public Particle(int _x, int _y, double _x_vel, double _y_vel, int hbound, int vbound, int _size) {
		x = _x;
		y = _y;
		x_vel = _x_vel;
		y_vel = _y_vel;
		size = _size;
		hb = hbound;
		vb = vbound;
	}
	
	public void Update(double[][] ffx, double[][] ffy, int dim) {
		x_vel += ffx[(int) (x/hb*dim)][(int) (y/vb*dim)];
		y_vel += ffy[(int) (x/hb*dim)][(int) (y/vb*dim)];
		
		if (x + x_vel > hb || x + x_vel < 0) {
			x_vel *= -1;
		}
		if (y + y_vel > vb || y + y_vel < 0) {
			y_vel *= -1;
		}	
		
		x += x_vel;
		y += y_vel;
		x_vel *= friction;
		y_vel *= friction;
	}
	
	public void Draw(Graphics g) {
		
		g.setColor(Color.getHSBColor((float)((x+y)/2)/2000, 1.0f, 1.0f));
		g.fillOval((int)(x-size/2), (int)(y-size/2), (int)size, (int)size);
	}
}
