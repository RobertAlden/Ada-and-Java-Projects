import java.awt.Color;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.awt.event.*;
import java.awt.GridBagLayout;

import javax.swing.JButton;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import javax.swing.JTextPane;
import javax.swing.border.LineBorder;
import javax.swing.Timer;
import javax.swing.JLabel;

@SuppressWarnings("serial")
public class GoL extends JFrame {
	private Gun myGun = new Gun(225,250,100,250);
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					GoL frame = new GoL();
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

	public GoL() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(192, 108, 1044, 536);
		getContentPane().setLayout(null);
		
		JPanel DisplayPanel = new JPanel();
		DisplayPanel.setBorder(new LineBorder(Color.LIGHT_GRAY));
		DisplayPanel.setBounds(21, 22, 999, 295);
		getContentPane().add(DisplayPanel);
		
		
		
		JPanel ControlPanel = new JPanel();
		ControlPanel.setBounds(21, 327, 144, 162);
		getContentPane().add(ControlPanel);
		GridBagLayout gbl_ControlPanel = new GridBagLayout();
		gbl_ControlPanel.columnWidths = new int[]{0, 0, 0, 0};
		gbl_ControlPanel.rowHeights = new int[]{0, 40, 40, 38, 0};
		gbl_ControlPanel.columnWeights = new double[]{0.0, 0.0, 0.0, Double.MIN_VALUE};
		gbl_ControlPanel.rowWeights = new double[]{0.0, 0.0, 0.0, 0.0, Double.MIN_VALUE};
		ControlPanel.setLayout(gbl_ControlPanel);
		
		JTextPane TR_Val = new JTextPane();
		TR_Val.setText("5.0");
		TR_Val.setBounds(301, 327, 99, 19);
		getContentPane().add(TR_Val);
		JTextPane Ele_Val = new JTextPane();
		Ele_Val.setText("5.0");
		Ele_Val.setBounds(301, 356, 99, 19);
		getContentPane().add(Ele_Val);
		JTextPane proj_vel = new JTextPane();
		proj_vel.setText("20");
		proj_vel.setBounds(301, 385, 99, 19);
		getContentPane().add(proj_vel);
		JLabel Tr_Out = new JLabel("Curr. Tr.");
		Tr_Out.setBounds(175, 449, 45, 19);
		getContentPane().add(Tr_Out);
		
		
		
		JLabel Ele_Out = new JLabel("Curr. El.");
		Ele_Out.setBounds(230, 449, 45, 19);
		getContentPane().add(Ele_Out);
		
		JButton UpButton = new JButton("U");
		UpButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				myGun.setHAngle(myGun.getHAngle() + Double.parseDouble(Ele_Val.getText()));
				drawGun(DisplayPanel);
				Ele_Out.setText(String.valueOf(myGun.getHAngle()));
			}
		});
		GridBagConstraints gbc_UpButton = new GridBagConstraints();
		gbc_UpButton.fill = GridBagConstraints.HORIZONTAL;
		gbc_UpButton.insets = new Insets(0, 0, 5, 5);
		gbc_UpButton.gridx = 1;
		gbc_UpButton.gridy = 1;
		ControlPanel.add(UpButton, gbc_UpButton);
		
		JButton LeftButton = new JButton("L");
		LeftButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				myGun.setVAngle(myGun.getVAngle() - Double.parseDouble(TR_Val.getText()));
				Tr_Out.setText(String.valueOf(myGun.getVAngle()));
				drawGun(DisplayPanel);
			}
		});
		GridBagConstraints gbc_LeftButton = new GridBagConstraints();
		gbc_LeftButton.fill = GridBagConstraints.HORIZONTAL;
		gbc_LeftButton.insets = new Insets(0, 0, 5, 5);
		gbc_LeftButton.gridx = 0;
		gbc_LeftButton.gridy = 2;
		ControlPanel.add(LeftButton, gbc_LeftButton);
		
		JButton FireButton = new JButton("F");
		FireButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				myGun.Fire(Double.parseDouble(proj_vel.getText()));
				drawGun(DisplayPanel);
			}
		});
		GridBagConstraints gbc_FireButton = new GridBagConstraints();
		gbc_FireButton.insets = new Insets(0, 0, 5, 5);
		gbc_FireButton.gridx = 1;
		gbc_FireButton.gridy = 2;
		ControlPanel.add(FireButton, gbc_FireButton);
		
		JButton RightButton = new JButton("R");
		RightButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				myGun.setVAngle(myGun.getVAngle() + Double.parseDouble(TR_Val.getText()));
				Tr_Out.setText(String.valueOf(myGun.getVAngle()));
				drawGun(DisplayPanel);
			}
		});
		GridBagConstraints gbc_RightButton = new GridBagConstraints();
		gbc_RightButton.fill = GridBagConstraints.HORIZONTAL;
		gbc_RightButton.insets = new Insets(0, 0, 5, 0);
		gbc_RightButton.gridx = 2;
		gbc_RightButton.gridy = 2;
		ControlPanel.add(RightButton, gbc_RightButton);
		
		JButton DownButton = new JButton("D");
		
		DownButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				myGun.setHAngle(myGun.getHAngle() - Double.parseDouble(Ele_Val.getText()));
				drawGun(DisplayPanel);
				Ele_Out.setText(String.valueOf(myGun.getHAngle()));
			}
		});
		GridBagConstraints gbc_DownButton = new GridBagConstraints();
		gbc_DownButton.fill = GridBagConstraints.HORIZONTAL;
		gbc_DownButton.insets = new Insets(0, 0, 0, 5);
		gbc_DownButton.gridx = 1;
		gbc_DownButton.gridy = 3;
		ControlPanel.add(DownButton, gbc_DownButton);
		
		
		
		
		JTextPane textPane_3 = new JTextPane();
		textPane_3.setBounds(301, 414, 99, 19);
		getContentPane().add(textPane_3);
		
		JButton Reset = new JButton("Reset Display");
		Reset.setBounds(600, 397, 155, 37);
		getContentPane().add(Reset);
		
		JLabel lblNewLabel = new JLabel("Traverse incr.");
		lblNewLabel.setBounds(209, 327, 82, 19);
		getContentPane().add(lblNewLabel);
		
		JLabel lblElevationIncr = new JLabel("Elevation incr.");
		lblElevationIncr.setBounds(209, 356, 82, 19);
		getContentPane().add(lblElevationIncr);
		
		JLabel lblProjectileVel = new JLabel("Muzzle Vel");
		lblProjectileVel.setBounds(209, 385, 82, 19);
		getContentPane().add(lblProjectileVel);
		
		Ele_Out.setText(String.valueOf(myGun.getHAngle()));
		Tr_Out.setText(String.valueOf(myGun.getVAngle()));
		
		Reset.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				Graphics g = DisplayPanel.getGraphics();
				g.clearRect(0, 0, 902, 295);
				g.dispose();
			}
		});
		
		int delay = 25;
		ActionListener ScreenRefresher = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				drawGun(DisplayPanel);
			}
		};
		new Timer(delay, ScreenRefresher).start();
		
	}
	
	public void drawGun(JPanel t) {
		Graphics g = t.getGraphics();
		myGun.drawH(g);
		myGun.drawV(g);
		myGun.updateProjectiles(g);
		g.dispose();
		
	}
}
