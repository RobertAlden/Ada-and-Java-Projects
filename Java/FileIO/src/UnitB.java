import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JButton;
import java.io.*;
import javax.swing.Timer;
import javax.swing.JTextArea;

@SuppressWarnings("serial")
public class UnitB extends JFrame {

	private JPanel contentPane;
	FileInputStream in = null;
	JTextArea textArea;
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					UnitB frame = new UnitB();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	private void Read() throws IOException {
		try {
			in = new FileInputStream("C:\\Users\\randy\\Desktop\\middleman.txt");
			int size = in.available();
			textArea.setText("");
			textArea.setLineWrap(true);
	         for(int i = 0; i < size; i++) {
	        	 textArea.setText(textArea.getText() + (char)in.read() + "");
	         }
			
			in.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/**
	 * Create the frame.
	 */
	public UnitB() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(500, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton ReadButton = new JButton("Read");
		ReadButton.setBounds(167, 232, 85, 21);
		contentPane.add(ReadButton);
		
		textArea = new JTextArea();
		textArea.setBounds(106, 10, 208, 172);
		contentPane.add(textArea);
		
		ReadButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				try {
					Read();
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
					Read();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		};
		new Timer(delay, ScreenRefresher).start();
	}
}
