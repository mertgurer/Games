package menu;

import javax.swing.*;

import java.awt.*;

public class Button extends JButton {

    static final int width = 250;
    static final int height = 80;

    public Button(int x, int y, String name){
        this.setBounds(x, y, width, height);
        this.setText(name);

        this.setBackground(new Color(84,121,255));
        this.setForeground(new Color(100, 25,25));
        this.setFont(new Font("DialogInput", Font.BOLD, 24));
        this.setBorder(BorderFactory.createRaisedSoftBevelBorder());
        this.setFocusable(false);
    }
}
