import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.ClassNotFoundException;
import java.lang.Runnable;
import java.lang.Thread;
import java.net.ServerSocket;
import java.net.Socket;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JTextField;
import javax.swing.Timer;
import javax.swing.JButton;

@SuppressWarnings("serial")
public class ServerSocketExample{
    private static final int PORT = 10203;
    private ServerSocket server;
    private ServerSocketExample() {
        try {
            server = new ServerSocket(PORT);
            Socket socket = server.accept();
			new ConnectionHandler(socket);
			System.out.println("Waiting for client message...");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					ServerSocketExample frame = new ServerSocketExample();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
    }


}

class ConnectionHandler implements Runnable {
	public byte buffer[] = new byte[100];;
	public char message[] = new char[100];
    private final Socket socket;
    
    ConnectionHandler(Socket socket) {
    	
        this.socket = socket;
        Thread t = new Thread(this);
        t.start();
    }
    public void run() {
        try {
        	buffer = new byte[100];
        	message = new char[100];
            // Read a message sent by client application
            DataInputStream dis = new DataInputStream(socket.getInputStream());
            dis.read(buffer);
            int m_index = 0;
            for (int i = 0; i < buffer.length;i++) {
            	if ((buffer[i] >= 32 && buffer[i] <= 126)) {
            		message[m_index] = (char)buffer[i];
            		m_index+=1;
            	}
            }
            String output = String.valueOf(message);
            System.out.println(output);
            System.out.println("Message received, closing socket.");
            dis.close();
            socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}