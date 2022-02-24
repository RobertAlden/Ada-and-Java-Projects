import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JTextField;
import javax.swing.Timer;
import javax.swing.JButton;
import java.io.*;

@SuppressWarnings("serial")
public class UnitA extends JFrame {

	private JPanel contentPane;
	private JTextField textField;
    FileOutputStream out = null;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					UnitA frame = new UnitA();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	private void Write() throws IOException {
		try {
			out = new FileOutputStream("C:\\Users\\randy\\Desktop\\middleman.txt");
			out.write(textField.getText().getBytes());
			out.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * Create the frame.
	 */
	public UnitA() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		textField = new JTextField();
		textField.setBounds(126, 76, 185, 37);
		contentPane.add(textField);
		textField.setColumns(10);
		
		JButton WriteButton = new JButton("Write");
		WriteButton.setBounds(176, 123, 85, 21);
		contentPane.add(WriteButton);
		WriteButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					Write();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		});
		
		int delay = 100;
		ActionListener ScreenRefresher = new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					Write();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		};
		new Timer(delay, ScreenRefresher).start();
	}
}
