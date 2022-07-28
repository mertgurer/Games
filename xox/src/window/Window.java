package window;

import javax.swing.*;

public class Window extends JFrame {

    static final int width = 1280;
    static final int height = width / 4 * 3;

    public Window(){
        this.setSize(width, height);
        this.setTitle("XOX");

        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setResizable(false);
        this.setLayout(null);
        this.setLocationRelativeTo(null);
        this.setVisible(true);
    }

    public static int getW(){
        return width;
    }

    public static int getH(){
        return height;
    }
}
