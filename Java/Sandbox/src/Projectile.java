import java.awt.Graphics;
import java.awt.geom.Point2D;
import java.awt.geom.Point2D.Double;

public class Projectile {
	private Point2D.Double hpos;
	private Point2D.Double hvel;
	
	private Point2D.Double vpos;
	private Point2D.Double vvel;
	private double GRAVITY = 0.98;
	private double FRICTION = 0.99;
	private int height = 0;
	//private ArrayList<Point2D.Double> flight_path = new ArrayList<Point2D.Double>();
	
	public Projectile(Point2D _hpos, Point2D _hvel,Point2D _vpos, Point2D _vvel, int h) {
		hpos = (Double) _hpos.clone();
		hvel = (Double)_hvel;
		height = h;
		
		vpos = (Double)_vpos.clone();
		vvel = (Double)_vvel;
	}
	
	public boolean update() {
		this.hpos.x += this.hvel.x;
		this.hpos.y += this.hvel.y;
		this.hvel.x *= FRICTION;
		this.hvel.y += GRAVITY;
		
		this.vpos.x += this.vvel.x;
		this.vpos.y += this.vvel.y;
		this.vvel.x *= FRICTION;
		this.vvel.y *= FRICTION;
		if (this.hpos.y >= this.height) {
			hvel.setLocation(0, 0);
			vvel.setLocation(0, 0);
			return false;
		}
		return true;
	}
	
	public void draw(Graphics g) {
		g.drawOval((int)this.hpos.x-2, (int)this.hpos.y-2, 4, 4);
		g.drawOval((int)this.vpos.x-2, (int)this.vpos.y-2, 4, 4);
	}
}
