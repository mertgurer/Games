package game;

import window.Window;
import main.Main;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GamePanel extends JPanel implements ActionListener{

    JButton but;

    public GamePanel(){

        this.setBackground(new Color(0,50,0));
        this.setSize(Window.getW(), Window.getH());
        this.setVisible(false);

        but = new JButton("back");
        but.addActionListener(this);

        this.add(but);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource() == but){
            this.setVisible(false);
            Main.menu.setVisible(true);
        }
        
    }
}
