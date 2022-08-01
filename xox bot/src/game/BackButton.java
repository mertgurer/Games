package src.game;

import javax.swing.*;
import java.awt.*;

public class BackButton extends JButton {

    public BackButton(int x, int y, int width, int height){
        this.setBounds(x, y, width, height);
        this.setText("<");
        this.setFont(new Font("a", Font.BOLD, 70));

        this.setForeground(Color.black);
        this.setBorderPainted(false);
        this.setContentAreaFilled(false);
        this.setFocusable(false);
    }
}
