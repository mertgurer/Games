package main;

import javax.swing.JFrame;

public class Main {

    public static final int width = 1280;
    public static final int height = width/ 16 * 9;

    public static void main(String[] args){

        JFrame window = new JFrame();
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        window.setSize(width, height);
        window.setResizable(false);
        window.setTitle("XOX");

        GamePanel gamePanel = new GamePanel();
        window.add(gamePanel);

        window.setLocationRelativeTo(null);
        window.setVisible(true);

        gamePanel.startGameThread();
    }
}
