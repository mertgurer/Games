package src.menu;

import javax.swing.*;
import javax.swing.border.Border;
import java.awt.*;

public class BaseButton extends JButton {

    public BaseButton(int x, int y, int width, int height, String name){
        this.setBounds(x, y, width, height);
        this.setText(name);

        this.setBackground(new Color(158, 151, 100));
        this.setForeground(new Color(70,120,80));
        this.setFont(new Font("DialogInput", Font.BOLD, 22));
        this.setBorder(new Border() {

            final int r = 15;

            @Override
            public void paintBorder(Component c, Graphics g, int x, int y, int width, int height) {
                g.drawRoundRect(x, y, width-1, height-1, r, r);
            }

            @Override
            public Insets getBorderInsets(Component c) {
                return new Insets(this.r+1, this.r+1, this.r+2, this.r);
            }

            @Override
            public boolean isBorderOpaque() {
                return true;
            }
        });
        this.setFocusable(false);
    }
}
