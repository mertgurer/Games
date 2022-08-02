package src.game;

import javax.swing.*;
import java.awt.*;

public class ResetButton extends JButton {

    public ResetButton(int x, int y, int width, int height){
        this.setBounds(x, y, width, height);
        this.setText("Play Again");
        this.setFont(new Font("DialogInput", Font.BOLD, 19));

        this.setForeground(Color.black);
        this.setBackground(new Color(70,120,80));
        this.setFocusable(false);
    }
}