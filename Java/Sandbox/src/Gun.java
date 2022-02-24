import java.awt.Graphics;
import java.awt.geom.Point2D;
import java.util.ArrayList;

public class Gun {
	private double h_angle;
	private double v_angle;
	private Point2D.Double HBarrelPoint = new Point2D.Double();
	private Point2D.Double VBarrelPoint = new Point2D.Double();
	private Point2D.Double ZeroedHBarrelPoint = new Point2D.Double();
	private Point2D.Double ZeroedVBarrelPoint = new Point2D.Double();
	private Point2D.Double HCenter = new Point2D.Double();
	private Point2D.Double VCenter = new Point2D.Double();
	private ArrayList<Projectile> proj_list = new ArrayList<Projectile>();
	
	public Gun(int hx, int hy, int vx, int vy) {
		
		HCenter.x = hx;
		HCenter.y = hy;
		VCenter.x = vx;
		VCenter.y = vy;
		
		ZeroedHBarrelPoint.setLocation(hx + 15, hy);
		HBarrelPoint.setLocation(ZeroedHBarrelPoint);
		
		ZeroedVBarrelPoint.setLocation(vx, vy - 15);
		VBarrelPoint.setLocation(ZeroedVBarrelPoint);
		setHAngle(0.0);
		setVAngle(0.0);
	}
	public void drawH(Graphics g) {
		int x = (int) this.HCenter.getX();
		int y = (int) this.HCenter.getY();
		g.clearRect(x-15, y-15, 30, 30);
		Point2D.Double p1 = new Point2D.Double(x+5,y-5);
		Point2D.Double p2 = new Point2D.Double(x+5,y+2);
		Point2D.Double p3 = new Point2D.Double(x-8,y+2);
		g.drawLine((int)p1.x, (int)p1.y, (int)p2.x, (int)p2.y);
		g.drawLine((int)p2.x, (int)p2.y, (int)p3.x, (int)p3.y);
		g.drawLine((int)p3.x, (int)p3.y, (int)p1.x, (int)p1.y);

		g.drawLine((int)this.HCenter.x,(int)this.HCenter.y,(int)this.HBarrelPoint.x,(int)this.HBarrelPoint.y);
	}
	
	public void drawV(Graphics g) {
		int x = (int) this.VCenter.getX();
		int y = (int) this.VCenter.getY();
		g.clearRect(x-15, y-15, 30, 30);
		Point2D.Double p1 = new Point2D.Double(x+5,y-2);
		Point2D.Double p2 = new Point2D.Double(x-5,y-2);
		Point2D.Double p3 = new Point2D.Double(x,y+5);
		g.drawLine((int)p1.x, (int)p1.y, (int)p2.x, (int)p2.y);
		g.drawLine((int)p2.x, (int)p2.y, (int)p3.x, (int)p3.y);
		g.drawLine((int)p3.x, (int)p3.y, (int)p1.x, (int)p1.y);
		
		g.drawLine((int)this.VCenter.x,(int)this.VCenter.y,(int)this.VBarrelPoint.x,(int)this.VBarrelPoint.y);
	}

	public double getHAngle() {
		return h_angle;
	}

	public void setHAngle(double angle) {
		
		double s = Math.sin(angle * Math.PI/180);
		double c = Math.cos(angle * Math.PI/180);
		
		double new_bx = (this.ZeroedHBarrelPoint.x-this.HCenter.x) * c - (this.ZeroedHBarrelPoint.y-this.HCenter.y) * s + this.HCenter.x;
		double new_by = -1 * (this.ZeroedHBarrelPoint.x-this.HCenter.x) * s + (this.ZeroedHBarrelPoint.y-this.HCenter.y) * c + this.HCenter.y;
		
		double new_angle = angle % 360;
		if (new_angle < 0) {
			new_angle += 360;
		}
		this.h_angle = new_angle;
		this.HBarrelPoint.setLocation(new_bx, new_by);
	}

	public double getVAngle() {
		return v_angle;
	}

	public void setVAngle(double angle) {
		double s = Math.sin(angle * Math.PI/180);
		double c = Math.cos(angle * Math.PI/180);
		
		double new_bx = (this.ZeroedVBarrelPoint.x-this.VCenter.x) * c - (this.ZeroedVBarrelPoint.y-this.VCenter.y) * s + this.VCenter.x;
		double new_by = (this.ZeroedVBarrelPoint.x-this.VCenter.x) * s + (this.ZeroedVBarrelPoint.y-this.VCenter.y) * c + this.VCenter.y;
		
		double new_angle = angle % 360;
		if (new_angle < 0) {
			new_angle += 360;
		}
		this.v_angle = new_angle;
		this.VBarrelPoint.setLocation(new_bx, new_by);
	}
	
	public void Fire(double _force) {
		double x = Math.cos((v_angle+90) * Math.PI/180) * Math.cos((v_angle+90) * Math.PI/180) * Math.signum(v_angle-90);
		double z = Math.sin((v_angle+90) * Math.PI/180) * Math.cos(-h_angle * Math.PI/180);
		double y = Math.sin(-h_angle * Math.PI/180);
		
		double hxvel = _force * z;
		double hyvel = _force * y;
		
		double vxvel = -_force * x;
		double vyvel = -_force * z;
		
		System.out.println(hxvel+","+hyvel+":"+vxvel+","+vyvel);
		Point2D.Double Hvel = new Point2D.Double(hxvel,hyvel);
		Point2D.Double Vvel = new Point2D.Double(vxvel,vyvel);
		int height = (int)(HCenter.y);
		Projectile p = new Projectile(this.HBarrelPoint, Hvel, this.VBarrelPoint, Vvel, height);
		proj_list.add(p);
		
	}
	public void updateProjectiles(Graphics g){
		for (int i = 0; i < proj_list.size(); i++) {
			proj_list.get(i).draw(g);
			boolean res = proj_list.get(i).update();
			if (res == false) {
				proj_list.get(i).draw(g);
				proj_list.remove(i);
				i--;
			}
		}
	}
}
