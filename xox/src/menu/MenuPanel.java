package menu;

import window.Window;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MenuPanel extends JPanel implements ActionListener {

    Button playButton;
    Button computerButton;

    public MenuPanel(){
        playButton = new Button((Window.getW()/2) - (Button.width/2), (Window.getH()/2), "Play with Friend");
        playButton.addActionListener(this); 

        computerButton = new Button((Window.getW()/2) - (Button.width/2), (Window.getH()/2 + Button.height + 10), "AI Challenge");
        computerButton.addActionListener(this);

        this.add(playButton);
        this.add(computerButton);

        this.setBackground(new Color(150,150,150));
        this.setSize(Window.getW(), Window.getH());
        this.setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        if(e.getSource() == playButton){
            System.out.println("play");
            
            this.setVisible(false);

            this.setVisible(true);

            
        }
        else if(e.getSource() == computerButton){
            System.out.println("computer");
        }
    }
}